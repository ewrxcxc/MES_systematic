package com.ruoyi.mes.dto;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "生产计划查询请求")
public class ProductionPlanQueryDTO
{
    private String planNo;
    private String orderNo;
    private String productName;
    private Long salesOrderId;
    private Long customerId;
    private Integer isUrgent;
    private String planStatus;
    private String planStartTimeBegin;
    private String planEndTimeEnd;

    public String getPlanNo() { return planNo; }
    public void setPlanNo(String v) { this.planNo = v; }
    public String getOrderNo() { return orderNo; }
    public void setOrderNo(String v) { this.orderNo = v; }
    public String getProductName() { return productName; }
    public void setProductName(String v) { this.productName = v; }
    public Long getSalesOrderId() { return salesOrderId; }
    public void setSalesOrderId(Long v) { this.salesOrderId = v; }
    public Long getCustomerId() { return customerId; }
    public void setCustomerId(Long v) { this.customerId = v; }
    public Integer getIsUrgent() { return isUrgent; }
    public void setIsUrgent(Integer v) { this.isUrgent = v; }
    public String getPlanStatus() { return planStatus; }
    public void setPlanStatus(String v) { this.planStatus = v; }
    public String getPlanStartTimeBegin() { return planStartTimeBegin; }
    public void setPlanStartTimeBegin(String v) { this.planStartTimeBegin = v; }
    public String getPlanEndTimeEnd() { return planEndTimeEnd; }
    public void setPlanEndTimeEnd(String v) { this.planEndTimeEnd = v; }
}
