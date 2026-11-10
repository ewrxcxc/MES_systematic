package com.ruoyi.mes.vo;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "发货记录展示对象")
public class ShipmentRecordVO
{
    private Long shipmentId;
    private Long orderId;
    private String orderNo;
    private String shipmentNo;
    private String expressCompany;
    private String trackingNo;
    private Integer shipmentQty;
    private Long operatorId;
    private String operatorName;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date shipmentTime;
    private String remark;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;
    private String customerName;
    private String productName;
    private String status;

    public Long getShipmentId(){return shipmentId;} public void setShipmentId(Long v){this.shipmentId=v;}
    public Long getOrderId(){return orderId;} public void setOrderId(Long v){this.orderId=v;}
    public String getOrderNo(){return orderNo;} public void setOrderNo(String v){this.orderNo=v;}
    public String getShipmentNo(){return shipmentNo;} public void setShipmentNo(String v){this.shipmentNo=v;}
    public String getExpressCompany(){return expressCompany;} public void setExpressCompany(String v){this.expressCompany=v;}
    public String getTrackingNo(){return trackingNo;} public void setTrackingNo(String v){this.trackingNo=v;}
    public Integer getShipmentQty(){return shipmentQty;} public void setShipmentQty(Integer v){this.shipmentQty=v;}
    public Long getOperatorId(){return operatorId;} public void setOperatorId(Long v){this.operatorId=v;}
    public String getOperatorName(){return operatorName;} public void setOperatorName(String v){this.operatorName=v;}
    public Date getShipmentTime(){return shipmentTime;} public void setShipmentTime(Date v){this.shipmentTime=v;}
    public String getRemark(){return remark;} public void setRemark(String v){this.remark=v;}
    public Date getCreateTime(){return createTime;} public void setCreateTime(Date v){this.createTime=v;}
    public Date getUpdateTime(){return updateTime;} public void setUpdateTime(Date v){this.updateTime=v;}
    public String getCustomerName(){return customerName;} public void setCustomerName(String v){this.customerName=v;}
    public String getProductName(){return productName;} public void setProductName(String v){this.productName=v;}
    public String getStatus(){return status;} public void setStatus(String v){this.status=v;}
}
