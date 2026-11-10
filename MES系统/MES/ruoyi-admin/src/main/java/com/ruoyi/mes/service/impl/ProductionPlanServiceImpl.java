package com.ruoyi.mes.service.impl;

import java.text.SimpleDateFormat;
import java.util.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.mes.domain.*;
import com.ruoyi.mes.dto.ProductionPlanDTO;
import com.ruoyi.mes.dto.ProductionPlanQueryDTO;
import com.ruoyi.mes.mapper.*;
import com.ruoyi.mes.service.IProductionPlanService;
import com.ruoyi.mes.service.IProcessTaskService;
import com.ruoyi.mes.service.IMaterialPickingService;
import com.ruoyi.mes.vo.InventoryVO;
import com.ruoyi.mes.vo.ProductionPlanVO;

@Service
public class ProductionPlanServiceImpl implements IProductionPlanService
{
    @Autowired private ProductionPlanMapper planMapper;
    @Autowired private SalesOrderMapper salesOrderMapper;
    @Autowired private CustomerMapper customerMapper;
    @Autowired private ProductMapper productMapper;
    @Autowired private InventoryMapper inventoryMapper;
    @Autowired private WorkOrderMapper workOrderMapper;
    @Autowired private IProcessTaskService processTaskService;
    @Autowired private IMaterialPickingService materialPickingService;

    @Override
    public List<ProductionPlanVO> selectProductionPlanList(ProductionPlanQueryDTO query) {
        return planMapper.selectProductionPlanList(query);
    }

