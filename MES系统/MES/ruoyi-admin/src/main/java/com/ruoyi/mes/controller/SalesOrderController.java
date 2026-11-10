package com.ruoyi.mes.controller;

import java.util.Date;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonFormat;
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
import com.ruoyi.mes.domain.SalesOrder;
import com.ruoyi.mes.dto.SalesOrderDTO;
import com.ruoyi.mes.dto.SalesOrderQueryDTO;
import com.ruoyi.mes.service.ISalesOrderService;
import com.ruoyi.mes.vo.SalesOrderVO;

@Tag(name = "MES销售订单管理")
@RestController
@RequestMapping("/api/mes/order")
public class SalesOrderController extends BaseController
{
    @Autowired
    private ISalesOrderService salesOrderService;

    @Operation(summary = "查询销售订单列表")
    @RequiresPermissions("mes:order:list")
    @PostMapping("/list")
    public TableDataInfo list(SalesOrderQueryDTO query)
    {
        startPage();
        List<SalesOrderVO> list = salesOrderService.selectSalesOrderList(query);
        return getDataTable(list);
    }

    @Operation(summary = "导出销售订单列表")
    @Log(title = "销售订单", businessType = BusinessType.EXPORT)
    @RequiresPermissions("mes:order:export")
    @PostMapping("/export")
    public AjaxResult export(SalesOrderQueryDTO query)
    {
        List<SalesOrder> list = salesOrderService.selectSalesOrderExportList(query);
        ExcelUtil<SalesOrder> util = new ExcelUtil<>(SalesOrder.class);
        return util.exportExcel(list, "销售订单数据");
    }

    @Operation(summary = "获取销售订单详细信息")
    @RequiresPermissions("mes:order:query")
    @GetMapping("/{orderId}")
    public AjaxResult getInfo(@PathVariable Long orderId)
    {
        return success(salesOrderService.selectSalesOrderById(orderId));
    }

    @Operation(summary = "新增销售订单")
    @Log(title = "销售订单", businessType = BusinessType.INSERT)
    @RequiresPermissions("mes:order:add")
    @PostMapping("/create")
    public AjaxResult create(SalesOrderDTO orderDto)
    {
        return toAjax(salesOrderService.insertSalesOrder(orderDto, getLoginName()));
    }

    @Operation(summary = "修改销售订单")
    @Log(title = "销售订单", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:order:edit")
    @PostMapping("/update")
    public AjaxResult update(SalesOrderDTO orderDto)
    {
        return toAjax(salesOrderService.updateSalesOrder(orderDto, getLoginName()));
    }

    @Operation(summary = "删除销售订单")
    @Log(title = "销售订单", businessType = BusinessType.DELETE)
    @RequiresPermissions("mes:order:remove")
    @PostMapping("/delete")
    public AjaxResult delete(String ids)
    {
        return toAjax(salesOrderService.deleteSalesOrderByIds(ids));
    }

    @Operation(summary = "获取发货预填数据")
    @RequiresPermissions("mes:order:edit")
    @GetMapping("/shipData/{orderId}")
    public AjaxResult shipData(@PathVariable Long orderId) {
        SalesOrderVO order = salesOrderService.getShipDataByOrderId(orderId);
        if (order == null) return error("销售订单不存在");
        return success(order);
    }

    @Operation(summary = "发货")
    @Log(title = "销售订单", businessType = BusinessType.UPDATE)
    @RequiresPermissions("mes:order:edit")
    @PostMapping("/ship")
    public AjaxResult ship(Long orderId, String expressCompany, Integer shipmentQty, String remark, @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss") Date shipmentTime) {
        try {
            return toAjax(salesOrderService.shipOrder(orderId, expressCompany, shipmentQty, getLoginName(), remark, shipmentTime));
        } catch (Exception e) {
            return error(e.getMessage());
        }
    }
}
