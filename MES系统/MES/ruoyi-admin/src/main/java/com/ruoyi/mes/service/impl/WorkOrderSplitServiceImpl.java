package com.ruoyi.mes.service.impl;

import java.text.SimpleDateFormat;
import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.mes.domain.*;
import com.ruoyi.mes.mapper.*;
import com.ruoyi.mes.service.IWorkOrderSplitService;

@Service
public class WorkOrderSplitServiceImpl implements IWorkOrderSplitService
{
    @Autowired private WorkOrderSplitMapper splitMapper;
    @Autowired private WorkOrderMapper workOrderMapper;

    @Override
    public List<WorkOrderSplit> selectSplitList(WorkOrderSplit split) {
        return splitMapper.selectSplitList(split);
    }

    @Override
    public List<WorkOrderSplit> selectSplitsByParentWorkOrderId(Long parentWorkOrderId) {
        return splitMapper.selectSplitsByParentWorkOrderId(parentWorkOrderId);
    }

    @Override
    public WorkOrderSplit selectSplitById(Long splitId) {
        return splitMapper.selectSplitById(splitId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int createSplit(Long parentWorkOrderId, List<WorkOrderSplit> splits, String operator) {
        WorkOrder parentWo = workOrderMapper.selectWorkOrderEntityById(parentWorkOrderId);
        if (parentWo == null) throw new ServiceException("父工单不存在");
        if (!"WAITING".equals(parentWo.getStatus()) && !"READY".equals(parentWo.getStatus()))
            throw new ServiceException("当前工单状态不允许拆卡");

        // 校验拆分数量总和
        int totalSplitQty = 0;
        for (WorkOrderSplit split : splits) {
            totalSplitQty += split.getSplitQty() != null ? split.getSplitQty() : 0;
        }
        if (totalSplitQty != parentWo.getPlannedQty())
            throw new ServiceException("拆分数量总和(" + totalSplitQty + ")不等于工单计划数量(" + parentWo.getPlannedQty() + ")");

        String ts = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        for (int i = 0; i < splits.size(); i++) {
            WorkOrderSplit split = splits.get(i);
            split.setParentWorkOrderId(parentWorkOrderId);
            split.setSplitNo(parentWo.getWorkOrderNo() + "-" + (i + 1));
            split.setStatus("WAITING");
            split.setCompletedQty(0);
            split.setCreateBy(operator);
            splitMapper.insertWorkOrderSplit(split);
        }

        return splits.size();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteSplitByIds(String ids) {
        Long[] idArray = Convert.toLongArray(ids);
        if (idArray.length == 0) throw new ServiceException("请选择要删除的拆卡记录");
        return splitMapper.deleteSplitByIds(idArray);
    }
}
