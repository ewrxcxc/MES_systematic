package com.ruoyi.mes.mapper;

import java.util.List;
import com.ruoyi.mes.domain.ProductionPlan;
import com.ruoyi.mes.dto.ProductionPlanQueryDTO;
import com.ruoyi.mes.vo.ProductionPlanVO;

public interface ProductionPlanMapper
{
    List<ProductionPlanVO> selectProductionPlanList(ProductionPlanQueryDTO query);
    ProductionPlanVO selectProductionPlanById(Long planId);
    ProductionPlan selectProductionPlanEntityById(Long planId);
    ProductionPlan selectProductionPlanByNo(String planNo);
    int insertProductionPlan(ProductionPlan plan);
    int updateProductionPlan(ProductionPlan plan);
    int deleteProductionPlanByIds(Long[] planIds);
    List<ProductionPlan> selectProductionPlanEntityByOrderId(Long orderId);
}
