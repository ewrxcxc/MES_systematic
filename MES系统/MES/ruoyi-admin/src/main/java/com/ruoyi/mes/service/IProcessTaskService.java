package com.ruoyi.mes.service;

import java.util.List;
import com.ruoyi.mes.domain.ProcessTask;
import com.ruoyi.mes.domain.WorkOrder;

public interface IProcessTaskService
{
    public List<ProcessTask> getTasksByWorkOrder(Long workOrderId);

    /** 初始化工单的7道工序 */
    public void initProcessTasks(Long workOrderId, Integer plannedQty, String operator);

    /** 开工：开始当前工序 */
    public ProcessTask startTask(Long taskId, Long operatorId, Long equipmentId);

    /** 完工：完成当前工序，自动流转到下一道 */
    public ProcessTask finishTask(Long taskId, Integer goodQty, Integer badQty);

    /** 获取当前工序进度（0-100） */
    public int getProgress(Long workOrderId);

    /** 查询所有工序任务（支持筛选） */
    public List<ProcessTask> getAllTasks(ProcessTask task);

    /** 更新工序任务 */
    public void updateTask(ProcessTask task);

    /** 工单完工时自动生成入库单 */
    public void autoGenerateWarehousingForFinish(WorkOrder wo, int qty);
}
