package com.ruoyi.mes.domain;

import java.util.Date;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import io.swagger.v3.oas.annotations.media.Schema;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 销售订单 sales_order
 *
 * @author ruoyi
 */
@Schema(description = "销售订单")
public class SalesOrder extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 订单ID */
    @Schema(description = "订单ID")
    private Long orderId;

    /** 订单编号 */
    @Excel(name = "订单编号")
    @Schema(description = "订单编号")
    private String orderNo;

    /** 客户ID */
    @Schema(description = "客户ID")
    private Long customerId;

    /** 客户名称 */
    @Schema(description = "客户名称")
    private String customerName;

    /** 产品ID */
    @Schema(description = "产品ID")
    private Long productId;

    /** 产品名称 */
    @Schema(description = "产品名称")
    private String productName;

    /** 数量 */
    @Excel(name = "数量")
    @Schema(description = "数量")
    private Integer quantity;

    /** 交期 */
    @Excel(name = "交期", dateFormat = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @Schema(description = "交期")
    private Date dueDate;

    /** 收货人 */
    @Excel(name = "收货人")
    @Schema(description = "收货人")
    private String consignee;

    /** 联系电话 */
    @Excel(name = "联系电话")
    @Schema(description = "联系电话")
    private String consigneePhone;

    /** 收货地址 */
    @Excel(name = "收货地址")
    @Schema(description = "收货地址")
    private String deliveryAddress;

    /** 订单状态 */
    @Excel(name = "订单状态", readConverterExp = "待处理=待处理,生产中=生产中,已完成=已完成")
    @Schema(description = "订单状态")
    private String orderStatus;

    /** 发货状态 */
    @Excel(name = "发货状态", readConverterExp = "未发货=未发货,已发货=已发货")
    @Schema(description = "发货状态")
    private String deliveryStatus;

    /** 是否紧急订单（0=普通 1=紧急） */
    @Excel(name = "是否紧急", readConverterExp = "0=普通,1=紧急")
    @Schema(description = "是否紧急订单")
    private Integer isUrgent;

    public Long getOrderId() { return orderId; }
    public void setOrderId(Long orderId) { this.orderId = orderId; }

    @NotBlank(message = "订单编号不能为空")
    @Size(max = 50, message = "订单编号长度不能超过50个字符")
    public String getOrderNo() { return orderNo; }
    public void setOrderNo(String orderNo) { this.orderNo = orderNo; }

    public Long getCustomerId() { return customerId; }
    public void setCustomerId(Long customerId) { this.customerId = customerId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public Long getProductId() { return productId; }
    public void setProductId(Long productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }

    @Size(max = 50, message = "收货人长度不能超过50个字符")
    public String getConsignee() { return consignee; }
    public void setConsignee(String consignee) { this.consignee = consignee; }

    @Size(max = 20, message = "联系电话长度不能超过20个字符")
    public String getConsigneePhone() { return consigneePhone; }
    public void setConsigneePhone(String consigneePhone) { this.consigneePhone = consigneePhone; }

    @Size(max = 255, message = "收货地址长度不能超过255个字符")
    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }

    public String getOrderStatus() { return orderStatus; }
    public void setOrderStatus(String orderStatus) { this.orderStatus = orderStatus; }

    public String getDeliveryStatus() { return deliveryStatus; }
    public void setDeliveryStatus(String deliveryStatus) { this.deliveryStatus = deliveryStatus; }
    public Integer getIsUrgent() { return isUrgent; }
    public void setIsUrgent(Integer isUrgent) { this.isUrgent = isUrgent; }
}
