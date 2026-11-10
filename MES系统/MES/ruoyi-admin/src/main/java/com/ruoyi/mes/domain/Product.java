package com.ruoyi.mes.domain;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import io.swagger.v3.oas.annotations.media.Schema;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 产品主数据 product
 *
 * @author ruoyi
 */
@Schema(description = "产品主数据")
public class Product extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 产品ID */
    @Schema(description = "产品ID")
    private Long productId;

    /** 产品编码 */
    @Excel(name = "产品编码")
    @Schema(description = "产品编码")
    private String productCode;

    /** 产品名称 */
    @Excel(name = "产品名称")
    @Schema(description = "产品名称")
    private String productName;

    /** 规格 */
    @Excel(name = "规格")
    @Schema(description = "规格")
    private String specification;

    /** 产品型号 */
    @Excel(name = "产品型号")
    @Schema(description = "产品型号")
    private String productModel;

    /** 单位 */
    @Excel(name = "单位")
    @Schema(description = "单位")
    private String unit;

    public Long getProductId()
    {
        return productId;
    }

    public void setProductId(Long productId)
    {
        this.productId = productId;
    }

    @NotBlank(message = "产品编码不能为空")
    @Size(max = 50, message = "产品编码长度不能超过50个字符")
    public String getProductCode()
    {
        return productCode;
    }

    public void setProductCode(String productCode)
    {
        this.productCode = productCode;
    }

    @NotBlank(message = "产品名称不能为空")
    @Size(max = 100, message = "产品名称长度不能超过100个字符")
    public String getProductName()
    {
        return productName;
    }

    public void setProductName(String productName)
    {
        this.productName = productName;
    }

    @Size(max = 255, message = "规格长度不能超过255个字符")
    public String getSpecification()
    {
        return specification;
    }

    public void setSpecification(String specification)
    {
        this.specification = specification;
    }

    @Size(max = 100, message = "产品型号长度不能超过100个字符")
    public String getProductModel()
    {
        return productModel;
    }

    public void setProductModel(String productModel)
    {
        this.productModel = productModel;
    }

    @Size(max = 20, message = "单位长度不能超过20个字符")
    public String getUnit()
    {
        return unit;
    }

    public void setUnit(String unit)
    {
        this.unit = unit;
    }
}
