package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.Equipment;

public interface EquipmentMapper
{
    public List<Equipment> selectEquipmentList(@Param("equipmentCode") String equipmentCode, @Param("equipmentName") String equipmentName, @Param("status") String status);
    public Equipment selectEquipmentById(Long id);
    public int insertEquipment(Equipment e);
    public int updateEquipment(Equipment e);
    public int deleteEquipmentByIds(@Param("ids") Long[] ids);
}
