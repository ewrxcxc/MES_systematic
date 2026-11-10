package com.ruoyi.mes.dto;

import java.math.BigDecimal;
import io.swagger.v3.oas.annotations.media.Schema;

/**
 * BOM保存请求
 *
 * @author ruoyi
 */
@Schema(description = "BOM保存请求")
public class BomDTO
{
    @Schema(description = "BOM ID")
    private Long bomId;

    @Schema(description = "产品ID")
    private Long productId;

    @Schema(description = "物料名称")
    private String materialName;

    @Schema(description = "物料编码")
    private String materialCode;

    @Schema(description = "用量")
    private BigDecimal usageQty;

    @Schema(description = "备注")
    private String remark;

    public Long getBomId()
    {
        return bomId;
    }

    public void setBomId(Long bomId)
    {
        this.bomId = bomId;
    }

    public Long getProductId()
    {
        return productId;
    }

    public void setProductId(Long productId)
    {
        this.productId = productId;
    }

    public String getMaterialName()
    {
        return materialName;
    }

    public void setMaterialName(String materialName)
    {
        this.materialName = materialName;
    }

    public String getMaterialCode()
    {
        return materialCode;
    }

    public void setMaterialCode(String materialCode)
    {
        this.materialCode = materialCode;
    }

    public BigDecimal getUsageQty()
    {
        return usageQty;
    }

    public void setUsageQty(BigDecimal usageQty)
    {
        this.usageQty = usageQty;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }
}
