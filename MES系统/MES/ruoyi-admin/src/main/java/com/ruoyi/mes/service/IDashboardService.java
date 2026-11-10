package com.ruoyi.mes.service;

import java.util.Map;

public interface IDashboardService
{
    Map<String, Object> getStats();

    Object getOrderStatus();

    Object getEquipStatus();

    Object getInventoryStats();

    Object getYieldTrend();

    Object getWorkOrderTrend();

    Object getLowStockTop10();
}
