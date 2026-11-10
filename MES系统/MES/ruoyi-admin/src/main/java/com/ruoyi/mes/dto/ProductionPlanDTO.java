package com.ruoyi.mes.dto;

import java.util.Date;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "生产计划保存请求")
public class ProductionPlanDTO
{
    private Long planId;
    private String planNo;
    private Long salesOrderId;
    private Long customerId;
    private Long productId;
    private Integer orderQuantity;
    private Integer inventoryQuantity;
    private Integer safeStock;
    private Integer requiredQuantity;
    private Integer priority;
    private Integer isUrgent;
    private String planStatus;
    private Date planStartTime;
    private Date planEndTime;
    private String remark;

    public Long getPlanId() { return planId; }
    public void setPlanId(Long v) { this.planId = v; }
    public String getPlanNo() { return planNo; }
    public void setPlanNo(String v) { this.planNo = v; }
    public Long getSalesOrderId() { return salesOrderId; }
    public void setSalesOrderId(Long v) { this.salesOrderId = v; }
    public Long getCustomerId() { return customerId; }
    public void setCustomerId(Long v) { this.customerId = v; }
    public Long getProductId() { return productId; }
    public void setProductId(Long v) { this.productId = v; }
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
}
