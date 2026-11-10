package com.ruoyi.mes.dto;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "工单查询条件")
public class WorkOrderQueryDTO
{
    @Schema(description = "工单编号")
    private String workOrderNo;
    @Schema(description = "订单ID")
    private Long orderId;
    @Schema(description = "工单状态")
    private String status;

    public String getWorkOrderNo() { return workOrderNo; }
    public void setWorkOrderNo(String v) { this.workOrderNo = v; }
    public Long getOrderId() { return orderId; }
    public void setOrderId(Long v) { this.orderId = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { this.status = v; }
}
