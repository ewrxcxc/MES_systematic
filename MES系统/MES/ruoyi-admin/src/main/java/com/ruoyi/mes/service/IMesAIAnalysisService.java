package com.ruoyi.mes.service;

import java.util.List;
import java.util.Map;

public interface IMesAIAnalysisService {
    Map<String, Object> analyzeSalesOrder(String orderNo);
    List<Map<String, Object>> getDistinctOrders();
}
