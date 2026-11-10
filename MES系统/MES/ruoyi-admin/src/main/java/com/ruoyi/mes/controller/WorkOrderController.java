package com.ruoyi.mes.controller;

import java.util.List;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.mes.domain.WorkOrder;
import com.ruoyi.mes.dto.WorkOrderDTO;
import com.ruoyi.mes.dto.WorkOrderQueryDTO;
import com.ruoyi.mes.service.IWorkOrderService;
import com.ruoyi.mes.vo.WorkOrderVO;

@Tag(name = "MES工单管理")
@RestController
@RequestMapping("/api/mes/workorder")
public class WorkOrderController extends BaseController
{
    @Autowired
    private IWorkOrderService workOrderService;

    @Operation(summary = "查询工单列表")
    @RequiresPermissions("mes:workorder:list")
    @PostMapping("/list")
    public TableDataInfo list(WorkOrderQueryDTO query) { startPage(); List<WorkOrderVO> list = workOrderService.selectWorkOrderList(query); return getDataTable(list); }

    @Operation(summary = "导出工单列表")
    @Log(title = "工单管理", businessType = BusinessType.EXPORT)
    @RequiresPermissions("mes:workorder:export")
    @PostMapping("/export")
    public AjaxResult export(WorkOrderQueryDTO query) { List<WorkOrder> list = workOrderService.selectWorkOrderExportList(query); ExcelUtil<WorkOrder> util = new ExcelUtil<>(WorkOrder.class); return util.exportExcel(list, "工单数据"); }

    @Operation(summary = "获取工单详细信息")
    @RequiresPermissions("mes:workorder:query")
    @GetMapping("/{workOrderId}")
    public AjaxResult getInfo(@PathVariable Long workOrderId) { return success(workOrderService.selectWorkOrderById(workOrderId)); }

    @Operation(summary = "新增工单")
    @Log(title = "工单管理", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:workorder:add")
    @PostMapping("/create")
    public AjaxResult create(@Validated @RequestBody WorkOrderDTO dto) { return toAjax(workOrderService.insertWorkOrder(dto, getLoginName())); }

    @Operation(summary = "修改工单")
    @Log(title = "工单管理", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:workorder:edit")
    @PostMapping("/update")
    public AjaxResult update(@Validated @RequestBody WorkOrderDTO dto) { return toAjax(workOrderService.updateWorkOrder(dto, getLoginName())); }

    @Operation(summary = "删除工单")
    @Log(title = "工单管理", businessType = BusinessType.DELETE)
    @RequiresPermissions("mes:workorder:remove")
    @PostMapping("/delete")
    public AjaxResult delete(String ids) { return toAjax(workOrderService.deleteWorkOrderByIds(ids)); }

    @Operation(summary = "开工")
    @Log(title = "工单管理", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:workorder:edit")
    @PostMapping("/start/{workOrderId}")
    public AjaxResult start(@PathVariable Long workOrderId) { return toAjax(workOrderService.startWorkOrder(workOrderId, getLoginName())); }

    @Operation(summary = "完工")
    @Log(title = "工单管理", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:workorder:edit")
    @PostMapping("/finish/{workOrderId}")
    public AjaxResult finish(@PathVariable Long workOrderId, Integer completedQty) { return toAjax(workOrderService.finishWorkOrder(workOrderId, completedQty, getLoginName())); }
}
