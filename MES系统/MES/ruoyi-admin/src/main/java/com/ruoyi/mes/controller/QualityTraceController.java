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
import com.ruoyi.mes.domain.*;
import com.ruoyi.mes.service.IQualityTraceService;
import com.ruoyi.mes.vo.TraceVO;

@Tag(name = "质量追溯管理")
@RestController
@RequestMapping("/api/mes/trace")
public class QualityTraceController extends BaseController
{
    @Autowired private IQualityTraceService traceService;

    // ===== 追溯 =====
    @Operation(summary = "查询追溯列表")
    @RequiresPermissions("mes:trace:list")
    @PostMapping("/list")
    public TableDataInfo list(QualityTrace trace) {
        startPage();
        return getDataTable(traceService.selectTraceList(trace));
    }

    @Operation(summary = "产品追溯")
    @GetMapping("/byProduct/{productId}")
    public AjaxResult traceByProduct(@PathVariable Long productId) {
        return success(traceService.traceByProduct(productId));
    }

    @Operation(summary = "工单追溯")
    @GetMapping("/byWorkOrder/{workOrderId}")
    public AjaxResult traceByWorkOrder(@PathVariable Long workOrderId) {
        return success(traceService.traceByWorkOrder(workOrderId));
    }

    @Operation(summary = "批次追溯")
    @GetMapping("/byBatch/{batchNo}")
    public AjaxResult traceByBatch(@PathVariable String batchNo) {
        return success(traceService.traceByBatchNo(batchNo));
    }

    @Operation(summary = "新增追溯记录")
    @Log(title = "质量追溯", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:trace:add")
    @PostMapping("/traceCreate")
    public AjaxResult traceCreate(QualityTrace trace) {
        return success(traceService.selectTraceById(1L)); // placeholder for future implementation
    }

    // ===== 批次 =====
    @Operation(summary = "查询批次列表")
    @PostMapping("/batchList")
    public TableDataInfo batchList(BatchInfo batch) {
        startPage();
        return getDataTable(traceService.selectBatchList(batch));
    }

    @Operation(summary = "新增批次")
    @Log(title = "批次信息", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:trace:add")
    @PostMapping("/batchCreate")
    public AjaxResult batchCreate(BatchInfo batch) {
        return toAjax(traceService.insertBatch(batch, getLoginName()));
    }

    // ===== 缺陷 =====
    @Operation(summary = "查询缺陷列表")
    @PostMapping("/defectList")
    public TableDataInfo defectList(DefectRecord defect) {
        startPage();
        return getDataTable(traceService.selectDefectList(defect));
    }

    @Operation(summary = "根据工单查询缺陷")
    @GetMapping("/defectsByWorkOrder/{workOrderId}")
    public AjaxResult defectsByWorkOrder(@PathVariable Long workOrderId) {
        return success(traceService.selectDefectsByWorkOrderId(workOrderId));
    }

    @Operation(summary = "新增缺陷记录")
    @Log(title = "缺陷记录", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:trace:add")
    @PostMapping("/defectCreate")
    public AjaxResult defectCreate(DefectRecord defect) {
        return toAjax(traceService.insertDefect(defect, getLoginName()));
    }

    @Operation(summary = "处理缺陷")
    @Log(title = "缺陷记录", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:trace:edit")
    @PostMapping("/defectHandle")
    public AjaxResult defectHandle(DefectRecord defect) {
        return toAjax(traceService.updateDefect(defect));
    }

    // ===== 跨表查询（增强） =====
    @Operation(summary = "跨表搜索追溯记录")
    @RequiresPermissions("mes:trace:list")
    @PostMapping("/search")
    public TableDataInfo search(TraceVO query) {
        startPage();
        return getDataTable(traceService.searchTraces(query));
    }

    @Operation(summary = "获取有追溯数据的订单列表")
    @GetMapping("/orderList")
    public AjaxResult orderList() {
        return success(traceService.getDistinctOrders());
    }

    @Operation(summary = "获取订单完整业务链条")
    @GetMapping("/orderChain/{orderId}")
    public AjaxResult orderChain(@PathVariable Long orderId) {
        return success(traceService.getOrderChain(orderId));
    }

    @Operation(summary = "按工单号查询追溯链路（SO→WO→工序→报工→质检）")
    @GetMapping("/query")
    public AjaxResult query(@RequestParam String workOrderNo) {
        return success(traceService.queryByWorkOrderNo(workOrderNo));
    }
}
