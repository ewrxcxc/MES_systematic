package com.ruoyi.mes.controller;

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
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.mes.domain.Equipment;
import com.ruoyi.mes.mapper.EquipmentMapper;

@Tag(name="MES设备管理")
@RestController
@RequestMapping("/api/mes/equipment")
public class EquipmentController extends BaseController
{
    @Autowired private EquipmentMapper mapper;

    @Operation(summary="查询设备") @RequiresPermissions("mes:equipment:list") @PostMapping("/list")
    public TableDataInfo list(String equipmentCode, String equipmentName, String status) {
        startPage(); return getDataTable(mapper.selectEquipmentList(equipmentCode, equipmentName, status));
    }

    @Operation(summary="导出") @Log(title="设备",businessType=BusinessType.EXPORT) @RequiresPermissions("mes:equipment:export") @PostMapping("/export")
    public AjaxResult export(String equipmentCode, String equipmentName, String status) {
        return new ExcelUtil<>(Equipment.class).exportExcel(mapper.selectEquipmentList(equipmentCode,equipmentName,status),"设备数据");
    }

    @Operation(summary="详情") @RequiresPermissions("mes:equipment:query") @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) { return success(mapper.selectEquipmentById(id)); }

    @Operation(summary="新增") @Log(title="设备",businessType=BusinessType.INSERT) @RequiresPermissions("mes:equipment:add") @PostMapping("/create")
    public AjaxResult create(@Validated @RequestBody Equipment e) { e.setCreateBy(getLoginName()); return toAjax(mapper.insertEquipment(e)); }

    @Operation(summary="修改") @Log(title="设备",businessType=BusinessType.UPDATE) @RequiresPermissions("mes:equipment:edit") @PostMapping("/update")
    public AjaxResult update(@Validated @RequestBody Equipment e) { e.setUpdateBy(getLoginName()); return toAjax(mapper.updateEquipment(e)); }

    @Operation(summary="删除") @Log(title="设备",businessType=BusinessType.DELETE) @RequiresPermissions("mes:equipment:remove") @PostMapping("/delete")
    public AjaxResult delete(String ids) { return toAjax(mapper.deleteEquipmentByIds(Convert.toLongArray(ids))); }
}
