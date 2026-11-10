package com.ruoyi.mes.service;

import java.util.List;
import com.ruoyi.mes.domain.WorkOrderSplit;

public interface IWorkOrderSplitService
{
    List<WorkOrderSplit> selectSplitList(WorkOrderSplit split);
    List<WorkOrderSplit> selectSplitsByParentWorkOrderId(Long parentWorkOrderId);
    WorkOrderSplit selectSplitById(Long splitId);
    int createSplit(Long parentWorkOrderId, List<WorkOrderSplit> splits, String operator);
    int deleteSplitByIds(String ids);
}
