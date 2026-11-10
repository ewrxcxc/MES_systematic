package com.ruoyi.mes.domain;

import java.math.BigDecimal;
import io.swagger.v3.oas.annotations.media.Schema;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

@Schema(description = "库存")
public class Inventory extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    @Schema(description = "库存ID")
    private Long inventoryId;

    @Excel(name = "库存类型")
    @Schema(description = "库存类型")
    private String inventoryType;

    @Excel(name = "物料编码")
    @Schema(description = "物料编码")
    private String materialCode;

    @Excel(name = "物料名称")
    @Schema(description = "物料名称")
    private String materialName;

    @Excel(name = "库存数量")
    @Schema(description = "库存数量")
    private BigDecimal quantity;

    @Excel(name = "库位")
    @Schema(description = "库位")
    private String location;

    public Long getInventoryId() { return inventoryId; }
    public void setInventoryId(Long v) { this.inventoryId = v; }
    public String getInventoryType() { return inventoryType; }
    public void setInventoryType(String v) { this.inventoryType = v; }
    public String getMaterialCode() { return materialCode; }
    public void setMaterialCode(String v) { this.materialCode = v; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String v) { this.materialName = v; }
    public BigDecimal getQuantity() { return quantity; }
    public void setQuantity(BigDecimal v) { this.quantity = v; }
    public String getLocation() { return location; }
    public void setLocation(String v) { this.location = v; }
}
