package com.ruoyi.mes.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
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
import com.ruoyi.mes.domain.Inventory;
import com.ruoyi.mes.dto.InventoryDTO;
import com.ruoyi.mes.dto.InventoryQueryDTO;
import com.ruoyi.mes.service.IInventoryService;
import com.ruoyi.mes.vo.InventoryVO;

@Tag(name = "MES库存管理")
@RestController
@RequestMapping("/api/mes/inventory")
public class InventoryController extends BaseController
{
    @Autowired private IInventoryService service;

    @Operation(summary="查询库存") @RequiresPermissions("mes:inventory:list") @PostMapping("/list")
    public TableDataInfo list(InventoryQueryDTO q) { startPage(); return getDataTable(service.selectInventoryList(q)); }

    @Operation(summary="导出") @Log(title="库存",businessType=BusinessType.EXPORT) @RequiresPermissions("mes:inventory:export") @PostMapping("/export")
    public AjaxResult export(InventoryQueryDTO q) { return new ExcelUtil<>(Inventory.class).exportExcel(service.selectInventoryExportList(q),"库存数据"); }

    @Operation(summary="详情") @RequiresPermissions("mes:inventory:query") @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) { return success(service.selectInventoryById(id)); }

    @Operation(summary="新增(或累加已有库存)")
    @Log(title="库存",businessType=BusinessType.INSERT) @RequiresPermissions("mes:inventory:add") @PostMapping("/create")
    public AjaxResult create(InventoryDTO d) {
        try {
            return toAjax(service.insertOrAddInventory(d, getLoginName()));
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }

    @Operation(summary="修改") @Log(title="库存",businessType=BusinessType.UPDATE) @RequiresPermissions("mes:inventory:edit") @PostMapping("/update")
    public AjaxResult update(InventoryDTO d) {
        try {
            return toAjax(service.updateInventory(d, getLoginName()));
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }

    @Operation(summary="删除") @Log(title="库存",businessType=BusinessType.DELETE) @RequiresPermissions("mes:inventory:remove") @PostMapping("/delete")
    public AjaxResult delete(String ids) { return toAjax(service.deleteInventoryByIds(ids)); }

    @Operation(summary="获取物料列表(供下拉框使用)")
    @PostMapping("/materialList")
    public AjaxResult materialList() {
        List<Inventory> list = service.selectInventoryExportList(new InventoryQueryDTO());
        Set<String> seen = new LinkedHashSet<>();
        List<Map<String, String>> result = new ArrayList<>();
        for (Inventory inv : list) {
            String key = (inv.getMaterialName() != null ? inv.getMaterialName() : "") + "|" + (inv.getMaterialCode() != null ? inv.getMaterialCode() : "");
            if (seen.add(key)) {
                Map<String, String> m = new HashMap<>();
                m.put("materialName", inv.getMaterialName());
                m.put("materialCode", inv.getMaterialCode());
                m.put("location", inv.getLocation());
                result.add(m);
            }
        }
        return success(result);
    }
}
