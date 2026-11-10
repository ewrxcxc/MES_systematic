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
import com.ruoyi.mes.domain.WorkOrderSplit;
import com.ruoyi.mes.service.IWorkOrderSplitService;

@Tag(name = "工单拆卡管理")
@RestController
@RequestMapping("/api/mes/split")
public class WorkOrderSplitController extends BaseController
{
    @Autowired private IWorkOrderSplitService splitService;

    @Operation(summary = "查询拆卡列表")
    @RequiresPermissions("mes:split:list")
    @PostMapping("/list")
    public TableDataInfo list(WorkOrderSplit split) {
        startPage();
        return getDataTable(splitService.selectSplitList(split));
    }

    @Operation(summary = "获取拆卡详情")
    @RequiresPermissions("mes:split:query")
    @GetMapping("/{splitId}")
    public AjaxResult getInfo(@PathVariable Long splitId) {
        return success(splitService.selectSplitById(splitId));
    }

    @Operation(summary = "根据父工单查询拆卡记录")
    @GetMapping("/byParent/{parentWorkOrderId}")
    public AjaxResult getByParent(@PathVariable Long parentWorkOrderId) {
        return success(splitService.selectSplitsByParentWorkOrderId(parentWorkOrderId));
    }

    @Operation(summary = "拆卡")
    @Log(title = "工单拆卡", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:split:add")
    @PostMapping("/create/{parentWorkOrderId}")
    public AjaxResult create(@PathVariable Long parentWorkOrderId, @RequestBody List<WorkOrderSplit> splits) {
        try {
            return toAjax(splitService.createSplit(parentWorkOrderId, splits, getLoginName()));
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "删除拆卡")
    @Log(title = "工单拆卡", businessType = BusinessType.DELETE)
    @RequiresPermissions("mes:split:remove")
    @PostMapping("/delete")
    public AjaxResult delete(String ids) {
        return toAjax(splitService.deleteSplitByIds(ids));
    }
}
