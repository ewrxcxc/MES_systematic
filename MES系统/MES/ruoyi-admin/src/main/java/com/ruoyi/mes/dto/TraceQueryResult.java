package com.ruoyi.mes.dto;

import java.util.List;
import java.util.Map;

/**
 * 追溯查询结果 — 按 workOrderNo 查询返回的聚合 DTO
 */
public class TraceQueryResult {

    /** 订单信息 (sales_order) */
    private Map<String, Object> orderInfo;

    /** 工单信息 (work_order) */
    private Map<String, Object> workOrderInfo;

    /** 工序列表 (mes_process_task + production_report + mes_quality_trace 合并) */
    private List<Map<String, Object>> processList;

    /** 质量结果汇总 */
    private Map<String, Object> qcResult;

    public Map<String, Object> getOrderInfo() { return orderInfo; }
    public void setOrderInfo(Map<String, Object> orderInfo) { this.orderInfo = orderInfo; }

    public Map<String, Object> getWorkOrderInfo() { return workOrderInfo; }
    public void setWorkOrderInfo(Map<String, Object> workOrderInfo) { this.workOrderInfo = workOrderInfo; }

    public List<Map<String, Object>> getProcessList() { return processList; }
    public void setProcessList(List<Map<String, Object>> processList) { this.processList = processList; }

    public Map<String, Object> getQcResult() { return qcResult; }
    public void setQcResult(Map<String, Object> qcResult) { this.qcResult = qcResult; }
}
