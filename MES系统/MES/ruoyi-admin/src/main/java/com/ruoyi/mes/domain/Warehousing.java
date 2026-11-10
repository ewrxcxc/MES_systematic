package com.ruoyi.mes.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "入库单")
public class Warehousing extends BaseEntity
{
    private static final long serialVersionUID = 1L;
    private Long warehousingId;
    @Schema(description = "入库单号") private String warehousingNo;
    @Schema(description = "工单ID") private Long workOrderId;
    @Schema(description = "工单编号") private String workOrderNo;
    @Schema(description = "计划ID") private Long planId;
    @Schema(description = "产品ID") private Long productId;
    @Schema(description = "入库类型") private String warehousingType;
    @Schema(description = "入库状态") private String warehousingStatus;
    @Schema(description = "质检人") private String inspector;
    @Schema(description = "质检结果") private String inspectResult;
    @Schema(description = "经手人") private String warehousingBy;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "入库时间") private Date warehousingTime;
    @Schema(description = "库位") private String location;

    public Long getWarehousingId() { return warehousingId; }
    public void setWarehousingId(Long v) { this.warehousingId = v; }
    public String getWarehousingNo() { return warehousingNo; }
    public void setWarehousingNo(String v) { this.warehousingNo = v; }
    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public String getWorkOrderNo() { return workOrderNo; }
    public void setWorkOrderNo(String v) { this.workOrderNo = v; }
    public Long getPlanId() { return planId; }
    public void setPlanId(Long v) { this.planId = v; }
    public Long getProductId() { return productId; }
    public void setProductId(Long v) { this.productId = v; }
    public String getWarehousingType() { return warehousingType; }
    public void setWarehousingType(String v) { this.warehousingType = v; }
    public String getWarehousingStatus() { return warehousingStatus; }
    public void setWarehousingStatus(String v) { this.warehousingStatus = v; }
    public String getInspector() { return inspector; }
    public void setInspector(String v) { this.inspector = v; }
    public String getInspectResult() { return inspectResult; }
    public void setInspectResult(String v) { this.inspectResult = v; }
    public String getWarehousingBy() { return warehousingBy; }
    public void setWarehousingBy(String v) { this.warehousingBy = v; }
    public Date getWarehousingTime() { return warehousingTime; }
    public void setWarehousingTime(Date v) { this.warehousingTime = v; }
    public String getLocation() { return location; }
    public void setLocation(String v) { this.location = v; }
}
