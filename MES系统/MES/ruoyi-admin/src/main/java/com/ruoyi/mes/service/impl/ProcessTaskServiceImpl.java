package com.ruoyi.mes.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.mes.domain.ProcessTask;
import com.ruoyi.mes.mapper.ProcessTaskMapper;
import com.ruoyi.mes.mapper.WorkOrderMapper;
import com.ruoyi.mes.mapper.InventoryMapper;
import com.ruoyi.mes.mapper.MaterialPickingMapper;
import com.ruoyi.mes.mapper.WarehousingMapper;
import com.ruoyi.mes.mapper.ProductionPlanMapper;
import com.ruoyi.mes.mapper.ProductMapper;
import com.ruoyi.mes.service.IProcessTaskService;
import com.ruoyi.mes.domain.WorkOrder;
import com.ruoyi.mes.domain.Inventory;
import com.ruoyi.mes.domain.MaterialPicking;
import com.ruoyi.mes.domain.Warehousing;
import com.ruoyi.mes.domain.WarehousingDetail;
import com.ruoyi.mes.domain.ProductionPlan;
import com.ruoyi.mes.domain.Product;

@Service
public class ProcessTaskServiceImpl implements IProcessTaskService
{
    private static final String[] PROCESS_NAMES = {
        "原材料领料", "CNC加工", "打磨处理", "喷砂/氧化",
        "组装", "功能检测", "包装入库"
    };

    @Autowired private ProcessTaskMapper taskMapper;
    @Autowired private WorkOrderMapper workOrderMapper;
    @Autowired private InventoryMapper inventoryMapper;
    @Autowired private MaterialPickingMapper pickingMapper;
    @Autowired private WarehousingMapper warehousingMapper;
    @Autowired private ProductionPlanMapper planMapper;
    @Autowired private ProductMapper productMapper;

