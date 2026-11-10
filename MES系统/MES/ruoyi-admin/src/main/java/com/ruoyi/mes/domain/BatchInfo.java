package com.ruoyi.mes.domain;

import java.math.BigDecimal;
import java.util.Date;
import com.ruoyi.common.core.domain.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "批次信息")
public class BatchInfo extends BaseEntity
{
    private Long batchId;
    @Schema(description = "批次号") private String batchNo;
    @Schema(description = "物料编码") private String materialCode;
    @Schema(description = "物料名称") private String materialName;
    @Schema(description = "物料类型") private String materialType;
    @Schema(description = "供应商ID") private Long supplierId;
    @Schema(description = "供应商名称") private String supplierName;
    @Schema(description = "数量") private BigDecimal quantity;
    @Schema(description = "单位") private String unit;
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Schema(description = "生产日期") private Date produceDate;
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Schema(description = "入库日期") private Date receiveDate;
    @Schema(description = "状态") private String status;

    public Long getBatchId() { return batchId; }
    public void setBatchId(Long v) { this.batchId = v; }
    public String getBatchNo() { return batchNo; }
    public void setBatchNo(String v) { this.batchNo = v; }
    public String getMaterialCode() { return materialCode; }
    public void setMaterialCode(String v) { this.materialCode = v; }
    public String getMaterialName() { return materialName; }
    public void setMaterialName(String v) { this.materialName = v; }
    public String getMaterialType() { return materialType; }
    public void setMaterialType(String v) { this.materialType = v; }
    public Long getSupplierId() { return supplierId; }
    public void setSupplierId(Long v) { this.supplierId = v; }
    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String v) { this.supplierName = v; }
    public BigDecimal getQuantity() { return quantity; }
    public void setQuantity(BigDecimal v) { this.quantity = v; }
    public String getUnit() { return unit; }
    public void setUnit(String v) { this.unit = v; }
    public Date getProduceDate() { return produceDate; }
    public void setProduceDate(Date v) { this.produceDate = v; }
    public Date getReceiveDate() { return receiveDate; }
    public void setReceiveDate(Date v) { this.receiveDate = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { this.status = v; }
}
