package com.ruoyi.mes.service;

import java.util.List;
import java.util.Map;
import com.ruoyi.mes.domain.QualityTrace;
import com.ruoyi.mes.domain.BatchInfo;
import com.ruoyi.mes.domain.DefectRecord;
import com.ruoyi.mes.vo.TraceVO;
import com.ruoyi.mes.vo.OrderChainVO;

public interface IQualityTraceService
{
    List<QualityTrace> selectTraceList(QualityTrace trace);
    QualityTrace selectTraceById(Long traceId);
    List<QualityTrace> traceByProduct(Long productId);
    List<QualityTrace> traceByWorkOrder(Long workOrderId);
    List<QualityTrace> traceByBatchNo(String batchNo);

    // 跨表查询追溯记录
    List<TraceVO> searchTraces(TraceVO query);
    // 完整业务链条
    OrderChainVO getOrderChain(Long orderId);
    // 按工单号查询追溯链路
    Map<String, Object> queryByWorkOrderNo(String workOrderNo);

    // 订单下拉列表
    List<Map<String, Object>> getDistinctOrders();

    List<BatchInfo> selectBatchList(BatchInfo batch);
    int insertBatch(BatchInfo batch, String operator);

    List<DefectRecord> selectDefectList(DefectRecord defect);
    List<DefectRecord> selectDefectsByWorkOrderId(Long workOrderId);
    int insertDefect(DefectRecord defect, String operator);
    int updateDefect(DefectRecord defect);
}
