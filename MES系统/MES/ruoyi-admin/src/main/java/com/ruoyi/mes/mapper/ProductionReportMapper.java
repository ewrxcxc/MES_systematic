package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.ProductionReport;
import com.ruoyi.mes.dto.ProductionReportQueryDTO;
import com.ruoyi.mes.vo.ProductionReportVO;

public interface ProductionReportMapper
{
    public List<ProductionReportVO> selectReportList(ProductionReportQueryDTO q);
    public ProductionReportVO selectReportById(Long id);
    public ProductionReport selectReportEntityById(Long id);
    public int insertReport(ProductionReport r);
    public int updateReport(ProductionReport r);
    public int deleteReportByIds(@Param("ids") Long[] ids);
    public List<ProductionReport> selectReportsByWorkOrderId(Long workOrderId);
}
