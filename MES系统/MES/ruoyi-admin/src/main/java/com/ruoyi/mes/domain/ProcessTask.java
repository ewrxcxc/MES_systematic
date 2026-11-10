package com.ruoyi.mes.domain;

import java.util.Date;
import com.ruoyi.common.core.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import com.fasterxml.jackson.annotation.JsonFormat;

@Schema(description = "MES工序任务")
public class ProcessTask extends BaseEntity
{
    private Long taskId;
    private Long workOrderId;
    private String processName;
    private Integer processSeq;
    private String status;
    private Integer plannedQty;
    private Integer goodQty;
    private Integer badQty;
    private Long operatorId;
    private Long equipmentId;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;

    // 显示字段（非持久化）
    private String workOrderNo;
    private String equipmentName;
    private String operatorName;

    // getters/setters
    public Long getTaskId() { return taskId; }
    public void setTaskId(Long v) { this.taskId = v; }
    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public String getProcessName() { return processName; }
    public void setProcessName(String v) { this.processName = v; }
    public Integer getProcessSeq() { return processSeq; }
    public void setProcessSeq(Integer v) { this.processSeq = v; }
    public String getStatus() { return status; }
    public void setStatus(String v) { this.status = v; }
    public Integer getPlannedQty() { return plannedQty; }
    public void setPlannedQty(Integer v) { this.plannedQty = v; }
    public Integer getGoodQty() { return goodQty; }
    public void setGoodQty(Integer v) { this.goodQty = v; }
    public Integer getBadQty() { return badQty; }
    public void setBadQty(Integer v) { this.badQty = v; }
    public Long getOperatorId() { return operatorId; }
    public void setOperatorId(Long v) { this.operatorId = v; }
    public Long getEquipmentId() { return equipmentId; }
    public void setEquipmentId(Long v) { this.equipmentId = v; }
    public Date getStartTime() { return startTime; }
    public void setStartTime(Date v) { this.startTime = v; }
    public Date getEndTime() { return endTime; }
    public void setEndTime(Date v) { this.endTime = v; }
    public String getWorkOrderNo() { return workOrderNo; }
    public void setWorkOrderNo(String v) { this.workOrderNo = v; }
    public String getEquipmentName() { return equipmentName; }
    public void setEquipmentName(String v) { this.equipmentName = v; }
    public String getOperatorName() { return operatorName; }
    public void setOperatorName(String v) { this.operatorName = v; }
}
