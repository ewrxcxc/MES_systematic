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
import com.ruoyi.mes.domain.ShipmentRecord;
import com.ruoyi.mes.mapper.ShipmentRecordMapper;

@Tag(name="MES发货管理")
@RestController
@RequestMapping("/api/mes/shipment")
public class ShipmentRecordController extends BaseController
{
    @Autowired private ShipmentRecordMapper mapper;

    @Operation(summary="查询发货") @RequiresPermissions("mes:shipment:list") @PostMapping("/list")
    public TableDataInfo list(Long orderId, String shipmentNo) { startPage(); return getDataTable(mapper.selectShipmentList(orderId, shipmentNo)); }

    @Operation(summary="导出") @Log(title="发货",businessType=BusinessType.EXPORT) @RequiresPermissions("mes:shipment:export") @PostMapping("/export")
    public AjaxResult export(Long orderId, String shipmentNo) {
        return new ExcelUtil<>(ShipmentRecord.class).exportExcel(mapper.selectShipmentEntities(orderId,shipmentNo),"发货数据");
    }

    @Operation(summary="详情") @RequiresPermissions("mes:shipment:query") @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable Long id) { return success(mapper.selectShipmentById(id)); }

    @Operation(summary="新增") @Log(title="发货",businessType=BusinessType.INSERT) @RequiresPermissions("mes:shipment:add") @PostMapping("/create")
    public AjaxResult create(@Validated @RequestBody ShipmentRecord s) { s.setCreateBy(getLoginName()); return toAjax(mapper.insertShipment(s)); }

    @Operation(summary="修改") @Log(title="发货",businessType=BusinessType.UPDATE) @RequiresPermissions("mes:shipment:edit") @PostMapping("/update")
    public AjaxResult update(@Validated @RequestBody ShipmentRecord s) { s.setUpdateBy(getLoginName()); return toAjax(mapper.updateShipment(s)); }

    @Operation(summary="删除") @Log(title="发货",businessType=BusinessType.DELETE) @RequiresPermissions("mes:shipment:remove") @PostMapping("/delete")
    public AjaxResult delete(String ids) { return toAjax(mapper.deleteShipmentByIds(Convert.toLongArray(ids))); }
}
