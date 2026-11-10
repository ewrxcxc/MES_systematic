package com.ruoyi.mes.domain;

import java.math.BigDecimal;
import java.util.Date;
import io.swagger.v3.oas.annotations.media.Schema;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

@Schema(description = "设备")
public class Equipment extends BaseEntity
{
    private static final long serialVersionUID = 1L;
    private Long equipmentId;
    @Excel(name="设备编码") private String equipmentCode;
    @Excel(name="设备名称") private String equipmentName;
    @Excel(name="设备状态") private String status;
    @Excel(name="运行时间") private BigDecimal runtimeHours;
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss") private Date lastMaintenance;

    public Long getEquipmentId(){return equipmentId;}
    public void setEquipmentId(Long v){this.equipmentId=v;}
    public String getEquipmentCode(){return equipmentCode;}
    public void setEquipmentCode(String v){this.equipmentCode=v;}
    public String getEquipmentName(){return equipmentName;}
    public void setEquipmentName(String v){this.equipmentName=v;}
    public String getStatus(){return status;}
    public void setStatus(String v){this.status=v;}
    public BigDecimal getRuntimeHours(){return runtimeHours;}
    public void setRuntimeHours(BigDecimal v){this.runtimeHours=v;}
    public Date getLastMaintenance(){return lastMaintenance;}
    public void setLastMaintenance(Date v){this.lastMaintenance=v;}
}
