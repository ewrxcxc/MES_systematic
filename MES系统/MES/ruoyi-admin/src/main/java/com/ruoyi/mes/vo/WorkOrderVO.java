package com.ruoyi.mes.vo;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "工单展示对象")
public class WorkOrderVO
{
    private Long workOrderId;
    private String workOrderNo;
    private Long orderId;
    private String orderNo;
    private Long planId;
    private String planNo;
    private Integer plannedQty;
    private Integer completedQty;
    private String status;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date plannedStart;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date plannedEnd;
    private Integer currentStep;
    private Integer totalSteps;
    private Long productId;
    private String productName;
    private String productCode;
    private String remark;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;

    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public String getWorkOrderNo() { return workOrderNo; }
    public void setWorkOrderNo(String v) { this.workOrderNo = v; }
    public Long getOrderId() { return orderId; }
    public void setOrderId(Long v) { this.orderId = v; }
    public String getOrderNo() { return orderNo; }
    public void setOrderNo(String v) { this.orderNo = v; }
    public Long getPlanId() { return planId; }
    public void setPlanId(Long v) { this.planId = v; }
    public String getPlanNo() { return planNo; }
    public void setPlanNo(String v) { this.planNo = v; }
    public Integer getPlannedQty() { return plannedQty; }
    public void setPlannedQty(Integer v) { this.plannedQty = v; }
    public Integer getCompletedQty() { return completedQty; }
    public void setCompletedQty(Integer v) { this.completedQty = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { this.status = v; }
    public Date getPlannedStart() { return plannedStart; }
    public void setPlannedStart(Date v) { this.plannedStart = v; }
    public Date getPlannedEnd() { return plannedEnd; }
    public void setPlannedEnd(Date v) { this.plannedEnd = v; }
    public Integer getCurrentStep() { return currentStep; }
    public void setCurrentStep(Integer v) { this.currentStep = v; }
    public Integer getTotalSteps() { return totalSteps; }
    public void setTotalSteps(Integer v) { this.totalSteps = v; }
    public Long getProductId() { return productId; }
    public void setProductId(Long v) { this.productId = v; }
    public String getProductName() { return productName; }
    public void setProductName(String v) { this.productName = v; }
    public String getProductCode() { return productCode; }
    public void setProductCode(String v) { this.productCode = v; }
    public String getRemark() { return remark; }
    public void setRemark(String v) { this.remark = v; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date v) { this.createTime = v; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date v) { this.updateTime = v; }
}
