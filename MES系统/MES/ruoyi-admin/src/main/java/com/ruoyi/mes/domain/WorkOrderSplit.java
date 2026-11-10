package com.ruoyi.mes.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "工单拆卡")
public class WorkOrderSplit extends BaseEntity
{
    private static final long serialVersionUID = 1L;
    private Long splitId;
    @Schema(description = "父工单ID") private Long parentWorkOrderId;
    @Schema(description = "子工单ID") private Long workOrderId;
    @Schema(description = "子工单号") private String splitNo;
    @Schema(description = "产线ID") private Long lineId;
    @Schema(description = "产线名称") private String lineName;
    @Schema(description = "班组") private String teamName;
    @Schema(description = "拆分数量") private Integer splitQty;
    @Schema(description = "完成数量") private Integer completedQty;
    @Schema(description = "状态") private String status;

    public Long getSplitId() { return splitId; }
    public void setSplitId(Long v) { this.splitId = v; }
    public Long getParentWorkOrderId() { return parentWorkOrderId; }
    public void setParentWorkOrderId(Long v) { this.parentWorkOrderId = v; }
    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public String getSplitNo() { return splitNo; }
    public void setSplitNo(String v) { this.splitNo = v; }
    public Long getLineId() { return lineId; }
    public void setLineId(Long v) { this.lineId = v; }
    public String getLineName() { return lineName; }
    public void setLineName(String v) { this.lineName = v; }
    public String getTeamName() { return teamName; }
    public void setTeamName(String v) { this.teamName = v; }
    public Integer getSplitQty() { return splitQty; }
    public void setSplitQty(Integer v) { this.splitQty = v; }
    public Integer getCompletedQty() { return completedQty; }
    public void setCompletedQty(Integer v) { this.completedQty = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { this.status = v; }
}
