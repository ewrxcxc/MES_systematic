package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.ShipmentRecord;
import com.ruoyi.mes.vo.ShipmentRecordVO;

public interface ShipmentRecordMapper
{
    public List<ShipmentRecordVO> selectShipmentList(@Param("orderId") Long orderId, @Param("shipmentNo") String shipmentNo);
    public ShipmentRecordVO selectShipmentById(Long id);
    public int insertShipment(ShipmentRecord s);
    public int updateShipment(ShipmentRecord s);
    public int deleteShipmentByIds(@Param("ids") Long[] ids);
    public List<ShipmentRecord> selectShipmentEntities(@Param("orderId") Long orderId, @Param("shipmentNo") String shipmentNo);
    public ShipmentRecord selectShipmentByOrderId(Long orderId);
}
