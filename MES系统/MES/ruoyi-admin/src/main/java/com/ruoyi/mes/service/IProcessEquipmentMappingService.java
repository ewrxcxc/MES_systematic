package com.ruoyi.mes.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.mes.domain.ProcessEquipmentMapping;

public interface IProcessEquipmentMappingService
{
    List<ProcessEquipmentMapping> selectMappingList(ProcessEquipmentMapping mapping);
    List<ProcessEquipmentMapping> selectByProcessCode(String processCode);
    List<ProcessEquipmentMapping> selectByProcessSeq(Integer processSeq);
    ProcessEquipmentMapping selectMappingById(Long id);
    int insertMapping(ProcessEquipmentMapping mapping, String operator);
    int updateMapping(ProcessEquipmentMapping mapping, String operator);
    int deleteMappingByIds(String ids);
    int batchEnable(String ids, String operator);
    int batchDisable(String ids, String operator);
    Map<String, Object> testConnection(Long id);
    void refreshStatus();
}
