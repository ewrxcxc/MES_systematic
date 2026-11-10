package com.ruoyi.mes.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.mes.domain.WorkOrder;
import com.ruoyi.mes.dto.WorkOrderDTO;
import com.ruoyi.mes.dto.WorkOrderQueryDTO;
import com.ruoyi.mes.mapper.WorkOrderMapper;
import com.ruoyi.mes.service.IProcessTaskService;
import com.ruoyi.mes.service.IWorkOrderService;
import com.ruoyi.mes.vo.WorkOrderVO;

@Service
public class WorkOrderServiceImpl implements IWorkOrderService
{
    @Autowired
    private WorkOrderMapper workOrderMapper;
    @Autowired
    private IProcessTaskService processTaskService;

    @Override public List<WorkOrderVO> selectWorkOrderList(WorkOrderQueryDTO q) { return workOrderMapper.selectWorkOrderList(q); }
    @Override public WorkOrderVO selectWorkOrderById(Long id) { return workOrderMapper.selectWorkOrderById(id); }

    @Override @Transactional(rollbackFor = Exception.class)
    public int insertWorkOrder(WorkOrderDTO dto, String operator)
    {
        WorkOrder wo = toEntity(dto);
        if (wo.getWorkOrderNo() == null || wo.getWorkOrderNo().isEmpty())
            wo.setWorkOrderNo("WO" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
        if (wo.getStatus() == null || wo.getStatus().isEmpty())
            wo.setStatus("WAITING");
        if (wo.getCompletedQty() == null) wo.setCompletedQty(0);
        wo.setCreateBy(operator);
        return workOrderMapper.insertWorkOrder(wo);
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int updateWorkOrder(WorkOrderDTO dto, String operator)
    {
        if (dto.getWorkOrderId() == null) throw new ServiceException("工单ID不能为空");
        WorkOrder wo = toEntity(dto);
        wo.setUpdateBy(operator);
        return workOrderMapper.updateWorkOrder(wo);
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int deleteWorkOrderByIds(String ids)
    {
        Long[] arr = Convert.toLongArray(ids);
        if (arr.length == 0) throw new ServiceException("请选择要删除的工单");
        return workOrderMapper.deleteWorkOrderByIds(arr);
    }

    @Override
    public List<WorkOrder> selectWorkOrderExportList(WorkOrderQueryDTO q)
    {
        List<WorkOrderVO> vos = workOrderMapper.selectWorkOrderList(q);
        List<WorkOrder> list = new ArrayList<>();
        for (WorkOrderVO vo : vos) { WorkOrder wo = new WorkOrder(); BeanUtils.copyProperties(vo, wo); list.add(wo); }
        return list;
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int startWorkOrder(Long workOrderId, String operator)
    {
        WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(workOrderId);
        if (wo == null) throw new ServiceException("工单不存在");
        wo.setStatus("RUNNING");
        wo.setUpdateBy(operator);
        int result = workOrderMapper.updateWorkOrder(wo);
        // 自动创建7道MES工序
        processTaskService.initProcessTasks(workOrderId, wo.getPlannedQty(), operator);
        return result;
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int finishWorkOrder(Long workOrderId, Integer completedQty, String operator)
    {
        WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(workOrderId);
        if (wo == null) throw new ServiceException("工单不存在");
        wo.setStatus("FINISHED");
        wo.setCurrentStep(wo.getTotalSteps());
        int qty = completedQty != null ? completedQty : wo.getPlannedQty();
        wo.setCompletedQty(qty);
        wo.setUpdateBy(operator);
        int result = workOrderMapper.updateWorkOrder(wo);

        // 将所有未完成的工序任务标记为已完成
        List<com.ruoyi.mes.domain.ProcessTask> tasks = processTaskService.getTasksByWorkOrder(workOrderId);
        for (com.ruoyi.mes.domain.ProcessTask t : tasks) {
            if (!"FINISHED".equals(t.getStatus())) {
                t.setStatus("FINISHED");
                t.setGoodQty(t.getPlannedQty());
                t.setEndTime(new Date());
                t.setUpdateBy(operator);
                processTaskService.updateTask(t);
            }
        }

        // 自动生成入库单
        processTaskService.autoGenerateWarehousingForFinish(wo, qty);
        return result;
    }

    private WorkOrder toEntity(WorkOrderDTO dto) { WorkOrder wo = new WorkOrder(); BeanUtils.copyProperties(dto, wo); return wo; }
}
