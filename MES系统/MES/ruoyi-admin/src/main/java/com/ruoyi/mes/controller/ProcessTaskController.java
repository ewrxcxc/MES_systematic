package com.ruoyi.mes.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.mes.domain.ProcessTask;
import com.ruoyi.mes.service.IProcessTaskService;
import com.ruoyi.mes.mapper.MaterialPickingMapper;
import com.ruoyi.mes.domain.MaterialPicking;

@Tag(name = "MES工序任务")
@RestController
@RequestMapping("/api/mes/process")
public class ProcessTaskController
{
    @Autowired private IProcessTaskService service;
    @Autowired private MaterialPickingMapper pickingMapper;

    @Operation(summary = "获取所有工序任务")
    @GetMapping("/allTasks")
    public AjaxResult getAllTasks(ProcessTask task) {
        List<ProcessTask> list = service.getAllTasks(task);
        return AjaxResult.success().put("rows", list);
    }

    @Operation(summary = "获取工单工序列表")
    @GetMapping("/tasks/{workOrderId}")
    public AjaxResult getTasks(@PathVariable Long workOrderId) {
        List<ProcessTask> tasks = service.getTasksByWorkOrder(workOrderId);
        int progress = service.getProgress(workOrderId);
        return AjaxResult.success().put("tasks", tasks).put("progress", progress);
    }

    @Operation(summary = "开工")
    @PostMapping("/start/{taskId}")
    public AjaxResult start(@PathVariable Long taskId, Long operatorId, Long equipmentId) {
        return AjaxResult.success(service.startTask(taskId, operatorId, equipmentId));
    }

    @Operation(summary = "完工")
    @PostMapping("/finish/{taskId}")
    public AjaxResult finish(@PathVariable Long taskId, Integer goodQty, Integer badQty) {
        return AjaxResult.success(service.finishTask(taskId, goodQty, badQty));
    }

    @Operation(summary = "检查领料完成状态")
    @GetMapping("/checkPicking/{workOrderId}")
    public AjaxResult checkPicking(@PathVariable Long workOrderId) {
        MaterialPicking picking = pickingMapper.selectMaterialPickingByWorkOrderId(workOrderId);
        if (picking == null) return AjaxResult.success().put("finished", false).put("msg", "未生成领料单");
        boolean finished = "FINISHED".equals(picking.getPickingStatus());
        return AjaxResult.success().put("finished", finished).put("status", picking.getPickingStatus());
    }
}
