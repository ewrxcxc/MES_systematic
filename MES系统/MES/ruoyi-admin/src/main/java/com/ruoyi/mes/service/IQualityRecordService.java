package com.ruoyi.mes.service;

import java.util.List;
import com.ruoyi.mes.domain.QualityRecord;

public interface IQualityRecordService
{
    List<QualityRecord> selectQualityRecordList(QualityRecord record);
    QualityRecord selectQualityRecordById(Long id);
    int insertQualityRecord(QualityRecord record, String operator);
    int updateQualityRecord(QualityRecord record, String operator);
    int deleteQualityRecordByIds(String ids);
    List<QualityRecord> selectQualityRecordExportList(QualityRecord record);
    List<Long> selectPassedWorkOrderIds();
}
