package com.ruoyi.mes.domain;

import java.util.Date;
import io.swagger.v3.oas.annotations.media.Schema;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

@Schema(description = "生产报告")
public class ProductionReport extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    @Schema(description = "报告ID")
    private Long reportId;

    @Schema(description = "工单ID")
    private Long workOrderId;

    @Schema(description = "生产计划ID")
    private Long planId;

    @Schema(description = "操作员ID")
    private Long operatorId;

    @Schema(description = "设备ID")
    private Long equipmentId;

    @Excel(name = "良品数量")
    @Schema(description = "良品数量")
    private Integer goodQty;

    @Excel(name = "不良品数量")
    @Schema(description = "不良品数量")
    private Integer badQty;

    @Excel(name = "报告类型", readConverterExp = "NORMAL=普通报工,REPAIR=补报,START=开工,PROGRESS=进度,FINISH=完工")
    @Schema(description = "报告类型")
    private String reportType;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "报告时间")
    private Date reportTime;

    @Schema(description = "工序序号")
    private Integer processSeq;

    @Schema(description = "工序名称")
    private String processName;

    @Schema(description = "状态(REPORTED/INSPECTED/COMPLETED)")
    private String status;

    @Schema(description = "质检人")
    private String inspector;

    @Schema(description = "质检结果(PASS/FAIL)")
    private String qualityResult;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "质检时间")
    private Date qualityTime;

    public Long getReportId() { return reportId; }
    public void setReportId(Long v) { this.reportId = v; }
    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public Long getPlanId() { return planId; }
    public void setPlanId(Long v) { this.planId = v; }
    public Long getOperatorId() { return operatorId; }
    public void setOperatorId(Long v) { this.operatorId = v; }
    public Long getEquipmentId() { return equipmentId; }
    public void setEquipmentId(Long v) { this.equipmentId = v; }
    public Integer getGoodQty() { return goodQty; }
    public void setGoodQty(Integer v) { this.goodQty = v; }
    public Integer getBadQty() { return badQty; }
    public void setBadQty(Integer v) { this.badQty = v; }
    public String getReportType() { return reportType; }
    public void setReportType(String v) { this.reportType = v; }
    public Date getReportTime() { return reportTime; }
    public void setReportTime(Date v) { this.reportTime = v; }
    public Integer getProcessSeq() { return processSeq; }
    public void setProcessSeq(Integer v) { this.processSeq = v; }
    public String getProcessName() { return processName; }
    public void setProcessName(String v) { this.processName = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { this.status = v; }
    public String getInspector() { return inspector; }
    public void setInspector(String v) { this.inspector = v; }
    public String getQualityResult() { return qualityResult; }
    public void setQualityResult(String v) { this.qualityResult = v; }
    public Date getQualityTime() { return qualityTime; }
    public void setQualityTime(Date v) { this.qualityTime = v; }
}
