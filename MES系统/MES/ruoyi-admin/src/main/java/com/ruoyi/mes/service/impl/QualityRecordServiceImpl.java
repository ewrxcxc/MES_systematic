package com.ruoyi.mes.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.mes.domain.QualityRecord;
import com.ruoyi.mes.domain.WorkOrder;
import com.ruoyi.mes.domain.SalesOrder;
import com.ruoyi.mes.mapper.QualityRecordMapper;
import com.ruoyi.mes.mapper.WorkOrderMapper;
import com.ruoyi.mes.mapper.SalesOrderMapper;
import com.ruoyi.mes.service.IQualityRecordService;

@Service
public class QualityRecordServiceImpl implements IQualityRecordService
{
    @Autowired
    private QualityRecordMapper qualityRecordMapper;
    @Autowired
    private WorkOrderMapper workOrderMapper;
    @Autowired
    private SalesOrderMapper salesOrderMapper;

    @Override
    public List<QualityRecord> selectQualityRecordList(QualityRecord record)
    {
        return qualityRecordMapper.selectQualityRecordList(record);
    }

    @Override
    public QualityRecord selectQualityRecordById(Long id)
    {
        return qualityRecordMapper.selectQualityRecordById(id);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertQualityRecord(QualityRecord record, String operator)
    {
        if (record.getWorkOrderId() == null)
            throw new ServiceException("工单不能为空");

        // 从工单自动填充产品ID和工单编号
        WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(record.getWorkOrderId());
        if (wo == null)
            throw new ServiceException("工单不存在");
        record.setWorkOrderNo(wo.getWorkOrderNo());

        if (record.getProductId() == null && wo.getOrderId() != null)
        {
            SalesOrder so = salesOrderMapper.selectSalesOrderEntityById(wo.getOrderId());
            if (so != null && so.getProductId() != null)
            {
                record.setProductId(so.getProductId());
            }
        }

        record.setCreateBy(operator);
        return qualityRecordMapper.insertQualityRecord(record);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateQualityRecord(QualityRecord record, String operator)
    {
        if (record.getId() == null)
            throw new ServiceException("质检记录ID不能为空");

        if (record.getWorkOrderId() != null)
        {
            WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(record.getWorkOrderId());
            if (wo != null)
            {
                record.setWorkOrderNo(wo.getWorkOrderNo());
                if (record.getProductId() == null && wo.getOrderId() != null)
                {
                    SalesOrder so = salesOrderMapper.selectSalesOrderEntityById(wo.getOrderId());
                    if (so != null && so.getProductId() != null)
                    {
                        record.setProductId(so.getProductId());
                    }
                }
            }
        }

        record.setUpdateBy(operator);
        return qualityRecordMapper.updateQualityRecord(record);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteQualityRecordByIds(String ids)
    {
        Long[] arr = Convert.toLongArray(ids);
        if (arr.length == 0)
            throw new ServiceException("请选择要删除的质检记录");
        return qualityRecordMapper.deleteQualityRecordByIds(arr);
    }

    @Override
    public List<QualityRecord> selectQualityRecordExportList(QualityRecord record)
    {
        return qualityRecordMapper.selectQualityRecordList(record);
    }

    @Override
    public List<Long> selectPassedWorkOrderIds()
    {
        return qualityRecordMapper.selectPassedWorkOrderIds();
    }
}
