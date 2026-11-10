package com.ruoyi.mes.mapper;

import java.util.List;
import java.util.Map;
import com.ruoyi.mes.domain.QualityTrace;
import com.ruoyi.mes.domain.BatchInfo;
import com.ruoyi.mes.domain.DefectRecord;
import com.ruoyi.mes.vo.TraceVO;

public interface QualityTraceMapper
{
    List<QualityTrace> selectTraceList(QualityTrace trace);
    QualityTrace selectTraceById(Long traceId);
    List<QualityTrace> selectTraceByProductId(Long productId);
    List<QualityTrace> selectTraceByWorkOrderId(Long workOrderId);
    List<QualityTrace> selectTraceByBatchNo(String batchNo);
    int insertQualityTrace(QualityTrace trace);

    // 跨表查询追溯记录
    List<TraceVO> searchTraces(TraceVO query);
    // 去重订单下拉列表
    List<Map<String, Object>> selectDistinctOrders();
    // 工序去重列表（用于修正设备映射的process_seq）
    List<Map<String, Object>> selectDistinctProcessSeqs();

    List<BatchInfo> selectBatchList(BatchInfo batch);
    BatchInfo selectBatchByNo(String batchNo);
    int insertBatchInfo(BatchInfo batch);

    List<DefectRecord> selectDefectList(DefectRecord defect);
    List<DefectRecord> selectDefectsByWorkOrderId(Long workOrderId);
    int insertDefectRecord(DefectRecord defect);
    int updateDefectRecord(DefectRecord defect);
}
