package com.ruoyi.mes.vo;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

public class TraceVO extends BaseEntity
{
    private Long traceId;
    private String traceType;
    private Long orderId;
    private String orderNo;
    private String productName;
    private String productCode;
    private Long planId;
    private String planNo;
    private Long workOrderId;
    private String workOrderNo;
    private String processName;
    private String equipmentName;
    private String operatorName;
    private Integer reportQty;
    private Integer goodQty;
    private Integer badQty;
    private String inspectResult;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date productionDate;
    private String shipmentNo;
    private String deliveryStatus;

    public Long getTraceId() { return traceId; }
    public void setTraceId(Long v) { this.traceId = v; }
    public String getTraceType() { return traceType; }
    public void setTraceType(String v) { this.traceType = v; }
    public Long getOrderId() { return orderId; }
    public void setOrderId(Long v) { this.orderId = v; }
    public String getOrderNo() { return orderNo; }
    public void setOrderNo(String v) { this.orderNo = v; }
    public String getProductName() { return productName; }
    public void setProductName(String v) { this.productName = v; }
    public String getProductCode() { return productCode; }
    public void setProductCode(String v) { this.productCode = v; }
    public Long getPlanId() { return planId; }
    public void setPlanId(Long v) { this.planId = v; }
    public String getPlanNo() { return planNo; }
    public void setPlanNo(String v) { this.planNo = v; }
    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public String getWorkOrderNo() { return workOrderNo; }
    public void setWorkOrderNo(String v) { this.workOrderNo = v; }
    public String getProcessName() { return processName; }
    public void setProcessName(String v) { this.processName = v; }
    public String getEquipmentName() { return equipmentName; }
    public void setEquipmentName(String v) { this.equipmentName = v; }
    public String getOperatorName() { return operatorName; }
    public void setOperatorName(String v) { this.operatorName = v; }
    public Integer getReportQty() { return reportQty; }
    public void setReportQty(Integer v) { this.reportQty = v; }
    public Integer getGoodQty() { return goodQty; }
    public void setGoodQty(Integer v) { this.goodQty = v; }
    public Integer getBadQty() { return badQty; }
    public void setBadQty(Integer v) { this.badQty = v; }
    public String getInspectResult() { return inspectResult; }
    public void setInspectResult(String v) { this.inspectResult = v; }
    public Date getProductionDate() { return productionDate; }
    public void setProductionDate(Date v) { this.productionDate = v; }
    public String getShipmentNo() { return shipmentNo; }
    public void setShipmentNo(String v) { this.shipmentNo = v; }
    public String getDeliveryStatus() { return deliveryStatus; }
    public void setDeliveryStatus(String v) { this.deliveryStatus = v; }
}
