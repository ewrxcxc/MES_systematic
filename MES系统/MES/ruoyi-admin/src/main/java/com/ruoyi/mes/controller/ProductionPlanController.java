package com.ruoyi.mes.controller;

import java.text.SimpleDateFormat;
import java.util.*;
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
import com.ruoyi.mes.domain.ProductionPlan;
import com.ruoyi.mes.dto.ProductionPlanDTO;
import com.ruoyi.mes.dto.ProductionPlanQueryDTO;
import com.ruoyi.mes.service.IProductionPlanService;
import com.ruoyi.mes.vo.ProductionPlanVO;

@Tag(name = "MES生产计划管理")
@RestController
@RequestMapping("/api/mes/plan")
public class ProductionPlanController extends BaseController
{
    @Autowired
    private IProductionPlanService planService;

    @Operation(summary = "查询生产计划列表")
    @RequiresPermissions("mes:plan:list")
    @PostMapping("/list")
    public TableDataInfo list(ProductionPlanQueryDTO query) {
        startPage();
        List<ProductionPlanVO> list = planService.selectProductionPlanList(query);
        return getDataTable(list);
    }

    @Operation(summary = "导出生产计划列表")
    @Log(title = "生产计划", businessType = BusinessType.EXPORT)
    @RequiresPermissions("mes:plan:export")
    @PostMapping("/export")
    public AjaxResult export(ProductionPlanQueryDTO query) {
        List<ProductionPlan> list = planService.selectProductionPlanExportList(query);
        ExcelUtil<ProductionPlan> util = new ExcelUtil<>(ProductionPlan.class);
        return util.exportExcel(list, "生产计划数据");
    }

    @Operation(summary = "获取生产计划详细信息")
    @RequiresPermissions("mes:plan:query")
    @GetMapping("/{planId}")
    public AjaxResult getInfo(@PathVariable("planId") Long planId) {
        return success(planService.selectProductionPlanById(planId));
    }

    @Operation(summary = "新增生产计划")
    @Log(title = "生产计划", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:plan:add")
    @PostMapping("/create")
    public AjaxResult create(ProductionPlanDTO dto) {
        planService.insertProductionPlan(dto, getLoginName());
        Map<String, String> data = new HashMap<>();
        if (dto.getPlanStartTime() != null)
            data.put("planStart", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dto.getPlanStartTime()));
        if (dto.getPlanEndTime() != null)
            data.put("planEnd", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dto.getPlanEndTime()));
        return success(data);
    }

    @Operation(summary = "修改生产计划")
    @Log(title = "生产计划", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:plan:edit")
    @PostMapping("/update")
    public AjaxResult update(ProductionPlanDTO dto) {
        planService.updateProductionPlan(dto, getLoginName());
        Map<String, String> data = new HashMap<>();
        if (dto.getPlanStartTime() != null)
            data.put("planStart", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dto.getPlanStartTime()));
        if (dto.getPlanEndTime() != null)
            data.put("planEnd", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dto.getPlanEndTime()));
        return success(data);
    }

    @Operation(summary = "删除生产计划")
    @Log(title = "生产计划", businessType = BusinessType.DELETE)
    @RequiresPermissions("mes:plan:remove")
    @PostMapping("/delete")
    public AjaxResult delete(@RequestParam("ids") String ids) {
        return toAjax(planService.deleteProductionPlanByIds(ids));
    }

    @Operation(summary = "校验计划编号唯一")
    @PostMapping("/checkCodeUnique")
    public AjaxResult checkCodeUnique(ProductionPlanDTO dto) {
        return success(planService.checkPlanNoUnique(dto));
    }

    /** 更新计划时间 */
    @Operation(summary = "更新计划时间")
    @Log(title = "生产计划", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:plan:edit")
    @PostMapping("/updateTime/{planId}")
    public AjaxResult updateTime(@PathVariable("planId") Long planId,
            @RequestParam("planStartTime") String planStartTime, @RequestParam("planEndTime") String planEndTime) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            planService.updatePlanTime(planId, sdf.parse(planStartTime), sdf.parse(planEndTime), getLoginName());
            Map<String, String> data = new HashMap<>();
            data.put("planStart", planStartTime);
            data.put("planEnd", planEndTime);
            return success(data);
        } catch (java.text.ParseException e) {
            return error("时间格式错误，请使用 yyyy-MM-dd HH:mm:ss 格式");
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }

    /** 从生产计划生成工单 */
    @Operation(summary = "从生产计划生成工单")
    @Log(title = "生产计划", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:plan:edit")
    @PostMapping("/generateWorkOrder/{planId}")
    public AjaxResult generateWorkOrder(@PathVariable("planId") Long planId) {
        return toAjax(planService.generateWorkOrder(planId, getLoginName()));
    }

    /** 审核生产计划（已废弃） */
    @Operation(summary = "审核生产计划")
    @Log(title = "生产计划", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:plan:edit")
    @PostMapping("/audit/{planId}")
    public AjaxResult audit(@PathVariable("planId") Long planId) {
        return toAjax(planService.auditProductionPlan(planId, getLoginName()));
    }
}
