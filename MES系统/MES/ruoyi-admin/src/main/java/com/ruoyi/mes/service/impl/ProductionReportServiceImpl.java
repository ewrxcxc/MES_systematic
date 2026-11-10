package com.ruoyi.mes.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.mes.domain.ProductionReport;
import com.ruoyi.mes.dto.ProductionReportDTO;
import com.ruoyi.mes.dto.ProductionReportQueryDTO;
import com.ruoyi.mes.mapper.ProductionReportMapper;
import com.ruoyi.mes.service.IProductionReportService;
import com.ruoyi.mes.vo.ProductionReportVO;

@Service
public class ProductionReportServiceImpl implements IProductionReportService
{
    @Autowired
    private ProductionReportMapper mapper;

    @Override public List<ProductionReportVO> selectReportList(ProductionReportQueryDTO q) { return mapper.selectReportList(q); }
    @Override public ProductionReportVO selectReportById(Long id) { return mapper.selectReportById(id); }

    @Override @Transactional(rollbackFor = Exception.class)
    public int insertReport(ProductionReportDTO dto, String operator) {
        if (dto.getWorkOrderId() == null) throw new ServiceException("请选择关联工单");
        if (dto.getProcessSeq() == null) throw new ServiceException("请选择报工工序");
        ProductionReport r = toEntity(dto);
        if (r.getReportTime() == null) r.setReportTime(new Date());
        if (r.getProcessName() == null || r.getProcessName().isEmpty()) r.setProcessName("工序" + dto.getProcessSeq());
        if (r.getStatus() == null || r.getStatus().isEmpty()) r.setStatus("REPORTED");
        r.setCreateBy(operator);
        return mapper.insertReport(r);
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int updateReport(ProductionReportDTO dto, String operator) {
        if (dto.getReportId() == null) throw new ServiceException("报告ID不能为空");
        ProductionReport r = toEntity(dto);
        r.setUpdateBy(operator);
        return mapper.updateReport(r);
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int deleteReportByIds(String ids) {
        Long[] arr = Convert.toLongArray(ids);
        if (arr.length == 0) throw new ServiceException("请选择要删除的报告");
        return mapper.deleteReportByIds(arr);
    }

    @Override @Transactional(rollbackFor = Exception.class)
    public int inspectReport(Long reportId, String qualityResult, String inspector, String qualityRemark, String operator) {
        ProductionReport report = mapper.selectReportEntityById(reportId);
        if (report == null) throw new ServiceException("报工记录不存在");
        if (!"REPORTED".equals(report.getStatus())) throw new ServiceException("当前状态不允许质检");
        if (qualityResult == null || qualityResult.isEmpty()) throw new ServiceException("请选择质检结果");
        report.setQualityResult(qualityResult);
        report.setInspector(inspector);
        report.setQualityTime(new Date());
        report.setStatus("INSPECTED");
        report.setRemark(qualityRemark != null && !qualityRemark.isEmpty() ? qualityRemark : report.getRemark());
        report.setUpdateBy(operator);
        return mapper.updateReport(report);
    }

    @Override public List<ProductionReport> selectReportExportList(ProductionReportQueryDTO q) {
        List<ProductionReportVO> vos = mapper.selectReportList(q);
        List<ProductionReport> list = new ArrayList<>();
        for (ProductionReportVO vo : vos) { ProductionReport r = new ProductionReport(); BeanUtils.copyProperties(vo, r); list.add(r); }
        return list;
    }

    private ProductionReport toEntity(ProductionReportDTO dto) { ProductionReport r = new ProductionReport(); BeanUtils.copyProperties(dto, r); return r; }
}
