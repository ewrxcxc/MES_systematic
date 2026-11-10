package com.ruoyi.mes.domain;

import java.util.Date;
import com.ruoyi.common.core.domain.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "缺陷记录")
public class DefectRecord extends BaseEntity
{
    private Long defectId;
    @Schema(description = "缺陷代码") private String defectCode;
    @Schema(description = "缺陷类型") private String defectType;
    @Schema(description = "缺陷描述") private String defectDesc;
    @Schema(description = "工单ID") private Long workOrderId;
    @Schema(description = "工序任务ID") private Long processTaskId;
    @Schema(description = "批次号") private String batchNo;
    @Schema(description = "缺陷数量") private Integer defectQty;
    @Schema(description = "严重程度") private String severity;
    @Schema(description = "处理人") private String handler;
    @Schema(description = "处理结果") private String handleResult;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "发现时间") private Date discoverTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "处理时间") private Date handleTime;

    public Long getDefectId() { return defectId; }
    public void setDefectId(Long v) { this.defectId = v; }
    public String getDefectCode() { return defectCode; }
    public void setDefectCode(String v) { this.defectCode = v; }
    public String getDefectType() { return defectType; }
    public void setDefectType(String v) { this.defectType = v; }
    public String getDefectDesc() { return defectDesc; }
    public void setDefectDesc(String v) { this.defectDesc = v; }
    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public Long getProcessTaskId() { return processTaskId; }
    public void setProcessTaskId(Long v) { this.processTaskId = v; }
    public String getBatchNo() { return batchNo; }
    public void setBatchNo(String v) { this.batchNo = v; }
    public Integer getDefectQty() { return defectQty; }
    public void setDefectQty(Integer v) { this.defectQty = v; }
    public String getSeverity() { return severity; }
    public void setSeverity(String v) { this.severity = v; }
    public String getHandler() { return handler; }
    public void setHandler(String v) { this.handler = v; }
    public String getHandleResult() { return handleResult; }
    public void setHandleResult(String v) { this.handleResult = v; }
    public Date getDiscoverTime() { return discoverTime; }
    public void setDiscoverTime(Date v) { this.discoverTime = v; }
    public Date getHandleTime() { return handleTime; }
    public void setHandleTime(Date v) { this.handleTime = v; }
}
