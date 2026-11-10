package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.WorkOrder;
import com.ruoyi.mes.dto.WorkOrderQueryDTO;
import com.ruoyi.mes.vo.WorkOrderVO;

public interface WorkOrderMapper
{
    public List<WorkOrderVO> selectWorkOrderList(WorkOrderQueryDTO query);
    public WorkOrderVO selectWorkOrderById(Long workOrderId);
    public WorkOrder selectWorkOrderEntityById(Long workOrderId);
    public WorkOrder selectWorkOrderByNo(String workOrderNo);
    public int insertWorkOrder(WorkOrder workOrder);
    public int updateWorkOrder(WorkOrder workOrder);
    public int deleteWorkOrderByIds(@Param("ids") Long[] ids);
    // 按计划ID查询工单（防重复生成）
    public List<WorkOrder> selectWorkOrdersByPlanId(Long planId);
    // 按订单ID查询工单（AI分析用）
    public List<WorkOrder> selectWorkOrdersByOrderId(Long orderId);
}
