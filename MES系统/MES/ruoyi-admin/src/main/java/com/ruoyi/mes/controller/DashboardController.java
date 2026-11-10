package com.ruoyi.mes.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.mes.service.IDashboardService;

@RestController
@RequestMapping("/api/mes/dashboard")
public class DashboardController
{
    @Autowired
    private IDashboardService dashboardService;

    @GetMapping("/stats")
    public AjaxResult stats()
    {
        return AjaxResult.success(dashboardService.getStats());
    }

    @GetMapping("/orderStatus")
    public AjaxResult orderStatus()
    {
        return AjaxResult.success(dashboardService.getOrderStatus());
    }

    @GetMapping("/equipStatus")
    public AjaxResult equipStatus()
    {
        return AjaxResult.success(dashboardService.getEquipStatus());
    }

    @GetMapping("/inventoryStats")
    public AjaxResult inventoryStats()
    {
        return AjaxResult.success(dashboardService.getInventoryStats());
    }

    @GetMapping("/yieldTrend")
    public AjaxResult yieldTrend()
    {
        return AjaxResult.success(dashboardService.getYieldTrend());
    }

    @GetMapping("/workOrderTrend")
    public AjaxResult workOrderTrend()
    {
        return AjaxResult.success(dashboardService.getWorkOrderTrend());
    }

    @GetMapping("/lowStockTop10")
    public AjaxResult lowStockTop10()
    {
        return AjaxResult.success(dashboardService.getLowStockTop10());
    }
}
