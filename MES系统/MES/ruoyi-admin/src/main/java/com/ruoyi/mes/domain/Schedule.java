package com.ruoyi.mes.domain;

import java.util.Date;
import io.swagger.v3.oas.annotations.media.Schema;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

@Schema(description = "排程")
public class Schedule extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    @Schema(description = "排程ID")
    private Long scheduleId;

    @Excel(name = "排程编号")
    @Schema(description = "排程编号")
    private String scheduleNo;

    @Schema(description = "工单ID")
    private Long workOrderId;

    @Schema(description = "产品ID")
    private Long productId;

    @Excel(name = "产品名称")
    @Schema(description = "产品名称")
    private String productName;

    @Excel(name = "工单编号")
    @Schema(description = "工单编号")
    private String workOrderNo;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "计划开始时间")
    private Date plannedStart;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "计划结束时间")
    private Date plannedEnd;

    @Excel(name = "优先级", readConverterExp = "1=最低,2=低,3=中,4=高,5=最高")
    @Schema(description = "优先级(1-5)")
    private Integer priority;

    @Excel(name = "排程状态", readConverterExp = "PENDING=待排程,RUNNING=执行中,FINISHED=已完成,CANCELLED=已取消")
    @Schema(description = "排程状态")
    private String status;

    public Long getScheduleId() { return scheduleId; }
    public void setScheduleId(Long v) { this.scheduleId = v; }
    public String getScheduleNo() { return scheduleNo; }
    public void setScheduleNo(String v) { this.scheduleNo = v; }
    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public Long getProductId() { return productId; }
    public void setProductId(Long v) { this.productId = v; }
    public String getProductName() { return productName; }
    public void setProductName(String v) { this.productName = v; }
    public String getWorkOrderNo() { return workOrderNo; }
    public void setWorkOrderNo(String v) { this.workOrderNo = v; }
    public Date getPlannedStart() { return plannedStart; }
    public void setPlannedStart(Date v) { this.plannedStart = v; }
    public Date getPlannedEnd() { return plannedEnd; }
    public void setPlannedEnd(Date v) { this.plannedEnd = v; }
    public Integer getPriority() { return priority; }
    public void setPriority(Integer v) { this.priority = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { this.status = v; }
}
