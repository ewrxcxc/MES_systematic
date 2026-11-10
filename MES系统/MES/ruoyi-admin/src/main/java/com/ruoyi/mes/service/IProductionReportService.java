package com.ruoyi.mes.service;

import java.util.List;
import com.ruoyi.mes.domain.ProductionReport;
import com.ruoyi.mes.dto.ProductionReportDTO;
import com.ruoyi.mes.dto.ProductionReportQueryDTO;
import com.ruoyi.mes.vo.ProductionReportVO;

public interface IProductionReportService
{
    public List<ProductionReportVO> selectReportList(ProductionReportQueryDTO q);
    public ProductionReportVO selectReportById(Long id);
    public int insertReport(ProductionReportDTO dto, String operator);
    public int updateReport(ProductionReportDTO dto, String operator);
    public int deleteReportByIds(String ids);
    public int inspectReport(Long reportId, String qualityResult, String inspector, String qualityRemark, String operator);
    public List<ProductionReport> selectReportExportList(ProductionReportQueryDTO q);
}
