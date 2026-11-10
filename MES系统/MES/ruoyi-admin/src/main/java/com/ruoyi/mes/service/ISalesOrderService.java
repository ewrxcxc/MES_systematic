package com.ruoyi.mes.service;

import java.util.Date;
import java.util.List;
import com.ruoyi.mes.domain.SalesOrder;
import com.ruoyi.mes.dto.SalesOrderDTO;
import com.ruoyi.mes.dto.SalesOrderQueryDTO;
import com.ruoyi.mes.vo.SalesOrderVO;

public interface ISalesOrderService
{
    public List<SalesOrderVO> selectSalesOrderList(SalesOrderQueryDTO query);

    public SalesOrderVO selectSalesOrderById(Long orderId);

    public int insertSalesOrder(SalesOrderDTO orderDto, String operator);

    public int updateSalesOrder(SalesOrderDTO orderDto, String operator);

    public int deleteSalesOrderByIds(String ids);

    public List<SalesOrder> selectSalesOrderExportList(SalesOrderQueryDTO query);

    public boolean checkOrderNoUnique(SalesOrderDTO orderDto);

    public SalesOrderVO getShipDataByOrderId(Long orderId);

    public int shipOrder(Long orderId, String expressCompany, Integer shipmentQty, String operator, String remark, Date shipmentTime);
}
