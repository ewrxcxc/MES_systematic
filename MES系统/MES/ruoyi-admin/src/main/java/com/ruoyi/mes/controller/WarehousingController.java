package com.ruoyi.mes.controller;

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
import com.ruoyi.mes.domain.Warehousing;
import com.ruoyi.mes.mapper.WorkOrderMapper;
import com.ruoyi.mes.service.IWarehousingService;

@Tag(name = "入库管理")
@RestController
@RequestMapping("/api/mes/warehousing")
public class WarehousingController extends BaseController
{
    @Autowired private IWarehousingService warehousingService;
    @Autowired private WorkOrderMapper workOrderMapper;

    @Operation(summary = "查询入库单列表")
    @RequiresPermissions("mes:warehousing:list")
    @PostMapping("/list")
    public TableDataInfo list(Warehousing warehousing) {
        startPage();
        return getDataTable(warehousingService.selectWarehousingList(warehousing));
    }

    @Operation(summary = "获取入库单详情")
    @RequiresPermissions("mes:warehousing:query")
    @GetMapping("/{warehousingId}")
    public AjaxResult getInfo(@PathVariable Long warehousingId) {
        AjaxResult result = success(warehousingService.selectWarehousingById(warehousingId));
        result.put("details", warehousingService.selectWarehousingDetails(warehousingId));
        return result;
    }

    @Operation(summary = "新增入库单")
    @Log(title = "入库单", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:warehousing:add")
    @PostMapping("/create")
    public AjaxResult create(Warehousing warehousing) {
        try {
            return toAjax(warehousingService.insertWarehousing(warehousing, getLoginName()));
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "质检")
    @Log(title = "入库单", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:warehousing:edit")
    @PostMapping("/inspect/{warehousingId}")
    public AjaxResult inspect(@PathVariable Long warehousingId, String inspector, String inspectResult) {
        try {
            return toAjax(warehousingService.doInspect(warehousingId, inspector, inspectResult, getLoginName()));
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "确认入库(增加库存)")
    @Log(title = "入库单", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:warehousing:edit")
    @PostMapping("/confirm/{warehousingId}")
    public AjaxResult confirm(@PathVariable Long warehousingId, String warehousingBy, String location) {
        try {
            return toAjax(warehousingService.confirmWarehousing(warehousingId, warehousingBy, location, getLoginName()));
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "删除入库单")
    @Log(title = "入库单", businessType = BusinessType.DELETE)
    @RequiresPermissions("mes:warehousing:remove")
    @PostMapping("/delete")
    public AjaxResult delete(String ids) {
        return toAjax(warehousingService.deleteWarehousingByIds(ids));
    }

    @Operation(summary = "获取已完成工单列表(供入库选择)")
    @PostMapping("/finishedWorkOrders")
    public AjaxResult finishedWorkOrders() {
        return success(workOrderMapper.selectWorkOrderList(null));
    }
}