    @Override
    public ProductionPlanVO selectProductionPlanById(Long planId) {
        return planMapper.selectProductionPlanById(planId);
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int insertProductionPlan(ProductionPlanDTO dto, String operator) {
        ProductionPlan plan = toEntity(dto);
        if (StringUtils.isBlank(plan.getPlanNo()))
            plan.setPlanNo("PP" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
        if (StringUtils.isBlank(plan.getPlanStatus()))
            plan.setPlanStatus("已审核");
        if (plan.getPriority() == null) plan.setPriority(99);
        if (plan.getIsUrgent() == null) plan.setIsUrgent(0);
        if (plan.getOrderQuantity() == null) plan.setOrderQuantity(0);
        if (plan.getInventoryQuantity() == null) plan.setInventoryQuantity(0);
        if (plan.getSafeStock() == null) plan.setSafeStock(0);

        // 校验计划时间是否超出交货日期
        validatePlanTime(plan);

        // 自动计算 required_quantity
        int req = (plan.getOrderQuantity() + plan.getSafeStock()) - plan.getInventoryQuantity();
        plan.setRequiredQuantity(Math.max(req, 0));

        plan.setCreateBy(operator);
        int result = planMapper.insertProductionPlan(plan);

        // 若计划状态为已审核，自动生成工单（防止重复）
        if ("已审核".equals(plan.getPlanStatus()) && plan.getPlanId() != null) {
            List<WorkOrder> existing = workOrderMapper.selectWorkOrdersByPlanId(plan.getPlanId());
            if (existing == null || existing.isEmpty()) {
                try {
                    this.generateWorkOrder(plan.getPlanId(), operator);
                } catch (Exception e) {
                    System.err.println("自动生成工单失败: " + e.getMessage());
                }
            }
        }

        return result;
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int updateProductionPlan(ProductionPlanDTO dto, String operator) {
        if (dto.getPlanId() == null) throw new ServiceException("计划ID不能为空");
        ProductionPlan plan = toEntity(dto);
        plan.setUpdateBy(operator);

        // 校验计划时间是否超出交货日期
        validatePlanTime(plan);

        // 重新计算 required_quantity
        if (plan.getOrderQuantity() != null) {
            int inv = plan.getInventoryQuantity() != null ? plan.getInventoryQuantity() : 0;
            int safe = plan.getSafeStock() != null ? plan.getSafeStock() : 0;
            plan.setRequiredQuantity(Math.max((plan.getOrderQuantity() + safe) - inv, 0));
        }

        int result = planMapper.updateProductionPlan(plan);

        // 如果是紧急插单，重新排产
        if (dto.getIsUrgent() != null && dto.getIsUrgent() == 1) {
            reschedule();
        }

        return result;
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int deleteProductionPlanByIds(String ids) {
        Long[] arr = Convert.toLongArray(ids);
        if (arr.length == 0) throw new ServiceException("请选择要删除的计划");
        return planMapper.deleteProductionPlanByIds(arr);
    }

    @Override
    public List<ProductionPlan> selectProductionPlanExportList(ProductionPlanQueryDTO query) {
        List<ProductionPlanVO> vos = planMapper.selectProductionPlanList(query);
        List<ProductionPlan> list = new ArrayList<>();
        for (ProductionPlanVO vo : vos) {
            ProductionPlan p = new ProductionPlan();
            BeanUtils.copyProperties(vo, p);
            list.add(p);
        }
        return list;
    }

    @Override
    public boolean checkPlanNoUnique(ProductionPlanDTO dto) {
        Long planId = StringUtils.isNull(dto.getPlanId()) ? -1L : dto.getPlanId();
        ProductionPlan info = planMapper.selectProductionPlanByNo(dto.getPlanNo());
        return !(StringUtils.isNotNull(info) && info.getPlanId().longValue() != planId.longValue());
    }

    /** 从销售订单自动创建生产计划 */
    @Override @Transactional(rollbackFor = Exception.class)
    public ProductionPlan createFromSalesOrder(SalesOrder order) {
        // 检查是否已存在计划，防止重复生成
        List<ProductionPlan> existingPlans = planMapper.selectProductionPlanEntityByOrderId(order.getOrderId());
        if (existingPlans != null && !existingPlans.isEmpty()) {
            return existingPlans.get(0);
        }

        ProductionPlan plan = new ProductionPlan();
        plan.setPlanNo("PP" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
        plan.setSalesOrderId(order.getOrderId());
        plan.setCustomerId(order.getCustomerId());
        plan.setProductId(order.getProductId());
        plan.setOrderQuantity(order.getQuantity());

        // 查询当前库存
        int inventoryQty = getProductInventory(order.getProductId());
        plan.setInventoryQuantity(inventoryQty);
        plan.setSafeStock(50); // 默认安全库存

        // required_quantity = (order_quantity + safe_stock) - inventory_quantity
        int req = (order.getQuantity() + 50) - inventoryQty;
        plan.setRequiredQuantity(Math.max(req, 0));

        // 优先级：根据客户优先级
        int priority = 99;
        if (order.getCustomerId() != null) {
            Customer customer = customerMapper.selectCustomerEntityById(order.getCustomerId());
            if (customer != null && customer.getCustomerPriority() != null) {
                priority = customer.getCustomerPriority();
            }
        }
        plan.setPriority(priority);
        plan.setIsUrgent(order.getIsUrgent() != null ? order.getIsUrgent() : 0);
        plan.setPlanStatus("已审核");
        plan.setCreateBy("SYSTEM");

        planMapper.insertProductionPlan(plan);

        // 重新排产
        reschedule();

        return plan;
    }

    /** 校验计划时间不能超出销售订单交货日期 */
    private void validatePlanTime(ProductionPlan plan) {
        if (plan.getSalesOrderId() == null) return; // 未关联订单时不校验
        if (plan.getPlanStartTime() == null && plan.getPlanEndTime() == null) return;

        SalesOrder order = salesOrderMapper.selectSalesOrderEntityById(plan.getSalesOrderId());
        if (order == null || order.getDueDate() == null) return;

        Date dueDate = order.getDueDate();

        if (plan.getPlanStartTime() != null && plan.getPlanStartTime().after(dueDate)) {
            throw new ServiceException("计划开始时间(" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(plan.getPlanStartTime())
                + ")不能晚于交货日期(" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dueDate) + ")");
        }
        if (plan.getPlanEndTime() != null) {
            if (plan.getPlanEndTime().after(dueDate)) {
                throw new ServiceException("计划结束时间(" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(plan.getPlanEndTime())
                    + ")不能晚于交货日期(" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dueDate) + ")");
            }
            if (plan.getPlanStartTime() != null && plan.getPlanEndTime().before(plan.getPlanStartTime())) {
                throw new ServiceException("计划结束时间(" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(plan.getPlanEndTime())
                    + ")不能早于计划开始时间(" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(plan.getPlanStartTime()) + ")");
            }
        }
    }

    /** 重新排产：按紧急→客户优先级→创建时间排序，计算预计时间 */
    private void reschedule() {
        // 仅排产已审核的计划
        List<ProductionPlan> all = new ArrayList<>();
        for (ProductionPlanVO vo : planMapper.selectProductionPlanList(new ProductionPlanQueryDTO())) {
            if ("已审核".equals(vo.getPlanStatus())) {
                ProductionPlan entity = planMapper.selectProductionPlanEntityById(vo.getPlanId());
                if (entity != null) all.add(entity);
            }
        }

        // 排序：紧急优先 → 客户优先级 → 创建时间
        all.sort(Comparator
            .comparing(ProductionPlan::getIsUrgent, Comparator.nullsLast(Comparator.reverseOrder()))
            .thenComparing(ProductionPlan::getPriority, Comparator.nullsLast(Comparator.naturalOrder()))
            .thenComparing(ProductionPlan::getCreateTime, Comparator.nullsLast(Comparator.naturalOrder())));

        // 重新分配预计时间
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_YEAR, 1);
        for (ProductionPlan pp : all) {
            pp.setPlanStartTime(cal.getTime());
            cal.add(Calendar.DAY_OF_YEAR, 1);
            pp.setPlanEndTime(cal.getTime());
            pp.setUpdateBy("SYSTEM");
            planMapper.updateProductionPlan(pp);
        }
    }

    private int getProductInventory(Long productId) {
        if (productId == null) return 0;
        Product product = productMapper.selectProductEntityById(productId);
        if (product == null || product.getProductCode() == null) return 0;
        List<InventoryVO> list = inventoryMapper.selectInventoryList(null);
        if (list == null) return 0;
        for (InventoryVO inv : list) {
            if ("成品".equals(inv.getInventoryType())
                && product.getProductCode().equals(inv.getMaterialCode())
                && inv.getQuantity() != null) {
                return inv.getQuantity().intValue();
            }
        }
        return 0;
    }

    /** 审核生产计划（已废弃：计划创建后直接为已审核状态） */
    @Override @Transactional(rollbackFor = Exception.class)
    public int auditProductionPlan(Long planId, String operator) {
        ProductionPlan plan = planMapper.selectProductionPlanEntityById(planId);
        if (plan == null) throw new ServiceException("生产计划不存在");
        // 计划创建后自动为已审核状态，无需人工审核
        if (!"已审核".equals(plan.getPlanStatus()))
            throw new ServiceException("当前计划状态为" + plan.getPlanStatus() + "，无需审核操作");
        return 1;
    }

    /** 更新时间 */
    @Override @Transactional(rollbackFor = Exception.class)
    public int updatePlanTime(Long planId, Date planStartTime, Date planEndTime, String operator) {
        if (planId == null) throw new ServiceException("计划ID不能为空");
        ProductionPlan plan = planMapper.selectProductionPlanEntityById(planId);
        if (plan == null) throw new ServiceException("生产计划不存在");

        plan.setPlanStartTime(planStartTime);
        plan.setPlanEndTime(planEndTime);
        plan.setUpdateBy(operator);

        // 校验计划时间是否超出交货日期
        validatePlanTime(plan);

        return planMapper.updateProductionPlan(plan);
    }

    /** 生成工单 */
    @Override @Transactional(rollbackFor = Exception.class)
    public int generateWorkOrder(Long planId, String operator) {
        ProductionPlan plan = planMapper.selectProductionPlanEntityById(planId);
        if (plan == null) throw new ServiceException("生产计划不存在");
        if (!"已审核".equals(plan.getPlanStatus()))
            throw new ServiceException("当前计划状态不允许生成工单，仅已审核状态可生成");

        WorkOrder wo = new WorkOrder();
        wo.setWorkOrderNo("WO" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
        wo.setPlanId(planId);
        wo.setOrderId(plan.getSalesOrderId());
        wo.setPlannedQty(plan.getRequiredQuantity() != null && plan.getRequiredQuantity() > 0
            ? plan.getRequiredQuantity() : plan.getOrderQuantity());
        wo.setCompletedQty(0);
        wo.setStatus("WAITING");
        wo.setCurrentStep(1);
        wo.setTotalSteps(7);
        wo.setCreateBy(operator);
        workOrderMapper.insertWorkOrder(wo);

        // 自动初始化7道工序
        processTaskService.initProcessTasks(wo.getWorkOrderId(), wo.getPlannedQty(), operator);

        // 自动生成领料单（BOM展开）
        try {
            materialPickingService.createPickingByWorkOrder(wo.getWorkOrderId(), operator);
        } catch (Exception e) {
            // 领料单生成失败不回滚工单创建
            System.err.println("自动生成领料单失败: " + e.getMessage());
        }

        // 更新计划状态为已排产
        plan.setPlanStatus("已排产");
        plan.setUpdateBy(operator);
        planMapper.updateProductionPlan(plan);

        return 1;
    }

    private ProductionPlan toEntity(ProductionPlanDTO dto) {
        ProductionPlan plan = new ProductionPlan();
        BeanUtils.copyProperties(dto, plan);
        return plan;
    }
}
