package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.WorkOrderSplit;

public interface WorkOrderSplitMapper
{
    List<WorkOrderSplit> selectSplitList(WorkOrderSplit split);
    List<WorkOrderSplit> selectSplitsByParentWorkOrderId(Long parentWorkOrderId);
    WorkOrderSplit selectSplitById(Long splitId);
    int insertWorkOrderSplit(WorkOrderSplit split);
    int updateWorkOrderSplit(WorkOrderSplit split);
    int deleteSplitByIds(@Param("ids") Long[] ids);
    int deleteSplitsByParentWorkOrderId(Long parentWorkOrderId);
}
