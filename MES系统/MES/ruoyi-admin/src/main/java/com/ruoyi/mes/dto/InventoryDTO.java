package com.ruoyi.mes.dto;

import java.math.BigDecimal;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "库存保存请求")
public class InventoryDTO
{
    private Long inventoryId;
    private String inventoryType;
    private String materialCode;
    private String materialName;
    private BigDecimal quantity;
    private String location;
    private String remark;

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
    public String getRemark() { return remark; }
    public void setRemark(String v) { this.remark = v; }
}
