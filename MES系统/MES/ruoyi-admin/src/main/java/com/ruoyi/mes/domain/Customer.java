package com.ruoyi.mes.domain;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import io.swagger.v3.oas.annotations.media.Schema;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 客户主数据 customer
 *
 * @author ruoyi
 */
@Schema(description = "客户主数据")
public class Customer extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 客户ID */
    @Schema(description = "客户ID")
    private Long customerId;

    /** 客户编码 */
    @Excel(name = "客户编码")
    @Schema(description = "客户编码")
    private String customerCode;

    /** 客户名称 */
    @Excel(name = "客户名称")
    @Schema(description = "客户名称")
    private String customerName;

    /** 联系人 */
    @Excel(name = "联系人")
    @Schema(description = "联系人")
    private String contactName;

    /** 联系电话 */
    @Excel(name = "联系电话")
    @Schema(description = "联系电话")
    private String contactPhone;

    /** 邮箱 */
    @Excel(name = "邮箱")
    @Schema(description = "邮箱")
    private String email;

    /** 地址 */
    @Excel(name = "地址")
    @Schema(description = "地址")
    private String address;

    /** 状态（0正常 1停用） */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    @Schema(description = "状态（0正常 1停用）")
    private String status;

    /** 客户优先级（1=A, 2=B, 3=C） */
    @Excel(name = "优先级", readConverterExp = "1=A,2=B,3=C")
    @Schema(description = "客户优先级（1=A, 2=B, 3=C）")
    private Integer customerPriority;

    public Long getCustomerId()
    {
        return customerId;
    }

    public void setCustomerId(Long customerId)
    {
        this.customerId = customerId;
    }

    @NotBlank(message = "客户编码不能为空")
    @Size(max = 64, message = "客户编码长度不能超过64个字符")
    public String getCustomerCode()
    {
        return customerCode;
    }

    public void setCustomerCode(String customerCode)
    {
        this.customerCode = customerCode;
    }

    @NotBlank(message = "客户名称不能为空")
    @Size(max = 128, message = "客户名称长度不能超过128个字符")
    public String getCustomerName()
    {
        return customerName;
    }

    public void setCustomerName(String customerName)
    {
        this.customerName = customerName;
    }

    @Size(max = 64, message = "联系人长度不能超过64个字符")
    public String getContactName()
    {
        return contactName;
    }

    public void setContactName(String contactName)
    {
        this.contactName = contactName;
    }

    @Size(max = 32, message = "联系电话长度不能超过32个字符")
    public String getContactPhone()
    {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone)
    {
        this.contactPhone = contactPhone;
    }

    @Size(max = 128, message = "邮箱长度不能超过128个字符")
    public String getEmail()
    {
        return email;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    @Size(max = 255, message = "地址长度不能超过255个字符")
    public String getAddress()
    {
        return address;
    }

    public void setAddress(String address)
    {
        this.address = address;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Integer getCustomerPriority() { return customerPriority; }
    public void setCustomerPriority(Integer v) { this.customerPriority = v; }
}
