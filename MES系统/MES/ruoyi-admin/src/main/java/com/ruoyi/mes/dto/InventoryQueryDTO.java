package com.ruoyi.mes.dto;

import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "库存查询条件")
public class InventoryQueryDTO
{
    private String inventoryType;
    private String materialCode;
    private String materialName;

    public String getInventoryType() { return inventoryType; }
    public void setInventoryType(String v) { this.inventoryType = v; }
    public String getMaterialCode() { return materialCode; }
    public void setMaterialCode(String v) { this.materialCode = v; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String v) { this.materialName = v; }
}
