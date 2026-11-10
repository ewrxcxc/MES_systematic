package com.ruoyi.mes.service;

import java.util.List;
import com.ruoyi.mes.domain.WorkOrder;
import com.ruoyi.mes.dto.WorkOrderDTO;
import com.ruoyi.mes.dto.WorkOrderQueryDTO;
import com.ruoyi.mes.vo.WorkOrderVO;

public interface IWorkOrderService
{
    public List<WorkOrderVO> selectWorkOrderList(WorkOrderQueryDTO query);
    public WorkOrderVO selectWorkOrderById(Long workOrderId);
    public int insertWorkOrder(WorkOrderDTO dto, String operator);
    public int updateWorkOrder(WorkOrderDTO dto, String operator);
    public int deleteWorkOrderByIds(String ids);
    public List<WorkOrder> selectWorkOrderExportList(WorkOrderQueryDTO query);
    public int startWorkOrder(Long workOrderId, String operator);
    public int finishWorkOrder(Long workOrderId, Integer completedQty, String operator);
}
