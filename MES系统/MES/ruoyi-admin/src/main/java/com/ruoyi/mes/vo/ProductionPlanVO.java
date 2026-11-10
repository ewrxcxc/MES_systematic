package com.ruoyi.mes.vo;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "生产计划视图对象")
public class ProductionPlanVO
{
    private Long planId;
    private String planNo;
    private Long salesOrderId;
    private String orderNo;
    private Long customerId;
    private String customerName;
    private Long productId;
    private String productName;
    private Integer orderQuantity;
    private Integer inventoryQuantity;
    private Integer safeStock;
    private Integer requiredQuantity;
    private Integer priority;
    private Integer isUrgent;
    private String planStatus;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date planStartTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date planEndTime;
    private Integer plannedQty;
    private Integer completedQty;
    private String remark;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;

    public Long getPlanId() { return planId; }
    public void setPlanId(Long v) { this.planId = v; }
    public String getPlanNo() { return planNo; }
    public void setPlanNo(String v) { this.planNo = v; }
    public Long getSalesOrderId() { return salesOrderId; }
    public void setSalesOrderId(Long v) { this.salesOrderId = v; }
    public String getOrderNo() { return orderNo; }
    public void setOrderNo(String v) { this.orderNo = v; }
    public Long getCustomerId() { return customerId; }
    public void setCustomerId(Long v) { this.customerId = v; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String v) { this.customerName = v; }
    public Long getProductId() { return productId; }
    public void setProductId(Long v) { this.productId = v; }
    public String getProductName() { return productName; }
    public void setProductName(String v) { this.productName = v; }
    public Integer getOrderQuantity() { return orderQuantity; }
    public void setOrderQuantity(Integer v) { this.orderQuantity = v; }
    public Integer getInventoryQuantity() { return inventoryQuantity; }
    public void setInventoryQuantity(Integer v) { this.inventoryQuantity = v; }
    public Integer getSafeStock() { return safeStock; }
    public void setSafeStock(Integer v) { this.safeStock = v; }
    public Integer getRequiredQuantity() { return requiredQuantity; }
    public void setRequiredQuantity(Integer v) { this.requiredQuantity = v; }
    public Integer getPriority() { return priority; }
    public void setPriority(Integer v) { this.priority = v; }
    public Integer getIsUrgent() { return isUrgent; }
    public void setIsUrgent(Integer v) { this.isUrgent = v; }
    public String getPlanStatus() { return planStatus; }
    public void setPlanStatus(String v) { this.planStatus = v; }
    public Date getPlanStartTime() { return planStartTime; }
    public void setPlanStartTime(Date v) { this.planStartTime = v; }
    public Date getPlanEndTime() { return planEndTime; }
    public void setPlanEndTime(Date v) { this.planEndTime = v; }
    public String getRemark() { return remark; }
    public void setRemark(String v) { this.remark = v; }
    public Integer getPlannedQty() { return plannedQty; }
    public void setPlannedQty(Integer v) { this.plannedQty = v; }
    public Integer getCompletedQty() { return completedQty; }
    public void setCompletedQty(Integer v) { this.completedQty = v; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date v) { this.createTime = v; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date v) { this.updateTime = v; }
}
