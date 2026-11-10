package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.ProductionLine;

public interface ProductionLineMapper
{
    List<ProductionLine> selectProductionLineList(@Param("lineCode") String lineCode, @Param("lineName") String lineName);
    ProductionLine selectProductionLineById(Long lineId);
    int insertProductionLine(ProductionLine line);
    int updateProductionLine(ProductionLine line);
    int deleteProductionLineByIds(@Param("ids") Long[] ids);
}
