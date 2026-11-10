package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.ProcessEquipmentMapping;

public interface ProcessEquipmentMappingMapper
{
    List<ProcessEquipmentMapping> selectMappingList(ProcessEquipmentMapping mapping);
    List<ProcessEquipmentMapping> selectByProcessCode(String processCode);
    List<ProcessEquipmentMapping> selectByProcessSeq(Integer processSeq);
    ProcessEquipmentMapping selectMappingById(Long id);
    int insertMapping(ProcessEquipmentMapping mapping);
    int updateMapping(ProcessEquipmentMapping mapping);
    int deleteMappingByIds(Long[] ids);
    int batchUpdateStatus(@Param("ids") Long[] ids, @Param("status") String status, @Param("updateBy") String updateBy);
    int updateResponseTime(@Param("id") Long id, @Param("responseTime") Long responseTime);
    int refreshAllStatus();
}
