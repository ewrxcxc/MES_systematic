package com.ruoyi.mes.domain;

import java.util.Date;
import jakarta.validation.constraints.Size;
import io.swagger.v3.oas.annotations.media.Schema;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

@Schema(description = "工单")
public class WorkOrder extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    @Schema(description = "工单ID")
    private Long workOrderId;

    @Excel(name = "工单编号")
    @Schema(description = "工单编号")
    private String workOrderNo;

    @Schema(description = "订单ID")
    private Long orderId;

    @Schema(description = "生产计划ID")
    private Long planId;

    @Excel(name = "计划数量")
    @Schema(description = "计划数量")
    private Integer plannedQty;

    @Excel(name = "完成数量")
    @Schema(description = "完成数量")
    private Integer completedQty;

    @Excel(name = "工单状态", readConverterExp = "WAITING=等待,READY=就绪,RUNNING=运行中,FINISHED=已完成,PAUSED=暂停")
    @Schema(description = "工单状态")
    private String status;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "计划开始时间")
    private Date plannedStart;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "计划结束时间")
    private Date plannedEnd;

    @Schema(description = "当前工序序号")
    private Integer currentStep;

    @Schema(description = "总工序数")
    private Integer totalSteps;

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
    public Integer getCurrentStep() { return currentStep; }
    public void setCurrentStep(Integer v) { this.currentStep = v; }
    public Integer getTotalSteps() { return totalSteps; }
    public void setTotalSteps(Integer v) { this.totalSteps = v; }
}
