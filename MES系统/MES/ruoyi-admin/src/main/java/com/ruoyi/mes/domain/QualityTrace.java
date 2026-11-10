package com.ruoyi.mes.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "质量追溯")
public class QualityTrace extends BaseEntity
{
    private Long traceId;
    @Schema(description = "追溯类型") private String traceType;
    @Schema(description = "追溯关键字") private String traceKey;
    @Schema(description = "产品ID") private Long productId;
    @Schema(description = "产品编码") private String productCode;
    @Schema(description = "计划ID") private Long planId;
    @Schema(description = "计划编号") private String planNo;
    @Schema(description = "订单ID") private Long orderId;
    @Schema(description = "订单编号") private String orderNo;
    @Schema(description = "工单ID") private Long workOrderId;
    @Schema(description = "工单编号") private String workOrderNo;
    @Schema(description = "批次号") private String batchNo;
    @Schema(description = "原材料批次号") private String rawBatchNo;
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Schema(description = "生产日期") private Date productionDate;
    @Schema(description = "检验人") private String inspector;
    @Schema(description = "检验结果") private String inspectResult;
    @Schema(description = "追溯数据JSON") private String traceData;

    public Long getTraceId() { return traceId; }
    public void setTraceId(Long v) { this.traceId = v; }
    public String getTraceType() { return traceType; }
    public void setTraceType(String v) { this.traceType = v; }
    public String getTraceKey() { return traceKey; }
    public void setTraceKey(String v) { this.traceKey = v; }
    public Long getProductId() { return productId; }
    public void setProductId(Long v) { this.productId = v; }
    public String getProductCode() { return productCode; }
    public void setProductCode(String v) { this.productCode = v; }
    public Long getPlanId() { return planId; }
    public void setPlanId(Long v) { this.planId = v; }
    public String getPlanNo() { return planNo; }
    public void setPlanNo(String v) { this.planNo = v; }
    public Long getOrderId() { return orderId; }
    public void setOrderId(Long v) { this.orderId = v; }
    public String getOrderNo() { return orderNo; }
    public void setOrderNo(String v) { this.orderNo = v; }
    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public String getWorkOrderNo() { return workOrderNo; }
    public void setWorkOrderNo(String v) { this.workOrderNo = v; }
    public String getBatchNo() { return batchNo; }
    public void setBatchNo(String v) { this.batchNo = v; }
    public String getRawBatchNo() { return rawBatchNo; }
    public void setRawBatchNo(String v) { this.rawBatchNo = v; }
    public Date getProductionDate() { return productionDate; }
    public void setProductionDate(Date v) { this.productionDate = v; }
    public String getInspector() { return inspector; }
    public void setInspector(String v) { this.inspector = v; }
    public String getInspectResult() { return inspectResult; }
    public void setInspectResult(String v) { this.inspectResult = v; }
    public String getTraceData() { return traceData; }
    public void setTraceData(String v) { this.traceData = v; }
}
