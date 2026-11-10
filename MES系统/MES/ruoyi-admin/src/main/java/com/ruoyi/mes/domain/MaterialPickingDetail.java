package com.ruoyi.mes.domain;

import java.math.BigDecimal;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "领料单明细")
public class MaterialPickingDetail
{
    private Long detailId;
    @Schema(description = "领料单ID") private Long pickingId;
    @Schema(description = "物料编码") private String materialCode;
    @Schema(description = "物料名称") private String materialName;
    @Schema(description = "BOM单件用量") private BigDecimal bomUsage;
    @Schema(description = "需求数量") private BigDecimal requiredQty;
    @Schema(description = "实发数量") private BigDecimal actualQty;
    @Schema(description = "单位") private String unit;
    @Schema(description = "库存记录ID") private Long inventoryId;
    @Schema(description = "状态") private String status;

    public Long getDetailId() { return detailId; }
    public void setDetailId(Long v) { this.detailId = v; }
    public Long getPickingId() { return pickingId; }
    public void setPickingId(Long v) { this.pickingId = v; }
    public String getMaterialCode() { return materialCode; }
    public void setMaterialCode(String v) { this.materialCode = v; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String v) { this.materialName = v; }
    public BigDecimal getBomUsage() { return bomUsage; }
    public void setBomUsage(BigDecimal v) { this.bomUsage = v; }
    public BigDecimal getRequiredQty() { return requiredQty; }
    public void setRequiredQty(BigDecimal v) { this.requiredQty = v; }
    public BigDecimal getActualQty() { return actualQty; }
    public void setActualQty(BigDecimal v) { this.actualQty = v; }
    public String getUnit() { return unit; }
    public void setUnit(String v) { this.unit = v; }
    public Long getInventoryId() { return inventoryId; }
    public void setInventoryId(Long v) { this.inventoryId = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { this.status = v; }
}
