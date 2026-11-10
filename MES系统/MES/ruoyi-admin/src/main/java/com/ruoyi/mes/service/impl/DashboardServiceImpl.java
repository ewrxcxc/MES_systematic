package com.ruoyi.mes.service.impl;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ruoyi.mes.mapper.DashboardMapper;
import com.ruoyi.mes.service.IDashboardService;

@Service
public class DashboardServiceImpl implements IDashboardService
{
    @Autowired
    private DashboardMapper dashboardMapper;

    @Override
    public Map<String, Object> getStats()
    {
        Map<String, Object> data = new HashMap<>();

        Long todayOrders = dashboardMapper.countTodayOrders();
        data.put("todayOrders", todayOrders != null ? todayOrders : 0);

        Long todayFinished = dashboardMapper.countTodayFinished();
        data.put("todayFinished", todayFinished != null ? todayFinished : 0);

        Long runningOrders = dashboardMapper.countRunningOrders();
        data.put("runningOrders", runningOrders != null ? runningOrders : 0);

        Map<String, Object> yieldData = dashboardMapper.getTodayYield();
        long good = yieldData != null ? ((Number) yieldData.getOrDefault("good", 0)).longValue() : 0;
        long bad = yieldData != null ? ((Number) yieldData.getOrDefault("bad", 0)).longValue() : 0;
        long total = good + bad;
        data.put("yieldRate", total > 0 ? Math.round(good * 10000.0 / total) / 100.0 : 0.0);

        Long lowStock = dashboardMapper.countLowStock();
        data.put("lowStock", lowStock != null ? lowStock : 0);

        Long todayShipments = dashboardMapper.sumTodayShipments();
        data.put("todayShipments", todayShipments != null ? todayShipments : 0);

        Long runningEquip = dashboardMapper.countRunningEquip();
        Long totalEquip = dashboardMapper.countTotalEquip();
        data.put("equipRunningRate", totalEquip != null && totalEquip > 0
            ? Math.round(runningEquip * 10000.0 / totalEquip) / 100.0 : 0.0);

        // 质检合格率
        Map<String, Object> qualityData = dashboardMapper.getQualityPassRate();
        long passCount = qualityData != null ? ((Number) qualityData.getOrDefault("pass_count", 0)).longValue() : 0;
        long totalQuality = qualityData != null ? ((Number) qualityData.getOrDefault("total_count", 0)).longValue() : 0;
        data.put("passRate", totalQuality > 0 ? Math.round(passCount * 10000.0 / totalQuality) / 100.0 : 0.0);
        data.put("defectRate", totalQuality > 0 ? Math.round((totalQuality - passCount) * 10000.0 / totalQuality) / 100.0 : 0.0);

        // 工单完成率
        Map<String, Object> completionData = dashboardMapper.getWorkOrderCompletionRate();
        long finishedCount = completionData != null ? ((Number) completionData.getOrDefault("finished_count", 0)).longValue() : 0;
        long totalOrders = completionData != null ? ((Number) completionData.getOrDefault("total_count", 0)).longValue() : 0;
        data.put("completionRate", totalOrders > 0 ? Math.round(finishedCount * 10000.0 / totalOrders) / 100.0 : 0.0);

        return data;
    }

    @Override
    public Object getOrderStatus() {
        return dashboardMapper.getOrderStatusGroup();
    }

    @Override
    public Object getEquipStatus() {
        return dashboardMapper.getEquipStatusGroup();
    }

    @Override
    public Object getInventoryStats() {
        return dashboardMapper.getInventoryTypeStats();
    }

    @Override
    public Object getYieldTrend() {
        return dashboardMapper.getYieldTrend7Days();
    }

    @Override
    public Object getWorkOrderTrend() {
        return dashboardMapper.getWorkOrderTrend7Days();
    }

    @Override
    public Object getLowStockTop10() {
        return dashboardMapper.getLowStockTop10();
    }
}
