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
import com.ruoyi.mes.dto.InventoryQueryDTO;
import com.ruoyi.mes.service.IMaterialPickingService;
import com.ruoyi.mes.vo.BomVO;
import com.ruoyi.mes.vo.InventoryVO;

@Service
public class MaterialPickingServiceImpl implements IMaterialPickingService
{
    @Autowired private MaterialPickingMapper pickingMapper;
    @Autowired private WorkOrderMapper workOrderMapper;
    @Autowired private ProductionPlanMapper planMapper;
    @Autowired private BomMapper bomMapper;
    @Autowired private ProductMapper productMapper;
    @Autowired private InventoryMapper inventoryMapper;
    @Autowired private ProcessTaskMapper processTaskMapper;

    @Override
    public List<MaterialPicking> selectMaterialPickingList(MaterialPicking picking) {
        return pickingMapper.selectMaterialPickingList(picking);
    }

    @Override
    public MaterialPicking selectMaterialPickingById(Long pickingId) {
        return pickingMapper.selectMaterialPickingById(pickingId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public MaterialPicking createPickingByWorkOrder(Long workOrderId, String operator) {
        WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(workOrderId);
        if (wo == null) throw new ServiceException("工单不存在");

        MaterialPicking exist = pickingMapper.selectMaterialPickingByWorkOrderId(workOrderId);
        if (exist != null) throw new ServiceException("该工单已生成领料单：" + exist.getPickingNo());

        ProductionPlan plan = planMapper.selectProductionPlanEntityById(wo.getPlanId());
        if (plan == null) throw new ServiceException("生产计划不存在");

        Product product = productMapper.selectProductEntityById(plan.getProductId());
        if (product == null) throw new ServiceException("产品不存在");

        List<BomVO> bomList = bomMapper.selectBomByProductId(plan.getProductId());
        if (bomList == null || bomList.isEmpty()) throw new ServiceException("该产品无BOM，无法生成领料单");

        MaterialPicking picking = new MaterialPicking();
        picking.setPickingNo("MP" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
        picking.setWorkOrderId(workOrderId);
        picking.setWorkOrderNo(wo.getWorkOrderNo());
        picking.setPlanId(wo.getPlanId());
        picking.setPickingStatus("PENDING");
        picking.setCreateBy(operator);
        pickingMapper.insertMaterialPicking(picking);

        Integer plannedQty = wo.getPlannedQty() != null ? wo.getPlannedQty() : 1;
        for (BomVO bom : bomList) {
            MaterialPickingDetail detail = new MaterialPickingDetail();
            detail.setPickingId(picking.getPickingId());
            detail.setMaterialCode(bom.getMaterialCode());
            detail.setMaterialName(bom.getMaterialName());
            detail.setBomUsage(bom.getUsageQty());
            BigDecimal required = bom.getUsageQty() != null
                ? bom.getUsageQty().multiply(BigDecimal.valueOf(plannedQty))
                : BigDecimal.valueOf(plannedQty);
            detail.setRequiredQty(required);
            detail.setActualQty(BigDecimal.ZERO);
            detail.setUnit("个");
            detail.setStatus("PENDING");
            pickingMapper.insertPickingDetail(detail);
        }

        return picking;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int confirmPicking(Long pickingId, String pickingBy, List<MaterialPickingDetail> details, String operator) {
        MaterialPicking picking = pickingMapper.selectMaterialPickingById(pickingId);
        if (picking == null) throw new ServiceException("领料单不存在");
        if (!"PENDING".equals(picking.getPickingStatus()) && !"PROCESSING".equals(picking.getPickingStatus()))
            throw new ServiceException("当前状态不允许领料");

        if (details == null || details.isEmpty())
            throw new ServiceException("请填写领料明细");

        int finishedCount = 0;
        int totalCount = details.size();

        for (MaterialPickingDetail d : details) {
            if (d.getActualQty() == null || d.getActualQty().compareTo(BigDecimal.ZERO) <= 0)
                throw new ServiceException("实发数量必须大于0：" + d.getMaterialName());

            // 查询当前库存
            InventoryQueryDTO queryDTO = new InventoryQueryDTO();
            queryDTO.setMaterialCode(d.getMaterialCode());
            List<InventoryVO> invList = inventoryMapper.selectInventoryList(queryDTO);
            if (invList == null || invList.isEmpty())
                throw new ServiceException("物料库存不足：" + d.getMaterialName());

            InventoryVO invVO = invList.get(0);
            if (invVO.getQuantity().compareTo(d.getActualQty()) < 0)
                throw new ServiceException("库存不足：" + d.getMaterialName()
                    + "，当前库存：" + invVO.getQuantity() + "，实发数量：" + d.getActualQty());

            // 扣减库存
            BigDecimal newQty = invVO.getQuantity().subtract(d.getActualQty());
            inventoryMapper.updateInventoryQuantity(invVO.getInventoryId(), newQty);

            // 记录库存出库（更新inventory_id到明细）
            d.setInventoryId(invVO.getInventoryId());

            // 判断是否完全领料
            if (d.getActualQty().compareTo(d.getRequiredQty()) >= 0) {
                d.setStatus("FINISHED");
                finishedCount++;
            } else {
                d.setStatus("PROCESSING");
            }
            pickingMapper.updatePickingDetail(d);
        }

        // 更新领料单主表状态
        if (finishedCount == totalCount) {
            picking.setPickingStatus("FINISHED");
        } else {
            picking.setPickingStatus("PROCESSING");
        }
        picking.setPickingBy(pickingBy);
        picking.setPickingTime(new Date());
        picking.setUpdateBy(operator);
        int result = pickingMapper.updateMaterialPicking(picking);

        // 领料全部完成 → 自动完成工序①（原材料领料）并推进到工序②
        if (finishedCount == totalCount && picking.getWorkOrderId() != null) {
            autoCompleteProcessOne(picking.getWorkOrderId(), operator);
        }
        return result;
    }

    /** 领料完成后自动完成工序①，推进到工序② */
    private void autoCompleteProcessOne(Long workOrderId, String operator) {
        try {
            List<ProcessTask> tasks = processTaskMapper.selectByWorkOrderId(workOrderId);
            if (tasks == null || tasks.isEmpty()) return;

            ProcessTask task1 = tasks.stream()
                .filter(t -> t.getProcessSeq() != null && t.getProcessSeq() == 1)
                .findFirst().orElse(null);
            if (task1 == null || "FINISHED".equals(task1.getStatus())) return;

            // 完成工序①
            task1.setStatus("FINISHED");
            task1.setGoodQty(task1.getPlannedQty());
            task1.setBadQty(0);
            task1.setEndTime(new Date());
            task1.setUpdateBy(operator);
            processTaskMapper.update(task1);

            // 推进到工序②（设为 READY）
            ProcessTask task2 = tasks.stream()
                .filter(t -> t.getProcessSeq() != null && t.getProcessSeq() == 2)
                .findFirst().orElse(null);
            if (task2 != null) {
                task2.setStatus("READY");
                processTaskMapper.update(task2);
            }

            // 更新工单 currentStep = 2
            WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(workOrderId);
            if (wo != null) {
                wo.setCurrentStep(2);
                workOrderMapper.updateWorkOrder(wo);
            }
        } catch (Exception e) {
            System.err.println("自动完成领料工序失败: " + e.getMessage());
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteMaterialPickingByIds(String ids) {
        Long[] idArray = Convert.toLongArray(ids);
        if (idArray.length == 0) throw new ServiceException("请选择要删除的领料单");
        for (Long id : idArray) {
            pickingMapper.deletePickingDetailsByPickingId(id);
        }
        return pickingMapper.deleteMaterialPickingByIds(idArray);
    }

    @Override
    public List<MaterialPickingDetail> selectPickingDetails(Long pickingId) {
        return pickingMapper.selectPickingDetailsByPickingId(pickingId);
    }
}
