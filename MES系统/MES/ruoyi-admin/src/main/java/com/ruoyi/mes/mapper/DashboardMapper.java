package com.ruoyi.mes.mapper;

import java.util.List;
import java.util.Map;

public interface DashboardMapper
{
    Long countTodayOrders();

    Long countTodayFinished();

    Long countRunningOrders();

    Map<String, Object> getTodayYield();

    Long countLowStock();

    Long sumTodayShipments();

    Long countRunningEquip();

    Long countTotalEquip();

    List<Map<String, Object>> getOrderStatusGroup();

    List<Map<String, Object>> getEquipStatusGroup();

    List<Map<String, Object>> getInventoryTypeStats();

    List<Map<String, Object>> getYieldTrend7Days();

    List<Map<String, Object>> getWorkOrderTrend7Days();

    List<Map<String, Object>> getLowStockTop10();
    Map<String, Object> getQualityPassRate();
    Map<String, Object> getWorkOrderCompletionRate();
}
