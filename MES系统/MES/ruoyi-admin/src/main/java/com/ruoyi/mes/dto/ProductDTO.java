package com.ruoyi.mes.dto;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * 产品保存请求
 *
 * @author ruoyi
 */
@Schema(description = "产品保存请求")
public class ProductDTO
{
    @Schema(description = "产品ID")
    private Long productId;

    @Schema(description = "产品编码")
    private String productCode;

    @Schema(description = "产品名称")
    private String productName;

    @Schema(description = "规格")
    private String specification;

    @Schema(description = "产品型号")
    private String productModel;

    @Schema(description = "单位")
    private String unit;

    @Schema(description = "备注")
    private String remark;

    public Long getProductId()
    {
        return productId;
    }

    public void setProductId(Long productId)
    {
        this.productId = productId;
    }

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

    public String getProductModel()
    {
        return productModel;
    }

    public void setProductModel(String productModel)
    {
        this.productModel = productModel;
    }

    public String getUnit()
    {
        return unit;
    }

    public void setUnit(String unit)
    {
        this.unit = unit;
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
