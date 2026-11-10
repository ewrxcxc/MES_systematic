package com.ruoyi.mes.dto;

import java.util.Date;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "工单保存请求")
public class WorkOrderDTO
{
    @Schema(description = "工单ID")
    private Long workOrderId;
    @Schema(description = "工单编号")
    private String workOrderNo;
    @Schema(description = "订单ID")
    private Long orderId;
    @Schema(description = "生产计划ID")
    private Long planId;
    @Schema(description = "计划数量")
    private Integer plannedQty;
    @Schema(description = "完成数量")
    private Integer completedQty;
    @Schema(description = "工单状态")
    private String status;
    @Schema(description = "计划开始时间")
    private Date plannedStart;
    @Schema(description = "计划结束时间")
    private Date plannedEnd;
    @Schema(description = "备注")
    private String remark;

    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public String getWorkOrderNo() { return workOrderNo; }
    public void setWorkOrderNo(String v) { this.workOrderNo = v; }
    public Long getOrderId() { return orderId; }
    public void setOrderId(Long v) { this.orderId = v; }
    public Long getPlanId() { return planId; }
    public void setPlanId(Long v) { this.planId = v; }
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
    public String getRemark() { return remark; }
    public void setRemark(String v) { this.remark = v; }
}
