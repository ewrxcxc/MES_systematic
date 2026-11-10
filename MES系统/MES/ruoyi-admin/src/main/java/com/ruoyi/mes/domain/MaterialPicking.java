package com.ruoyi.mes.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "领料单")
public class MaterialPicking extends BaseEntity
{
    private static final long serialVersionUID = 1L;
    private Long pickingId;
    @Schema(description = "领料单号") private String pickingNo;
    @Schema(description = "工单ID") private Long workOrderId;
    @Schema(description = "工单编号") private String workOrderNo;
    @Schema(description = "计划ID") private Long planId;
    @Schema(description = "状态") private String pickingStatus;
    @Schema(description = "领料人") private String pickingBy;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "领料时间") private Date pickingTime;

    public Long getPickingId() { return pickingId; }
    public void setPickingId(Long v) { this.pickingId = v; }
    public String getPickingNo() { return pickingNo; }
    public void setPickingNo(String v) { this.pickingNo = v; }
    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public String getWorkOrderNo() { return workOrderNo; }
    public void setWorkOrderNo(String v) { this.workOrderNo = v; }
    public Long getPlanId() { return planId; }
    public void setPlanId(Long v) { this.planId = v; }
    public String getPickingStatus() { return pickingStatus; }
    public void setPickingStatus(String v) { this.pickingStatus = v; }
    public String getPickingBy() { return pickingBy; }
    public void setPickingBy(String v) { this.pickingBy = v; }
    public Date getPickingTime() { return pickingTime; }
    public void setPickingTime(Date v) { this.pickingTime = v; }
}
