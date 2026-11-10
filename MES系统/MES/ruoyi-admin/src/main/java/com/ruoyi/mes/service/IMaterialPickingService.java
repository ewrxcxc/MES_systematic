package com.ruoyi.mes.service;

import java.util.List;
import com.ruoyi.mes.domain.MaterialPicking;
import com.ruoyi.mes.domain.MaterialPickingDetail;

public interface IMaterialPickingService
{
    List<MaterialPicking> selectMaterialPickingList(MaterialPicking picking);
    MaterialPicking selectMaterialPickingById(Long pickingId);
    MaterialPicking createPickingByWorkOrder(Long workOrderId, String operator);
    int confirmPicking(Long pickingId, String pickingBy, List<MaterialPickingDetail> details, String operator);
    int deleteMaterialPickingByIds(String ids);
    List<MaterialPickingDetail> selectPickingDetails(Long pickingId);
}
