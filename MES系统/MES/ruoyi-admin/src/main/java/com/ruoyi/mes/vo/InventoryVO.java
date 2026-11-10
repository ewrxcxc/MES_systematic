package com.ruoyi.mes.vo;

import java.math.BigDecimal;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "库存展示对象")
public class InventoryVO
{
    private Long inventoryId;
    private String inventoryType;
    private String materialCode;
    private String materialName;
    private BigDecimal quantity;
    private String location;
    private String remark;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;

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
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date v) { this.createTime = v; }
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date v) { this.updateTime = v; }
}
