package com.ruoyi.mes.controller;

import java.util.HashMap;
import java.util.Map;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.mes.domain.QualityRecord;
import com.ruoyi.mes.service.IQualityRecordService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "MES质检管理")
@RestController
@RequestMapping("/api/mes/quality")
public class QualityRecordController extends BaseController
{
    @Autowired
    private IQualityRecordService qualityRecordService;

    @Operation(summary = "查询质检记录列表")
    @RequiresPermissions("mes:quality:list")
    @PostMapping("/list")
    public TableDataInfo list(QualityRecord record)
    {
        startPage();
        return getDataTable(qualityRecordService.selectQualityRecordList(record));
    }

    @Operation(summary = "获取质检记录详情")
    @RequiresPermissions("mes:quality:query")
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id)
    {
        return success(qualityRecordService.selectQualityRecordById(id));
    }

    @Operation(summary = "新增质检记录")
    @Log(title = "质检记录", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:quality:add")
    @PostMapping("/create")
    public AjaxResult create(QualityRecord record)
    {
        try
        {
            return toAjax(qualityRecordService.insertQualityRecord(record, getLoginName()));
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "修改质检记录")
    @Log(title = "质检记录", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:quality:edit")
    @PostMapping("/update")
    public AjaxResult update(QualityRecord record)
    {
        try
        {
            return toAjax(qualityRecordService.updateQualityRecord(record, getLoginName()));
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "删除质检记录")
    @Log(title = "质检记录", businessType = BusinessType.DELETE)
    @RequiresPermissions("mes:quality:remove")
    @PostMapping("/delete")
    public AjaxResult delete(String ids)
    {
        return toAjax(qualityRecordService.deleteQualityRecordByIds(ids));
    }

    @Operation(summary = "导出质检记录")
    @Log(title = "质检记录", businessType = BusinessType.EXPORT)
    @RequiresPermissions("mes:quality:export")
    @PostMapping("/export")
    public AjaxResult export(QualityRecord record)
    {
        return success(qualityRecordService.selectQualityRecordExportList(record));
    }

    @Operation(summary = "获取工单报工总数")
    @GetMapping("/reportQty/{workOrderId}")
    public AjaxResult getReportQty(@PathVariable Long workOrderId)
    {
        Map<String, Object> data = new HashMap<>();
        data.put("workOrderId", workOrderId);
        return success(data);
    }

    @Operation(summary = "获取已质检通过的工单ID列表")
    @GetMapping("/passedWorkOrders")
    public AjaxResult passedWorkOrders()
    {
        return success(qualityRecordService.selectPassedWorkOrderIds());
    }
}
