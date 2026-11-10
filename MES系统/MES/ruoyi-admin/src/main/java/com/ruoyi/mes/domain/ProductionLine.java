package com.ruoyi.mes.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "产线")
public class ProductionLine extends BaseEntity
{
    private static final long serialVersionUID = 1L;
    private Long lineId;
    @Schema(description = "产线编码") private String lineCode;
    @Schema(description = "产线名称") private String lineName;
    @Schema(description = "描述") private String description;
    @Schema(description = "状态") private String status;

    public Long getLineId() { return lineId; }
    public void setLineId(Long v) { this.lineId = v; }
    public String getLineCode() { return lineCode; }
    public void setLineCode(String v) { this.lineCode = v; }
    public String getLineName() { return lineName; }
    public void setLineName(String v) { this.lineName = v; }
    public String getDescription() { return description; }
    public void setDescription(String v) { this.description = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { this.status = v; }
}
