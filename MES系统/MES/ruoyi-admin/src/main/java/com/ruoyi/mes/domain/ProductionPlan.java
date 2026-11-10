package com.ruoyi.mes.domain;

import java.util.Date;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "生产计划")
public class ProductionPlan extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    @Schema(description = "计划ID")
    private Long planId;
    @Excel(name = "计划编号")
    private String planNo;
    @Schema(description = "销售订单ID")
    private Long salesOrderId;
    @Schema(description = "客户ID")
    private Long customerId;
    @Schema(description = "产品ID")
    private Long productId;
    @Excel(name = "订单数量")
    private Integer orderQuantity;
    @Excel(name = "库存数量")
    private Integer inventoryQuantity;
    @Excel(name = "安全库存")
    private Integer safeStock;
    @Excel(name = "需求数量")
    private Integer requiredQuantity;
    @Schema(description = "优先级(越小越高)")
    private Integer priority;
    @Schema(description = "是否紧急(0=否,1=是)")
    private Integer isUrgent;
    @Excel(name = "计划状态", readConverterExp = "待排产=待排产,已排产=已排产,生产中=生产中,已完成=已完成")
    private String planStatus;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date planStartTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date planEndTime;

    // getters/setters
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
}
