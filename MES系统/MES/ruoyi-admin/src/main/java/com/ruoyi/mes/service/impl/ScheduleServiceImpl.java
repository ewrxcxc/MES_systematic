package com.ruoyi.mes.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.mes.domain.Schedule;
import com.ruoyi.mes.domain.WorkOrder;
import com.ruoyi.mes.domain.SalesOrder;
import com.ruoyi.mes.mapper.ScheduleMapper;
import com.ruoyi.mes.mapper.WorkOrderMapper;
import com.ruoyi.mes.mapper.SalesOrderMapper;
import com.ruoyi.mes.service.IScheduleService;

@Service
public class ScheduleServiceImpl implements IScheduleService
{
    @Autowired
    private ScheduleMapper scheduleMapper;
    @Autowired
    private WorkOrderMapper workOrderMapper;
    @Autowired
    private SalesOrderMapper salesOrderMapper;

    @Override
    public List<Schedule> selectScheduleList(Schedule schedule)
    {
        return scheduleMapper.selectScheduleList(schedule);
    }

    @Override
    public Schedule selectScheduleById(Long scheduleId)
    {
        return scheduleMapper.selectScheduleById(scheduleId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertSchedule(Schedule schedule)
    {
        if (schedule.getScheduleNo() == null || schedule.getScheduleNo().isEmpty())
            schedule.setScheduleNo("SC" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
        if (schedule.getStatus() == null || schedule.getStatus().isEmpty())
            schedule.setStatus("PENDING");

        // 若productId为空，通过工单关联链自动填充: work_order.order_id → sales_order.product_id
        if (schedule.getProductId() == null && schedule.getWorkOrderId() != null) {
            WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(schedule.getWorkOrderId());
            if (wo != null && wo.getOrderId() != null) {
                SalesOrder so = salesOrderMapper.selectSalesOrderEntityById(wo.getOrderId());
                if (so != null && so.getProductId() != null) {
                    schedule.setProductId(so.getProductId());
                }
            }
        }

        return scheduleMapper.insertSchedule(schedule);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateSchedule(Schedule schedule)
    {
        if (schedule.getScheduleId() == null)
            throw new ServiceException("排程ID不能为空");

        // 若productId为空，通过工单关联链自动填充
        if (schedule.getProductId() == null && schedule.getWorkOrderId() != null) {
            WorkOrder wo = workOrderMapper.selectWorkOrderEntityById(schedule.getWorkOrderId());
            if (wo != null && wo.getOrderId() != null) {
                SalesOrder so = salesOrderMapper.selectSalesOrderEntityById(wo.getOrderId());
                if (so != null && so.getProductId() != null) {
                    schedule.setProductId(so.getProductId());
                }
            }
        }

        return scheduleMapper.updateSchedule(schedule);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteScheduleByIds(String ids)
    {
        Long[] arr = Convert.toLongArray(ids);
        if (arr.length == 0)
            throw new ServiceException("请选择要删除的排程");
        return scheduleMapper.deleteScheduleByIds(arr);
    }

    @Override
    public List<Schedule> selectScheduleExportList(Schedule schedule)
    {
        return scheduleMapper.selectScheduleList(schedule);
    }
}
