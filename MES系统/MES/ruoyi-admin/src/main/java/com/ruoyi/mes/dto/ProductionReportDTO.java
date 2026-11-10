package com.ruoyi.mes.dto;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "生产报告保存请求")
public class ProductionReportDTO
{
    private Long reportId;
    private Long workOrderId;
    private Long operatorId;
    private Long equipmentId;
    private Integer processSeq;
    private String processName;
    private Integer goodQty;
    private Integer badQty;
    private String reportType;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date reportTime;
    private String remark;
    private String status;
    private String inspector;
    private String qualityResult;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date qualityTime;

    public Long getReportId() { return reportId; }
    public void setReportId(Long v) { this.reportId = v; }
    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public Long getOperatorId() { return operatorId; }
    public void setOperatorId(Long v) { this.operatorId = v; }
    public Long getEquipmentId() { return equipmentId; }
    public void setEquipmentId(Long v) { this.equipmentId = v; }
    public Integer getProcessSeq() { return processSeq; }
    public void setProcessSeq(Integer v) { this.processSeq = v; }
    public String getProcessName() { return processName; }
    public void setProcessName(String v) { this.processName = v; }
    public Integer getGoodQty() { return goodQty; }
    public void setGoodQty(Integer v) { this.goodQty = v; }
    public Integer getBadQty() { return badQty; }
    public void setBadQty(Integer v) { this.badQty = v; }
    public String getReportType() { return reportType; }
    public void setReportType(String v) { this.reportType = v; }
    public Date getReportTime() { return reportTime; }
    public void setReportTime(Date v) { this.reportTime = v; }
    public String getRemark() { return remark; }
    public void setRemark(String v) { this.remark = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { this.status = v; }
    public String getInspector() { return inspector; }
    public void setInspector(String v) { this.inspector = v; }
    public String getQualityResult() { return qualityResult; }
    public void setQualityResult(String v) { this.qualityResult = v; }
    public Date getQualityTime() { return qualityTime; }
    public void setQualityTime(Date v) { this.qualityTime = v; }
}