    @Override public List<ProcessTask> getTasksByWorkOrder(Long workOrderId) {
        return taskMapper.selectByWorkOrderId(workOrderId);
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public void initProcessTasks(Long workOrderId, Integer plannedQty, String operator) {
        // 检查是否已存在工序任务，避免重复删除
        List<ProcessTask> existing = taskMapper.selectByWorkOrderId(workOrderId);
        if (existing != null && !existing.isEmpty()) {
            // 已有工序任务，只需更新工单 currentStep（重新开始）
            WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(workOrderId);
            if (wo != null) {
                wo.setCurrentStep(1);
                wo.setStatus("RUNNING");
                workOrderMapper.updateWorkOrder(wo);
            }
            // 将第一道工序设为 READY
            ProcessTask first = existing.stream().filter(t -> t.getProcessSeq() == 1).findFirst().orElse(null);
            if (first != null && "WAITING".equals(first.getStatus())) {
                first.setStatus("READY");
                taskMapper.update(first);
            }
            return;
        }

        taskMapper.deleteByWorkOrderId(workOrderId);
        List<ProcessTask> tasks = new ArrayList<>();
        for (int i = 0; i < PROCESS_NAMES.length; i++) {
            ProcessTask t = new ProcessTask();
            t.setWorkOrderId(workOrderId);
            t.setProcessName(PROCESS_NAMES[i]);
            t.setProcessSeq(i + 1);
            // 第一道工序设为 READY，其余 WAITING
            t.setStatus(i == 0 ? "READY" : "WAITING");
            t.setPlannedQty(plannedQty);
            t.setGoodQty(0);
            t.setBadQty(0);
            t.setCreateBy(operator);
            tasks.add(t);
        }
        taskMapper.batchInsert(tasks);

        // 更新工单：currentStep=1, totalSteps=7, status=RUNNING
        WorkOrder wo = new WorkOrder();
        wo.setWorkOrderId(workOrderId);
        wo.setCurrentStep(1);
        wo.setTotalSteps(PROCESS_NAMES.length);
        wo.setStatus("RUNNING");
        workOrderMapper.updateWorkOrder(wo);
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public ProcessTask startTask(Long taskId, Long operatorId, Long equipmentId) {
        ProcessTask task = taskMapper.selectById(taskId);
        if (task == null) throw new ServiceException("工序任务不存在");
        if (!"WAITING".equals(task.getStatus()) && !"READY".equals(task.getStatus()) && !"PAUSED".equals(task.getStatus()))
            throw new ServiceException("当前工序状态不允许开工");

        // 第一道工序开工前校验是否已完成领料
        if (task.getProcessSeq() != null && task.getProcessSeq() == 1) {
            MaterialPicking picking = pickingMapper.selectMaterialPickingByWorkOrderId(task.getWorkOrderId());
            if (picking == null) throw new ServiceException("未生成领料单，请先生成领料单");
            if (!"FINISHED".equals(picking.getPickingStatus()))
                throw new ServiceException("请先完成领料");
        }

        task.setStatus("RUNNING");
        task.setOperatorId(operatorId);
        task.setEquipmentId(equipmentId);
        task.setStartTime(new Date());
        taskMapper.update(task);

        // 同步工单状态
        WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(task.getWorkOrderId());
        if (wo != null) {
            wo.setStatus("RUNNING");
            workOrderMapper.updateWorkOrder(wo);
        }
        return task;
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public ProcessTask finishTask(Long taskId, Integer goodQty, Integer badQty) {
        ProcessTask task = taskMapper.selectById(taskId);
        if (task == null) throw new ServiceException("工序任务不存在");
        if (!"RUNNING".equals(task.getStatus()))
            throw new ServiceException("当前工序状态不允许完工");

        task.setStatus("FINISHED");
        task.setGoodQty(goodQty != null ? goodQty : task.getPlannedQty());
        task.setBadQty(badQty != null ? badQty : 0);
        task.setEndTime(new Date());
        taskMapper.update(task);

        Long woId = task.getWorkOrderId();
        int nextSeq = task.getProcessSeq() + 1;

        // 非最后工序完成 → 自动推进到下一工序（设为 READY）
        if (task.getProcessSeq() != null && task.getProcessSeq() < 7) {
            ProcessTask nextTask = taskMapper.selectCurrentTask(woId, nextSeq);
            if (nextTask != null) {
                nextTask.setStatus("READY");
                taskMapper.update(nextTask);
                WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(woId);
                if (wo != null) {
                    wo.setCurrentStep(nextSeq);
                    workOrderMapper.updateWorkOrder(wo);
                }
            }
        }

        // 最后一道工序（包装入库）完成 → 工单完工 + 入库 + 更新生产计划
        if (task.getProcessSeq() != null && task.getProcessSeq() == 7) {
            WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(woId);
            if (wo != null) {
                wo.setStatus("FINISHED");
                wo.setCurrentStep(7);
                wo.setCompletedQty(task.getGoodQty());
                workOrderMapper.updateWorkOrder(wo);

                autoGenerateWarehousing(wo, task.getGoodQty());

                // 同步更新生产计划状态
                if (wo.getPlanId() != null) {
                    ProductionPlan plan = planMapper.selectProductionPlanEntityById(wo.getPlanId());
                    if (plan != null && !"FINISHED".equals(plan.getPlanStatus())) {
                        plan.setPlanStatus("FINISHED");
                        planMapper.updateProductionPlan(plan);
                    }
                }
            }
        }
        return task;
    }

    /** 自动生成入库单并确认入库，增加成品库存 */
    private void autoGenerateWarehousing(WorkOrder wo, int qty) {
        try {
            // 检查是否已存在入库单
            Warehousing exist = warehousingMapper.selectWarehousingByWorkOrderId(wo.getWorkOrderId());
            if (exist != null) return;

            String productCode = null;
            String productName = null;

            Warehousing wh = new Warehousing();
            wh.setWarehousingNo("WH" + new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date()));
            wh.setWorkOrderId(wo.getWorkOrderId());
            wh.setWorkOrderNo(wo.getWorkOrderNo());
            wh.setPlanId(wo.getPlanId());
            wh.setWarehousingType("FINISHED");
            wh.setWarehousingStatus("FINISHED");
            wh.setInspectResult("PASS");
            wh.setWarehousingBy("SYSTEM");
            wh.setWarehousingTime(new java.util.Date());
            wh.setLocation("成品仓");
            wh.setCreateBy("SYSTEM");
            warehousingMapper.insertWarehousing(wh);

            // 创建入库明细
            WarehousingDetail detail = new WarehousingDetail();
            detail.setWarehousingId(wh.getWarehousingId());
            if (wo.getPlanId() != null) {
                ProductionPlan plan = planMapper.selectProductionPlanEntityById(wo.getPlanId());
                if (plan != null && plan.getProductId() != null) {
                    Product product = productMapper.selectProductEntityById(plan.getProductId());
                    if (product != null) {
                        productCode = product.getProductCode();
                        productName = product.getProductName();
                        detail.setProductCode(productCode);
                        detail.setProductName(productName);
                    }
                }
            }
            detail.setQuantity(new java.math.BigDecimal(qty));
            detail.setUnit("个");
            detail.setLocation("成品仓");
            warehousingMapper.insertWarehousingDetail(detail);

            // 自动增加成品库存（累加逻辑）
            if (productCode != null) {
                com.ruoyi.mes.dto.InventoryQueryDTO q = new com.ruoyi.mes.dto.InventoryQueryDTO();
                q.setMaterialCode(productCode);
                java.util.List<com.ruoyi.mes.vo.InventoryVO> existingList = inventoryMapper.selectInventoryList(q);
                if (existingList != null && !existingList.isEmpty()) {
                    com.ruoyi.mes.vo.InventoryVO vo = existingList.get(0);
                    com.ruoyi.mes.domain.Inventory existingInv = inventoryMapper.selectInventoryEntityById(vo.getInventoryId());
                    if (existingInv != null) {
                        java.math.BigDecimal newQty = existingInv.getQuantity().add(new java.math.BigDecimal(qty));
                        inventoryMapper.updateInventoryQuantity(existingInv.getInventoryId(), newQty);
                    }
                } else {
                    Inventory inv = new Inventory();
                    inv.setInventoryType("成品");
                    inv.setMaterialCode(productCode);
                    inv.setMaterialName(productName);
                    inv.setQuantity(new java.math.BigDecimal(qty));
                    inv.setLocation("成品仓");
                    inv.setCreateBy("SYSTEM");
                    inventoryMapper.insertInventory(inv);
                }
            }
        } catch (Exception e) {
            System.err.println("自动生成入库单失败: " + e.getMessage());
        }
    }

    @Override
    public List<ProcessTask> getAllTasks(ProcessTask task) {
        return taskMapper.selectAllTasks(task);
    }

    @Override
    public void updateTask(ProcessTask task) {
        taskMapper.update(task);
    }

    @Override
    public void autoGenerateWarehousingForFinish(WorkOrder wo, int qty) {
        autoGenerateWarehousing(wo, qty);
    }

    @Override
    public int getProgress(Long workOrderId) {
        List<ProcessTask> tasks = taskMapper.selectByWorkOrderId(workOrderId);
        if (tasks.isEmpty()) return 0;
        long finished = tasks.stream().filter(t -> "FINISHED".equals(t.getStatus())).count();
        return (int) (finished * 100 / tasks.size());
    }
}
