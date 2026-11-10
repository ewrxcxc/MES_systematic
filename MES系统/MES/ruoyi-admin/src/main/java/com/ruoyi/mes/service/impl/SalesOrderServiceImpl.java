package com.ruoyi.mes.service.impl;

import java.text.SimpleDateFormat;
import java.util.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.mes.domain.Customer;
import com.ruoyi.mes.domain.Product;
import com.ruoyi.mes.domain.ProductionPlan;
import com.ruoyi.mes.domain.SalesOrder;
import com.ruoyi.mes.dto.SalesOrderDTO;
import com.ruoyi.mes.dto.SalesOrderQueryDTO;
import com.ruoyi.mes.mapper.CustomerMapper;
import com.ruoyi.mes.mapper.ProductMapper;
import com.ruoyi.mes.mapper.SalesOrderMapper;
import com.ruoyi.mes.mapper.ShipmentRecordMapper;
import com.ruoyi.mes.service.ISalesOrderService;
import com.ruoyi.mes.service.IProductionPlanService;
import com.ruoyi.mes.vo.SalesOrderVO;
import com.ruoyi.mes.domain.ShipmentRecord;

@Service
public class SalesOrderServiceImpl implements ISalesOrderService
{
    @Autowired private SalesOrderMapper salesOrderMapper;
    @Autowired private CustomerMapper customerMapper;
    @Autowired private ProductMapper productMapper;
    @Autowired private IProductionPlanService productionPlanService;
    @Autowired private ShipmentRecordMapper shipmentRecordMapper;

    @Override
    public List<SalesOrderVO> selectSalesOrderList(SalesOrderQueryDTO query) {
        return salesOrderMapper.selectSalesOrderList(query);
    }

    @Override
    public SalesOrderVO selectSalesOrderById(Long orderId) {
        return salesOrderMapper.selectSalesOrderById(orderId);
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int insertSalesOrder(SalesOrderDTO orderDto, String operator) {
        SalesOrder order = toEntity(orderDto);

        if (StringUtils.isNotBlank(order.getCustomerName()) && order.getCustomerId() == null) {
            Customer customer = customerMapper.selectCustomerByName(order.getCustomerName());
            if (customer != null) order.setCustomerId(customer.getCustomerId());
        }
        if (StringUtils.isNotBlank(order.getProductName()) && order.getProductId() == null) {
            Product product = productMapper.selectProductByName(order.getProductName());
            if (product != null) order.setProductId(product.getProductId());
        }
        if (StringUtils.isBlank(order.getOrderNo()))
            order.setOrderNo("SO" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
        SalesOrderDTO checkDto = new SalesOrderDTO();
        checkDto.setOrderNo(order.getOrderNo());
        if (!checkOrderNoUnique(checkDto))
            throw new ServiceException("新增订单失败，订单编号已存在");
        if (StringUtils.isBlank(order.getOrderStatus()))
            order.setOrderStatus("CONFIRMED");
        if (StringUtils.isBlank(order.getDeliveryStatus()))
            order.setDeliveryStatus("未发货");
        if (order.getIsUrgent() == null)
            order.setIsUrgent(0);
        order.setCreateBy(operator);

        // 步骤1：保存销售订单
        int result = salesOrderMapper.insertSalesOrder(order);

        // 步骤2：自动生成生产计划（状态：已审核）
        ProductionPlan plan = productionPlanService.createFromSalesOrder(order);

        return result;
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int updateSalesOrder(SalesOrderDTO orderDto, String operator) {
        if (orderDto.getOrderId() == null) throw new ServiceException("订单ID不能为空");
        SalesOrder order = toEntity(orderDto);

        if (StringUtils.isNotBlank(order.getCustomerName()) && order.getCustomerId() == null) {
            Customer customer = customerMapper.selectCustomerByName(order.getCustomerName());
            if (customer != null) order.setCustomerId(customer.getCustomerId());
        }
        if (StringUtils.isNotBlank(order.getProductName()) && order.getProductId() == null) {
            Product product = productMapper.selectProductByName(order.getProductName());
            if (product != null) order.setProductId(product.getProductId());
        }
        order.setUpdateBy(operator);
        return salesOrderMapper.updateSalesOrder(order);
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int deleteSalesOrderByIds(String ids) {
        Long[] orderIds = Convert.toLongArray(ids);
        if (orderIds.length == 0) throw new ServiceException("请选择要删除的订单");
        return salesOrderMapper.deleteSalesOrderByIds(orderIds);
    }

    @Override
    public List<SalesOrder> selectSalesOrderExportList(SalesOrderQueryDTO query) {
        List<SalesOrderVO> voList = salesOrderMapper.selectSalesOrderList(query);
        List<SalesOrder> list = new ArrayList<>();
        for (SalesOrderVO vo : voList) {
            SalesOrder order = new SalesOrder();
            BeanUtils.copyProperties(vo, order);
            list.add(order);
        }
        return list;
    }

    @Override
    public boolean checkOrderNoUnique(SalesOrderDTO orderDto) {
        Long orderId = StringUtils.isNull(orderDto.getOrderId()) ? -1L : orderDto.getOrderId();
        SalesOrder info = salesOrderMapper.selectSalesOrderByNo(orderDto.getOrderNo());
        if (StringUtils.isNotNull(info) && info.getOrderId().longValue() != orderId.longValue())
            return UserConstants.NOT_UNIQUE;
        return UserConstants.UNIQUE;
    }

    @Override
    public SalesOrderVO getShipDataByOrderId(Long orderId) {
        return salesOrderMapper.selectShipDataByOrderId(orderId);
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int shipOrder(Long orderId, String expressCompany, Integer shipmentQty, String operator, String remark, Date shipmentTime) {
        SalesOrder order = salesOrderMapper.selectSalesOrderEntityById(orderId);
        if (order == null) throw new ServiceException("销售订单不存在");
        if (!"CONFIRMED".equals(order.getOrderStatus()))
            throw new ServiceException("订单状态不是已确认，无法发货");
        if ("已发货".equals(order.getDeliveryStatus()))
            throw new ServiceException("该订单已发货，请勿重复操作");

        int qty = shipmentQty != null ? shipmentQty : order.getQuantity();

        String genNo = "FH" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

        ShipmentRecord shipment = new ShipmentRecord();
        shipment.setOrderId(orderId);
        shipment.setShipmentNo(genNo);
        shipment.setTrackingNo(genNo);
        shipment.setExpressCompany(expressCompany);
        shipment.setShipmentQty(qty);
        shipment.setCustomerName(order.getCustomerName());
        shipment.setProductName(order.getProductName());
        shipment.setStatus("已发货");
        shipment.setShipmentTime(shipmentTime != null ? shipmentTime : new Date());
        shipment.setRemark(remark);
        shipment.setCreateBy(operator);
        shipmentRecordMapper.insertShipment(shipment);

        order.setDeliveryStatus("已发货");
        order.setUpdateBy(operator);
        salesOrderMapper.updateSalesOrder(order);

        return 1;
    }

    private SalesOrder toEntity(SalesOrderDTO dto) {
        SalesOrder order = new SalesOrder();
        BeanUtils.copyProperties(dto, order);
        return order;
    }
}
