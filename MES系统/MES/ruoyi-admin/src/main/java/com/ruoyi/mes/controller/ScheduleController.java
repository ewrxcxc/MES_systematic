package com.ruoyi.mes.controller;

import java.util.List;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.mes.domain.Schedule;
import com.ruoyi.mes.mapper.WorkOrderMapper;
import com.ruoyi.mes.service.IScheduleService;
import com.ruoyi.mes.vo.WorkOrderVO;

@Tag(name = "MES排程管理")
@RestController
@RequestMapping("/api/mes/schedule")
public class ScheduleController extends BaseController
{
    @Autowired
    private IScheduleService scheduleService;
    @Autowired
    private WorkOrderMapper workOrderMapper;

    @Operation(summary = "查询排程列表")
    @RequiresPermissions("mes:schedule:list")
    @PostMapping("/list")
    public TableDataInfo list(Schedule schedule)
    {
        startPage();
        List<Schedule> list = scheduleService.selectScheduleList(schedule);
        return getDataTable(list);
    }

    @Operation(summary = "导出排程列表")
    @Log(title = "排程管理", businessType = BusinessType.EXPORT)
    @RequiresPermissions("mes:schedule:export")
    @PostMapping("/export")
    public AjaxResult export(Schedule schedule)
    {
        List<Schedule> list = scheduleService.selectScheduleExportList(schedule);
        ExcelUtil<Schedule> util = new ExcelUtil<>(Schedule.class);
        return util.exportExcel(list, "排程数据");
    }

    @Operation(summary = "获取排程详细信息")
    @RequiresPermissions("mes:schedule:query")
    @GetMapping("/{scheduleId}")
    public AjaxResult getInfo(@PathVariable Long scheduleId)
    {
        return success(scheduleService.selectScheduleById(scheduleId));
    }

    @Operation(summary = "新增排程")
    @Log(title = "排程管理", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:schedule:add")
    @PostMapping("/create")
    public AjaxResult create(Schedule schedule)
    {
        schedule.setCreateBy(getLoginName());
        return toAjax(scheduleService.insertSchedule(schedule));
    }

    @Operation(summary = "修改排程")
    @Log(title = "排程管理", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:schedule:edit")
    @PostMapping("/update")
    public AjaxResult update(Schedule schedule)
    {
        schedule.setUpdateBy(getLoginName());
        return toAjax(scheduleService.updateSchedule(schedule));
    }

    @Operation(summary = "删除排程")
    @Log(title = "排程管理", businessType = BusinessType.DELETE)
    @RequiresPermissions("mes:schedule:remove")
    @PostMapping("/delete")
    public AjaxResult delete(String ids)
    {
        return toAjax(scheduleService.deleteScheduleByIds(ids));
    }

    @Operation(summary = "获取工单列表(下拉框)")
    @GetMapping("/workOrderList")
    public AjaxResult workOrderList()
    {
        List<WorkOrderVO> list = workOrderMapper.selectWorkOrderList(null);
        return success(list);
    }
}
