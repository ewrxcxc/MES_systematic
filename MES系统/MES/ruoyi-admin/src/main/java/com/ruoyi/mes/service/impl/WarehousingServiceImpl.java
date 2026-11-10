package com.ruoyi.mes.service.impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.mes.domain.*;
import com.ruoyi.mes.mapper.*;
import com.ruoyi.mes.service.IWarehousingService;
import com.ruoyi.mes.mapper.QualityRecordMapper;
import com.ruoyi.mes.domain.QualityRecord;
import java.text.SimpleDateFormat;

@Service
public class WarehousingServiceImpl implements IWarehousingService
{
    @Autowired private WarehousingMapper warehousingMapper;
    @Autowired private WorkOrderMapper workOrderMapper;
    @Autowired private InventoryMapper inventoryMapper;
    @Autowired private ProductionPlanMapper planMapper;
    @Autowired private ProductMapper productMapper;
    @Autowired private QualityTraceMapper traceMapper;
    @Autowired private SalesOrderMapper salesOrderMapper;
    @Autowired private QualityRecordMapper qualityRecordMapper;

    @Override
    public List<Warehousing> selectWarehousingList(Warehousing warehousing) {
        return warehousingMapper.selectWarehousingList(warehousing);
    }

    @Override
    public Warehousing selectWarehousingById(Long warehousingId) {
        return warehousingMapper.selectWarehousingById(warehousingId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertWarehousing(Warehousing wh, String operator) {
        WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(wh.getWorkOrderId());
        if (wo == null) throw new ServiceException("工单不存在");
        if (!"FINISHED".equals(wo.getStatus()) && !"RUNNING".equals(wo.getStatus()))
            throw new ServiceException("工单状态不允许入库");

        // 检查是否已存在入库单
        Warehousing exist = warehousingMapper.selectWarehousingByWorkOrderId(wh.getWorkOrderId());
        if (exist != null) throw new ServiceException("该工单已生成入库单：" + exist.getWarehousingNo());

        // 检查该工单是否已通过质检
        QualityRecord qr = qualityRecordMapper.selectPassByWorkOrderId(wh.getWorkOrderId());
        if (qr == null) throw new ServiceException("该工单未通过质检，无法入库。请先在质检管理中创建合格记录。");

        if (wh.getWarehousingNo() == null || wh.getWarehousingNo().isEmpty())
            wh.setWarehousingNo("WH" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
        wh.setWorkOrderNo(wo.getWorkOrderNo());
        wh.setPlanId(wo.getPlanId());
        wh.setWarehousingStatus("WAITING");
        wh.setCreateBy(operator);
        int result = warehousingMapper.insertWarehousing(wh);

        // 创建入库明细
        WarehousingDetail detail = new WarehousingDetail();
        detail.setWarehousingId(wh.getWarehousingId());
        ProductionPlan plan = planMapper.selectProductionPlanEntityById(wo.getPlanId());
        if (plan != null) {
            Product product = productMapper.selectProductEntityById(plan.getProductId());
            if (product != null) {
                detail.setProductCode(product.getProductCode());
                detail.setProductName(product.getProductName());
                wh.setProductId(product.getProductId());
            }
        }
        detail.setQuantity(BigDecimal.valueOf(wo.getCompletedQty() != null ? wo.getCompletedQty() : wo.getPlannedQty()));
        detail.setUnit("个");
        detail.setLocation(wh.getLocation());
        warehousingMapper.insertWarehousingDetail(detail);

        return result;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int doInspect(Long warehousingId, String inspector, String inspectResult, String operator) {
        Warehousing wh = warehousingMapper.selectWarehousingById(warehousingId);
        if (wh == null) throw new ServiceException("入库单不存在");
        if (!"WAITING".equals(wh.getWarehousingStatus()))
            throw new ServiceException("当前状态不允许质检");
        wh.setWarehousingStatus("CHECKING");
        wh.setInspector(inspector);
        wh.setInspectResult(inspectResult);
        wh.setUpdateBy(operator);
        return warehousingMapper.updateWarehousing(wh);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int confirmWarehousing(Long warehousingId, String warehousingBy, String location, String operator) {
        Warehousing wh = warehousingMapper.selectWarehousingById(warehousingId);
        if (wh == null) throw new ServiceException("入库单不存在");
        if (!"CHECKING".equals(wh.getWarehousingStatus()) && !"WAITING".equals(wh.getWarehousingStatus()))
            throw new ServiceException("当前状态不允许确认入库");

        // 如果还未质检，自动通过
        if ("WAITING".equals(wh.getWarehousingStatus())) {
            wh.setInspectResult("PASS");
        }
        if ("FAIL".equals(wh.getInspectResult()))
            throw new ServiceException("质检不合格，无法入库");

        // 更新入库单
        wh.setWarehousingStatus("FINISHED");
        wh.setWarehousingBy(warehousingBy);
        wh.setWarehousingTime(new Date());
        if (location != null && !location.isEmpty()) wh.setLocation(location);
        wh.setUpdateBy(operator);
        warehousingMapper.updateWarehousing(wh);

        // 增加库存（累加模式：同产品编码的库存累加而非新建记录）
        List<WarehousingDetail> details = warehousingMapper.selectWarehousingDetailsByWarehousingId(warehousingId);
        for (WarehousingDetail detail : details) {
            if (detail.getProductCode() == null) continue;
            com.ruoyi.mes.dto.InventoryQueryDTO q = new com.ruoyi.mes.dto.InventoryQueryDTO();
            q.setMaterialCode(detail.getProductCode());
            List<com.ruoyi.mes.vo.InventoryVO> existingList = inventoryMapper.selectInventoryList(q);
            if (existingList != null && !existingList.isEmpty()) {
                com.ruoyi.mes.vo.InventoryVO vo = existingList.get(0);
                Inventory existingInv = inventoryMapper.selectInventoryEntityById(vo.getInventoryId());
                if (existingInv != null) {
                    BigDecimal newQty = existingInv.getQuantity().add(detail.getQuantity());
                    inventoryMapper.updateInventoryQuantity(existingInv.getInventoryId(), newQty);
                }
            } else {
                Inventory inv = new Inventory();
                inv.setInventoryType("成品");
                inv.setMaterialCode(detail.getProductCode());
                inv.setMaterialName(detail.getProductName());
                inv.setQuantity(detail.getQuantity());
                inv.setLocation(detail.getLocation() != null ? detail.getLocation() : "成品仓");
                inv.setCreateBy(operator);
                inventoryMapper.insertInventory(inv);
            }
        }

        // 更新工单状态
        WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(wh.getWorkOrderId());
        if (wo != null) {
            wo.setStatus("FINISHED");
            wo.setUpdateBy(operator);
            workOrderMapper.updateWorkOrder(wo);

            // 更新生产计划状态为已完成
            if (wo.getPlanId() != null) {
                ProductionPlan plan = planMapper.selectProductionPlanEntityById(wo.getPlanId());
                if (plan != null) {
                    plan.setPlanStatus("已完成");
                    plan.setUpdateBy(operator);
                    planMapper.updateProductionPlan(plan);
                }
            }

            // 更新销售订单状态为已完成
            if (wo.getOrderId() != null) {
                SalesOrder order = salesOrderMapper.selectSalesOrderEntityById(wo.getOrderId());
                if (order != null) {
                    order.setOrderStatus("已完成");
                    order.setUpdateBy(operator);
                    salesOrderMapper.updateSalesOrder(order);
                }
            }

            // 自动生成质量追溯记录
            autoGenerateTrace(wo, wh);
        }

        return 1;
    }

    /** 自动生成质量追溯记录 */
    private void autoGenerateTrace(WorkOrder wo, Warehousing wh) {
        try {
            QualityTrace trace = new QualityTrace();
            trace.setTraceType("WORK_ORDER");
            trace.setTraceKey(wo.getWorkOrderNo());
            trace.setWorkOrderId(wo.getWorkOrderId());
            trace.setWorkOrderNo(wo.getWorkOrderNo());
            trace.setPlanId(wo.getPlanId());
            trace.setOrderId(wo.getOrderId());
            trace.setProductionDate(new Date());
            trace.setInspector(wh.getInspector());
            trace.setInspectResult(wh.getInspectResult() != null ? wh.getInspectResult() : "PASS");

            // 获取产品信息
            if (wo.getPlanId() != null) {
                ProductionPlan plan = planMapper.selectProductionPlanEntityById(wo.getPlanId());
                if (plan != null) {
                    trace.setPlanNo(plan.getPlanNo());
                    if (plan.getProductId() != null) {
                        trace.setProductId(plan.getProductId());
                        Product product = productMapper.selectProductEntityById(plan.getProductId());
                        if (product != null) {
                            trace.setProductCode(product.getProductCode());
                        }
                    }
                    if (plan.getSalesOrderId() != null) {
                        SalesOrder order = salesOrderMapper.selectSalesOrderEntityById(plan.getSalesOrderId());
                        if (order != null) {
                            trace.setOrderNo(order.getOrderNo());
                        }
                    }
                }
            }

            // 批次号
            trace.setBatchNo("BT" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
            trace.setCreateTime(new Date());
            traceMapper.insertQualityTrace(trace);
        } catch (Exception e) {
            System.err.println("自动生成追溯记录失败: " + e.getMessage());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteWarehousingByIds(String ids) {
        Long[] idArray = Convert.toLongArray(ids);
        if (idArray.length == 0) throw new ServiceException("请选择要删除的入库单");
        for (Long id : idArray) {
            warehousingMapper.deleteWarehousingDetailsByWarehousingId(id);
        }
        return warehousingMapper.deleteWarehousingByIds(idArray);
    }

    @Override
    public List<WarehousingDetail> selectWarehousingDetails(Long warehousingId) {
        return warehousingMapper.selectWarehousingDetailsByWarehousingId(warehousingId);
    }
}
