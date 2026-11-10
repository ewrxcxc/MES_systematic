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
import com.ruoyi.mes.domain.ProductionReport;
import com.ruoyi.mes.dto.ProductionReportDTO;
import com.ruoyi.mes.dto.ProductionReportQueryDTO;
import com.ruoyi.mes.service.IProductionReportService;
import com.ruoyi.mes.vo.ProductionReportVO;

@Tag(name = "MES生产报工管理")
@RestController
@RequestMapping("/api/mes/report")
public class ProductionReportController extends BaseController
{
    @Autowired
    private IProductionReportService service;

    @Operation(summary = "查询报告列表") @RequiresPermissions("mes:report:list") @PostMapping("/list")
    public TableDataInfo list(ProductionReportQueryDTO q) { startPage(); return getDataTable(service.selectReportList(q)); }

    @Operation(summary = "导出") @Log(title="生产报工",businessType=BusinessType.EXPORT) @RequiresPermissions("mes:report:export") @PostMapping("/export")
    public AjaxResult export(ProductionReportQueryDTO q) { List<ProductionReport> l = service.selectReportExportList(q); return new ExcelUtil<>(ProductionReport.class).exportExcel(l, "报工数据"); }

    @Operation(summary = "获取详情") @RequiresPermissions("mes:report:query") @GetMapping("/{reportId}")
    public AjaxResult getInfo(@PathVariable Long reportId) { return success(service.selectReportById(reportId)); }

    @Operation(summary = "新增报工") @Log(title="生产报工",businessType=BusinessType.INSERT) @RequiresPermissions("mes:report:add") @PostMapping("/create")
    public AjaxResult create(@Validated @RequestBody ProductionReportDTO d) { return toAjax(service.insertReport(d, getLoginName())); }

    @Operation(summary = "修改") @Log(title="生产报工",businessType=BusinessType.UPDATE) @RequiresPermissions("mes:report:edit") @PostMapping("/update")
    public AjaxResult update(@Validated @RequestBody ProductionReportDTO d) { return toAjax(service.updateReport(d, getLoginName())); }

    @Operation(summary = "删除") @Log(title="生产报工",businessType=BusinessType.DELETE) @RequiresPermissions("mes:report:remove") @PostMapping("/delete")
    public AjaxResult delete(String ids) { return toAjax(service.deleteReportByIds(ids)); }

    @Operation(summary = "质检") @Log(title="生产报工",businessType=BusinessType.UPDATE) @RequiresPermissions("mes:report:edit") @PostMapping("/inspect")
    public AjaxResult inspect(Long reportId, String qualityResult, String inspector, String qualityRemark) {
        try {
            return toAjax(service.inspectReport(reportId, qualityResult, inspector, qualityRemark, getLoginName()));
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }
}
