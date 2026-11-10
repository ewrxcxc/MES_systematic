package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.SalesOrder;
import com.ruoyi.mes.dto.SalesOrderQueryDTO;
import com.ruoyi.mes.vo.SalesOrderVO;

public interface SalesOrderMapper
{
    public List<SalesOrderVO> selectSalesOrderList(SalesOrderQueryDTO query);

    public SalesOrderVO selectSalesOrderById(Long orderId);

    public SalesOrder selectSalesOrderEntityById(Long orderId);

    public SalesOrder selectSalesOrderByNo(String orderNo);

    public int insertSalesOrder(SalesOrder order);

    public int updateSalesOrder(SalesOrder order);

    public int deleteSalesOrderByIds(@Param("ids") Long[] ids);

    public SalesOrderVO selectShipDataByOrderId(Long orderId);
}
