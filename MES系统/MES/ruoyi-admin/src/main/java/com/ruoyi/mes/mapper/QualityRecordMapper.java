package com.ruoyi.mes.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.mes.domain.QualityRecord;

public interface QualityRecordMapper
{
    List<QualityRecord> selectQualityRecordList(QualityRecord record);
    QualityRecord selectQualityRecordById(Long id);
    QualityRecord selectPassByWorkOrderId(Long workOrderId);
    int insertQualityRecord(QualityRecord record);
    int updateQualityRecord(QualityRecord record);
    int deleteQualityRecordByIds(@Param("ids") Long[] ids);
    QualityRecord selectByWorkOrderId(Long workOrderId);
    List<Long> selectPassedWorkOrderIds();
}
