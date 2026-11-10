package com.ruoyi.mes.domain;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import io.swagger.v3.oas.annotations.media.Schema;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * BOM物料清单 bom
 *
 * @author ruoyi
 */
@Schema(description = "BOM物料清单")
public class Bom extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** BOM ID */
    @Schema(description = "BOM ID")
    private Long bomId;

    /** 产品ID */
    @Excel(name = "产品ID")
    @Schema(description = "产品ID")
    private Long productId;

    /** 物料名称 */
    @Excel(name = "物料名称")
    @Schema(description = "物料名称")
    private String materialName;

    /** 物料编码 */
    @Excel(name = "物料编码")
    @Schema(description = "物料编码")
    private String materialCode;

    /** 用量 */
    @Excel(name = "用量")
    @Schema(description = "用量")
    private java.math.BigDecimal usageQty;

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

    @NotBlank(message = "物料名称不能为空")
    @Size(max = 100, message = "物料名称长度不能超过100个字符")
    public String getMaterialName()
    {
        return materialName;
    }

    public void setMaterialName(String materialName)
    {
        this.materialName = materialName;
    }

    @Size(max = 50, message = "物料编码长度不能超过50个字符")
    public String getMaterialCode()
    {
        return materialCode;
    }

    public void setMaterialCode(String materialCode)
    {
        this.materialCode = materialCode;
    }

    public java.math.BigDecimal getUsageQty()
    {
        return usageQty;
    }

    public void setUsageQty(java.math.BigDecimal usageQty)
    {
        this.usageQty = usageQty;
    }
}
