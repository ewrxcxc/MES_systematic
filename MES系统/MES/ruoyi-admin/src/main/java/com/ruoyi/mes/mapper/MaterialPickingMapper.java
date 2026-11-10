package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.MaterialPicking;
import com.ruoyi.mes.domain.MaterialPickingDetail;

public interface MaterialPickingMapper
{
    List<MaterialPicking> selectMaterialPickingList(MaterialPicking picking);
    MaterialPicking selectMaterialPickingById(Long pickingId);
    MaterialPicking selectMaterialPickingByWorkOrderId(Long workOrderId);
    int insertMaterialPicking(MaterialPicking picking);
    int updateMaterialPicking(MaterialPicking picking);
    int deleteMaterialPickingByIds(@Param("ids") Long[] ids);

    List<MaterialPickingDetail> selectPickingDetailsByPickingId(Long pickingId);
    int insertPickingDetail(MaterialPickingDetail detail);
    int updatePickingDetail(MaterialPickingDetail detail);
    int deletePickingDetailsByPickingId(Long pickingId);
}
