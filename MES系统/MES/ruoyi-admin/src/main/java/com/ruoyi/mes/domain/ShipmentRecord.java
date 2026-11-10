package com.ruoyi.mes.domain;

import java.util.Date;
import io.swagger.v3.oas.annotations.media.Schema;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

@Schema(description = "发货记录")
public class ShipmentRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;
    private Long shipmentId;
    private Long orderId;
    private Long planId;
    @Excel(name="发货编号") private String shipmentNo;
    @Excel(name="快递公司") private String expressCompany;
    @Excel(name="快递单号") private String trackingNo;
    @Excel(name="发货数量") private Integer shipmentQty;
    private Long operatorId;
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss") private Date shipmentTime;
    @Excel(name="客户名称") private String customerName;
    @Excel(name="产品名称") private String productName;
    @Excel(name="发货状态") private String status;

    public Long getShipmentId(){return shipmentId;}
    public void setShipmentId(Long v){this.shipmentId=v;}
    public Long getOrderId(){return orderId;}
    public void setOrderId(Long v){this.orderId=v;}
    public Long getPlanId(){return planId;}
    public void setPlanId(Long v){this.planId=v;}
    public String getShipmentNo(){return shipmentNo;}
    public void setShipmentNo(String v){this.shipmentNo=v;}
    public String getExpressCompany(){return expressCompany;}
    public void setExpressCompany(String v){this.expressCompany=v;}
    public String getTrackingNo(){return trackingNo;}
    public void setTrackingNo(String v){this.trackingNo=v;}
    public Integer getShipmentQty(){return shipmentQty;}
    public void setShipmentQty(Integer v){this.shipmentQty=v;}
    public Long getOperatorId(){return operatorId;}
    public void setOperatorId(Long v){this.operatorId=v;}
    public Date getShipmentTime(){return shipmentTime;}
    public void setShipmentTime(Date v){this.shipmentTime=v;}
    public String getCustomerName(){return customerName;}
    public void setCustomerName(String v){this.customerName=v;}
    public String getProductName(){return productName;}
    public void setProductName(String v){this.productName=v;}
    public String getStatus(){return status;}
    public void setStatus(String v){this.status=v;}
}
