package com.ruoyi.mes.dto;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "生产报告查询条件")
public class ProductionReportQueryDTO
{
    private Long workOrderId;
    private String workOrderNo;
    private Long operatorId;
    private String reportType;
    private String status;
    private String processName;
    private String productName;

    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public String getWorkOrderNo() { return workOrderNo; }
    public void setWorkOrderNo(String v) { this.workOrderNo = v; }
    public Long getOperatorId() { return operatorId; }
    public void setOperatorId(Long v) { this.operatorId = v; }
    public String getReportType() { return reportType; }
    public void setReportType(String v) { this.reportType = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { this.status = v; }
    public String getProcessName() { return processName; }
    public void setProcessName(String v) { this.processName = v; }
    public String getProductName() { return productName; }
    public void setProductName(String v) { this.productName = v; }
}
