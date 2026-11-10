package com.ruoyi.mes.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "质检记录")
public class QualityRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    @Schema(description = "主键")
    private Long id;

    @Schema(description = "工单ID")
    private Long workOrderId;

    @Schema(description = "产品ID")
    private Long productId;

    @Schema(description = "产品名称")
    private String productName;

    @Schema(description = "工单编号")
    private String workOrderNo;

    @Schema(description = "检验类型")
    private String checkType;

    @Schema(description = "检验数量")
    private Integer quantity;

    @Schema(description = "不良数量")
    private Integer defectQuantity;

    @Schema(description = "检验结果")
    private String result;

    @Schema(description = "检验员")
    private String inspector;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Schema(description = "检验时间")
    private Date checkTime;

    public Long getId() { return id; }
    public void setId(Long v) { this.id = v; }
    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long v) { this.workOrderId = v; }
    public Long getProductId() { return productId; }
    public void setProductId(Long v) { this.productId = v; }
    public String getProductName() { return productName; }
    public void setProductName(String v) { this.productName = v; }
    public String getWorkOrderNo() { return workOrderNo; }
    public void setWorkOrderNo(String v) { this.workOrderNo = v; }
    public String getCheckType() { return checkType; }
    public void setCheckType(String v) { this.checkType = v; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer v) { this.quantity = v; }
    public Integer getDefectQuantity() { return defectQuantity; }
    public void setDefectQuantity(Integer v) { this.defectQuantity = v; }
    public String getResult() { return result; }
    public void setResult(String v) { this.result = v; }
    public String getInspector() { return inspector; }
    public void setInspector(String v) { this.inspector = v; }
    public Date getCheckTime() { return checkTime; }
    public void setCheckTime(Date v) { this.checkTime = v; }
}
