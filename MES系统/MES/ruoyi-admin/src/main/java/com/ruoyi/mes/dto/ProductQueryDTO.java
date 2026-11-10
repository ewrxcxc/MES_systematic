package com.ruoyi.mes.dto;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * 产品查询条件
 *
 * @author ruoyi
 */
@Schema(description = "产品查询条件")
public class ProductQueryDTO
{
    @Schema(description = "产品编码")
    private String productCode;

    @Schema(description = "产品名称")
    private String productName;

    @Schema(description = "规格")
    private String specification;

    public String getProductCode()
    {
        return productCode;
    }

    public void setProductCode(String productCode)
    {
        this.productCode = productCode;
    }

    public String getProductName()
    {
        return productName;
    }

    public void setProductName(String productName)
    {
        this.productName = productName;
    }

    public String getSpecification()
    {
        return specification;
    }

    public void setSpecification(String specification)
    {
        this.specification = specification;
    }
}
