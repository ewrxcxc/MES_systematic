package com.ruoyi.mes.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.ruoyi.mes.domain.ProcessEquipmentMapping;
import com.ruoyi.mes.mapper.EquipmentMapper;
import com.ruoyi.mes.mapper.ProductionLineMapper;
import com.ruoyi.mes.service.IProcessEquipmentMappingService;

@Tag(name = "工序设备映射管理")
@RestController
@RequestMapping("/api/mes/mapping")
public class ProcessEquipmentMappingController extends BaseController
{
    @Autowired private IProcessEquipmentMappingService mappingService;
    @Autowired private ProductionLineMapper lineMapper;
    @Autowired private EquipmentMapper equipmentMapper;

    @Operation(summary = "查询工序设备映射列表")
    @RequiresPermissions("mes:mapping:list")
    @PostMapping("/list")
    public TableDataInfo list(ProcessEquipmentMapping mapping) {
        startPage();
        return getDataTable(mappingService.selectMappingList(mapping));
    }

    @Operation(summary = "获取工序设备映射详情")
    @RequiresPermissions("mes:mapping:query")
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) {
        return success(mappingService.selectMappingById(id));
    }

    @Operation(summary = "根据工序查询可用设备")
    @GetMapping("/byProcess/{processSeq}")
    public AjaxResult getByProcess(@PathVariable Integer processSeq) {
        return success(mappingService.selectByProcessSeq(processSeq));
    }

    @Operation(summary = "新增工序设备映射")
    @Log(title = "工序设备映射", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:mapping:add")
    @PostMapping("/create")
    public AjaxResult create(ProcessEquipmentMapping mapping) {
        return toAjax(mappingService.insertMapping(mapping, getLoginName()));
    }

    @Operation(summary = "修改工序设备映射")
    @Log(title = "工序设备映射", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:mapping:edit")
    @PostMapping("/update")
    public AjaxResult update(ProcessEquipmentMapping mapping) {
        return toAjax(mappingService.updateMapping(mapping, getLoginName()));
    }

    @Operation(summary = "删除工序设备映射")
    @Log(title = "工序设备映射", businessType = BusinessType.DELETE)
    @RequiresPermissions("mes:mapping:remove")
    @PostMapping("/delete")
    public AjaxResult delete(String ids) {
        return toAjax(mappingService.deleteMappingByIds(ids));
    }

    @Operation(summary = "获取产线列表")
    @PostMapping("/lineList")
    public AjaxResult lineList() {
        return success(lineMapper.selectProductionLineList(null, null));
    }

    @Operation(summary = "获取设备列表")
    @PostMapping("/equipmentList")
    public AjaxResult equipmentList() {
        return success(equipmentMapper.selectEquipmentList(null, null, null));
    }

    @Operation(summary = "获取可用API列表")
    @PostMapping("/apiList")
    public AjaxResult apiList() {
        List<Map<String, String>> list = new ArrayList<>();
        String[][] apis = {
            {"GET", "/api/mes/inventory/outbound", "原材料出库"},
            {"GET", "/api/mes/inventory/finishedInbound", "成品入库"},
            {"GET", "/api/mes/process/start", "工序开始"},
            {"GET", "/api/mes/process/finish", "工序完成"},
            {"GET", "/api/mes/quality/check", "质量检测"},
            {"GET", "/api/mes/warehousing/create", "创建入库单"},
            {"POST", "/api/mes/workorder/create", "创建工单"},
            {"POST", "/api/mes/workorder/start", "开工"},
            {"POST", "/api/mes/workorder/finish", "完工"},
            {"POST", "/api/mes/report/create", "创建报工"},
            {"POST", "/api/mes/picking/createByWorkOrder", "创建领料单"},
            {"POST", "/api/mes/equipment/create", "新增设备"},
            {"GET", "/api/mes/mapping/byProcess", "按工序查设备"},
            {"GET", "/api/mes/process/tasks", "查工序任务"},
        };
        for (String[] a : apis) {
            Map<String, String> m = new HashMap<>();
            m.put("method", a[0]); m.put("url", a[1]); m.put("desc", a[2]);
            list.add(m);
        }
        return success(list);
    }

    @Operation(summary = "批量启用映射")
    @Log(title = "工序-产线-API映射", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:mapping:edit")
    @PostMapping("/batchEnable")
    public AjaxResult batchEnable(String ids) {
        return toAjax(mappingService.batchEnable(ids, getLoginName()));
    }

    @Operation(summary = "批量停用映射")
    @Log(title = "工序-产线-API映射", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:mapping:edit")
    @PostMapping("/batchDisable")
    public AjaxResult batchDisable(String ids) {
        return toAjax(mappingService.batchDisable(ids, getLoginName()));
    }

    @Operation(summary = "测试API连接")
    @RequiresPermissions("mes:mapping:query")
    @PostMapping("/testConnection/{id}")
    public AjaxResult testConnection(@PathVariable Long id) {
        Map<String, Object> result = mappingService.testConnection(id);
        return success(result);
    }

    @Operation(summary = "刷新所有连接状态")
    @RequiresPermissions("mes:mapping:edit")
    @PostMapping("/refreshStatus")
    public AjaxResult refreshStatus() {
        mappingService.refreshStatus();
        return success();
    }

    @Operation(summary = "获取流程模拟数据")
    @RequiresPermissions("mes:mapping:list")
    @PostMapping("/simulationData")
    public AjaxResult simulationData() {
        ProcessEquipmentMapping query = new ProcessEquipmentMapping();
        query.setStatus("ACTIVE");
        return success(mappingService.selectMappingList(query));
    }
}
