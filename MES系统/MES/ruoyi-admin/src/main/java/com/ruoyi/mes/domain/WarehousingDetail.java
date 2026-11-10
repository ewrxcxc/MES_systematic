package com.ruoyi.mes.domain;

import java.math.BigDecimal;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "入库单明细")
public class WarehousingDetail
{
    private Long detailId;
    @Schema(description = "入库单ID") private Long warehousingId;
    @Schema(description = "产品编码") private String productCode;
    @Schema(description = "产品名称") private String productName;
    @Schema(description = "入库数量") private BigDecimal quantity;
    @Schema(description = "单位") private String unit;
    @Schema(description = "批次号") private String batchNo;
    @Schema(description = "库位") private String location;
    @Schema(description = "质检结果") private String inspectResult;

    public Long getDetailId() { return detailId; }
    public void setDetailId(Long v) { this.detailId = v; }
    public Long getWarehousingId() { return warehousingId; }
    public void setWarehousingId(Long v) { this.warehousingId = v; }
    public String getProductCode() { return productCode; }
    public void setProductCode(String v) { this.productCode = v; }
    public String getProductName() { return productName; }
    public void setProductName(String v) { this.productName = v; }
    public BigDecimal getQuantity() { return quantity; }
    public void setQuantity(BigDecimal v) { this.quantity = v; }
    public String getUnit() { return unit; }
    public void setUnit(String v) { this.unit = v; }
    public String getBatchNo() { return batchNo; }
    public void setBatchNo(String v) { this.batchNo = v; }
    public String getLocation() { return location; }
    public void setLocation(String v) { this.location = v; }
    public String getInspectResult() { return inspectResult; }
    public void setInspectResult(String v) { this.inspectResult = v; }
}
