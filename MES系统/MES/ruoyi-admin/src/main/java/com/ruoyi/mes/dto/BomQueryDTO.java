package com.ruoyi.mes.dto;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * BOM查询条件
 *
 * @author ruoyi
 */
@Schema(description = "BOM查询条件")
public class BomQueryDTO
{
    @Schema(description = "产品ID")
    private Long productId;

    @Schema(description = "物料名称")
    private String materialName;

    @Schema(description = "物料编码")
    private String materialCode;

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
}
