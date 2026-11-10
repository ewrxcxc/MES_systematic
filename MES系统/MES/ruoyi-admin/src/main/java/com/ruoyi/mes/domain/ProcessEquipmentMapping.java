package com.ruoyi.mes.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "工序设备映射")
public class ProcessEquipmentMapping extends BaseEntity
{
    private static final long serialVersionUID = 1L;
    private Long id;
    @Schema(description = "工序编码") private String processCode;
    @Schema(description = "工序名称") private String processName;
    @Schema(description = "工序序号") private Integer processSeq;
    @Schema(description = "设备ID") private Long equipmentId;
    @Schema(description = "设备编码") private String equipmentCode;
    @Schema(description = "设备名称") private String equipmentName;
    @Schema(description = "产线ID") private Long lineId;
    @Schema(description = "API地址") private String apiUrl;
    @Schema(description = "API类型") private String apiType;
    @Schema(description = "状态") private String status;
    @Schema(description = "工作中心") private String workCenter;
    @Schema(description = "产线动作") private String lineAction;
    @Schema(description = "API命令") private String apiCommand;
    @Schema(description = "响应时间") private Long responseTime;
    @Schema(description = "最后调用时间") private java.util.Date lastCallTime;

    public Long getId() { return id; }
    public void setId(Long v) { this.id = v; }
    public String getProcessCode() { return processCode; }
    public void setProcessCode(String v) { this.processCode = v; }
    public String getProcessName() { return processName; }
    public void setProcessName(String v) { this.processName = v; }
    public Integer getProcessSeq() { return processSeq; }
    public void setProcessSeq(Integer v) { this.processSeq = v; }
    public Long getEquipmentId() { return equipmentId; }
    public void setEquipmentId(Long v) { this.equipmentId = v; }
    public String getEquipmentCode() { return equipmentCode; }
    public void setEquipmentCode(String v) { this.equipmentCode = v; }
    public String getEquipmentName() { return equipmentName; }
    public void setEquipmentName(String v) { this.equipmentName = v; }
    public Long getLineId() { return lineId; }
    public void setLineId(Long v) { this.lineId = v; }
    public String getApiUrl() { return apiUrl; }
    public void setApiUrl(String v) { this.apiUrl = v; }
    public String getApiType() { return apiType; }
    public void setApiType(String v) { this.apiType = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { this.status = v; }
    public String getWorkCenter() { return workCenter; }
    public void setWorkCenter(String v) { this.workCenter = v; }
    public String getLineAction() { return lineAction; }
    public void setLineAction(String v) { this.lineAction = v; }
    public String getApiCommand() { return apiCommand; }
    public void setApiCommand(String v) { this.apiCommand = v; }
    public Long getResponseTime() { return responseTime; }
    public void setResponseTime(Long v) { this.responseTime = v; }
    public java.util.Date getLastCallTime() { return lastCallTime; }
    public void setLastCallTime(java.util.Date v) { this.lastCallTime = v; }
}
