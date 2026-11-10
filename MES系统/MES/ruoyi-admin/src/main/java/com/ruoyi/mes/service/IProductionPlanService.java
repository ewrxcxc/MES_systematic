package com.ruoyi.mes.service;

import java.util.List;
import java.util.Date;
import com.ruoyi.mes.domain.ProductionPlan;
import com.ruoyi.mes.domain.SalesOrder;
import com.ruoyi.mes.dto.ProductionPlanDTO;
import com.ruoyi.mes.dto.ProductionPlanQueryDTO;
import com.ruoyi.mes.vo.ProductionPlanVO;

public interface IProductionPlanService
{
    List<ProductionPlanVO> selectProductionPlanList(ProductionPlanQueryDTO query);
    ProductionPlanVO selectProductionPlanById(Long planId);
    int insertProductionPlan(ProductionPlanDTO dto, String operator);
    int updateProductionPlan(ProductionPlanDTO dto, String operator);
    int deleteProductionPlanByIds(String ids);
    List<ProductionPlan> selectProductionPlanExportList(ProductionPlanQueryDTO query);
    boolean checkPlanNoUnique(ProductionPlanDTO dto);
    /** 从销售订单自动创建生产计划 */
    ProductionPlan createFromSalesOrder(SalesOrder order);
    /** 从生产计划生成工单 */
    int generateWorkOrder(Long planId, String operator);
    /** 审核生产计划 */
    int auditProductionPlan(Long planId, String operator);
    /** 更新时间 */
    int updatePlanTime(Long planId, Date planStartTime, Date planEndTime, String operator);
}
