package com.ruoyi.mes.service.impl;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.mes.domain.*;
import com.ruoyi.mes.mapper.*;
import com.ruoyi.mes.service.IQualityTraceService;
import com.ruoyi.mes.vo.TraceVO;
import com.ruoyi.mes.vo.OrderChainVO;

@Service
public class QualityTraceServiceImpl implements IQualityTraceService
{
    @Autowired private QualityTraceMapper traceMapper;
    @Autowired private SalesOrderMapper salesOrderMapper;
    @Autowired private ProductionPlanMapper planMapper;
    @Autowired private WorkOrderMapper workOrderMapper;
    @Autowired private ProcessTaskMapper processTaskMapper;
    @Autowired private ProductionReportMapper reportMapper;
    @Autowired private WarehousingMapper warehousingMapper;
    @Autowired private ShipmentRecordMapper shipmentMapper;
    @Autowired private ProcessEquipmentMappingMapper pemMapper;
    @Autowired private EquipmentMapper equipmentMapper;

    /** 启动时自动初始化工序→设备映射（修正process_seq不匹配问题） */
    @EventListener(ApplicationReadyEvent.class)
    public void initProcessEquipmentMapping() {
        try {
            // 1. 查询工序任务中的真实 process_seq（不JOIN任何表，避免SQL异常）
            List<Map<String, Object>> processRows = traceMapper.selectDistinctProcessSeqs();
            if (processRows == null || processRows.isEmpty()) {
                System.out.println("[MES_TRACE] mes_process_task 表为空，跳过映射初始化");
                return;
            }

            Map<Integer, String> seqNameMap = new LinkedHashMap<>();
            for (Map<String, Object> row : processRows) {
                Object seqObj = row.get("process_seq");
                Object nameObj = row.get("process_name");
                if (seqObj != null) {
                    Integer seq = Integer.valueOf(seqObj.toString());
                    String name = nameObj != null ? nameObj.toString() : ("工序" + seq);
                    seqNameMap.put(seq, name);
                }
            }
            System.out.println("[MES_TRACE] 工序任务 process_seq: " + seqNameMap.keySet());

            // 2. 查询现有映射
            List<ProcessEquipmentMapping> existing = pemMapper.selectMappingList(new ProcessEquipmentMapping());
            if (existing == null) existing = Collections.emptyList();
            System.out.println("[MES_TRACE] 现有映射: " + existing.size() + " 条");

            // 3. 检查 process_seq 是否匹配
            Set<Integer> taskSeqs = seqNameMap.keySet();
            boolean mismatch = !existing.isEmpty();
            for (ProcessEquipmentMapping m : existing) {
                if (m.getProcessSeq() != null && taskSeqs.contains(m.getProcessSeq())) {
                    mismatch = false;
                    break;
                }
            }
            // 反过来检查：映射中的seq是否全在task中
            if (!mismatch) {
                for (ProcessEquipmentMapping m : existing) {
                    if (m.getProcessSeq() != null && !taskSeqs.contains(m.getProcessSeq())) {
                        mismatch = true;
                        break;
                    }
                }
            }

            if (mismatch) {
                System.out.println("[MES_TRACE] process_seq不匹配 → 删除旧映射并重建");
                Long[] ids = existing.stream().map(ProcessEquipmentMapping::getId).toArray(Long[]::new);
                pemMapper.deleteMappingByIds(ids);
                existing = Collections.emptyList();
            }

            // 4. 获取设备列表
            List<Equipment> equipments = equipmentMapper.selectEquipmentList(null, null, null);
            if (equipments == null || equipments.isEmpty()) {
                System.out.println("[MES_TRACE] 设备表为空，跳过映射初始化");
                return;
            }

            // 5. 映射为空或不匹配 → 重建
            if (existing.isEmpty()) {
                int idx = 0;
                for (Map.Entry<Integer, String> entry : seqNameMap.entrySet()) {
                    Equipment eq = equipments.get(idx % equipments.size());
                    ProcessEquipmentMapping pem = new ProcessEquipmentMapping();
                    pem.setProcessCode("P" + String.format("%02d", entry.getKey()));
                    pem.setProcessName(entry.getValue());
                    pem.setProcessSeq(entry.getKey());
                    pem.setEquipmentId(eq.getEquipmentId());
                    pem.setEquipmentCode(eq.getEquipmentCode() != null ? eq.getEquipmentCode() : "");
                    pem.setEquipmentName(eq.getEquipmentName());
                    pem.setStatus("ACTIVE");
                    pem.setCreateBy("SYSTEM");
                    pemMapper.insertMapping(pem);
                    idx++;
                }
                System.out.println("[MES_TRACE] 重建 " + idx + " 条工序→设备映射，process_seq=" + seqNameMap.keySet());
            }
        } catch (Exception e) {
            System.err.println("[MES_TRACE] 初始化工序→设备映射失败: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public List<QualityTrace> selectTraceList(QualityTrace trace) {
        return traceMapper.selectTraceList(trace);
    }

    @Override
    public QualityTrace selectTraceById(Long traceId) {
        return traceMapper.selectTraceById(traceId);
    }

    @Override
    public List<QualityTrace> traceByProduct(Long productId) {
        return traceMapper.selectTraceByProductId(productId);
    }

    @Override
    public List<QualityTrace> traceByWorkOrder(Long workOrderId) {
        return traceMapper.selectTraceByWorkOrderId(workOrderId);
    }

    @Override
    public List<QualityTrace> traceByBatchNo(String batchNo) {
        return traceMapper.selectTraceByBatchNo(batchNo);
    }

    @Override
    public List<TraceVO> searchTraces(TraceVO query) {
        return traceMapper.searchTraces(query);
    }

    @Override
    public OrderChainVO getOrderChain(Long orderId) {
        OrderChainVO chain = new OrderChainVO();

        // 1. 订单
        chain.setOrder(salesOrderMapper.selectSalesOrderEntityById(orderId));

        // 2. 生产计划（按订单ID查）
        List<ProductionPlan> plans = planMapper.selectProductionPlanEntityByOrderId(orderId);
        if (plans != null && !plans.isEmpty()) {
            ProductionPlan plan = plans.get(0);
            chain.setPlan(plan);

            // 3. 工单（按计划ID查）
            List<WorkOrder> wos = workOrderMapper.selectWorkOrdersByPlanId(plan.getPlanId());
            chain.setWorkOrders(wos);

            if (wos != null && !wos.isEmpty()) {
                WorkOrder wo = wos.get(0);

                // 4. 工序任务
                chain.setTasks(processTaskMapper.selectByWorkOrderId(wo.getWorkOrderId()));

                // 5. 报工记录
                chain.setReports(reportMapper.selectReportsByWorkOrderId(wo.getWorkOrderId()));

                // 6. 质量追溯
                chain.setTraces(traceMapper.selectTraceByWorkOrderId(wo.getWorkOrderId()));

                // 7. 入库记录
                chain.setWarehousings(warehousingMapper.selectWarehousingListByWorkOrderId(wo.getWorkOrderId()));
            }
        }

        // 8. 发货记录
        chain.setShipment(shipmentMapper.selectShipmentByOrderId(orderId));

        return chain;
    }

    @Override
    public Map<String, Object> queryByWorkOrderNo(String workOrderNo) {
        Map<String, Object> result = new LinkedHashMap<>();

        // 1. 查工单
        WorkOrder wo = workOrderMapper.selectWorkOrderByNo(workOrderNo);
        if (wo == null) {
            result.put("orderInfo", new HashMap<>());
            result.put("workOrderInfo", new HashMap<>());
            result.put("processList", Collections.emptyList());
            result.put("qcResult", new HashMap<>());
            return result;
        }

        Map<String, Object> woInfo = new LinkedHashMap<>();
        woInfo.put("workOrderId", wo.getWorkOrderId());
        woInfo.put("workOrderNo", wo.getWorkOrderNo());
        woInfo.put("plannedQty", wo.getPlannedQty());
        woInfo.put("completedQty", wo.getCompletedQty());
        woInfo.put("status", wo.getStatus());
        woInfo.put("currentStep", wo.getCurrentStep());
        woInfo.put("totalSteps", wo.getTotalSteps());
        woInfo.put("plannedStart", wo.getPlannedStart());
        woInfo.put("plannedEnd", wo.getPlannedEnd());
        result.put("workOrderInfo", woInfo);

        // 2. 查订单
        SalesOrder so = salesOrderMapper.selectSalesOrderEntityById(wo.getOrderId());
        Map<String, Object> orderInfo = new LinkedHashMap<>();
        if (so != null) {
            orderInfo.put("orderId", so.getOrderId());
            orderInfo.put("orderNo", so.getOrderNo());
            orderInfo.put("customerName", so.getCustomerName());
            orderInfo.put("productName", so.getProductName());
            orderInfo.put("productCode", "");
            orderInfo.put("quantity", so.getQuantity());
            orderInfo.put("dueDate", so.getDueDate());
            orderInfo.put("orderStatus", so.getOrderStatus());
            orderInfo.put("deliveryStatus", so.getDeliveryStatus());
        }
        result.put("orderInfo", orderInfo);

        // 3. 查工序任务
        List<ProcessTask> tasks = processTaskMapper.selectByWorkOrderId(wo.getWorkOrderId());
        tasks.sort(Comparator.comparing(t -> t.getProcessSeq() != null ? t.getProcessSeq() : 0));

        // 4. 查报工记录
        List<ProductionReport> reports = reportMapper.selectReportsByWorkOrderId(wo.getWorkOrderId());
        Map<Integer, ProductionReport> rptBySeq = new LinkedHashMap<>();
        for (ProductionReport r : reports) {
            if (r.getProcessSeq() != null) {
                rptBySeq.putIfAbsent(r.getProcessSeq(), r);
            }
        }

        // 5. 查质量追溯
        List<QualityTrace> traces = traceMapper.selectTraceByWorkOrderId(wo.getWorkOrderId());

        // 6. 组装工序列表
        List<Map<String, Object>> processList = new ArrayList<>();
        for (ProcessTask t : tasks) {
            Map<String, Object> node = new LinkedHashMap<>();
            node.put("processSeq", t.getProcessSeq());
            node.put("processName", t.getProcessName());
            node.put("status", t.getStatus());
            node.put("equipmentId", t.getEquipmentId());
            node.put("operatorId", t.getOperatorId());
            node.put("startTime", t.getStartTime());
            node.put("endTime", t.getEndTime());
            node.put("plannedQty", t.getPlannedQty());
            node.put("goodQty", t.getGoodQty());
            node.put("badQty", t.getBadQty());

            // 合并报工数据
            ProductionReport rpt = rptBySeq.get(t.getProcessSeq());
            if (rpt != null) {
                node.put("reportId", rpt.getReportId());
                node.put("reportTime", rpt.getReportTime());
                node.put("reportType", rpt.getReportType());
                if (rpt.getGoodQty() != null) node.put("goodQty", rpt.getGoodQty());
                if (rpt.getBadQty() != null) node.put("badQty", rpt.getBadQty());
                node.put("inspector", rpt.getInspector());
                node.put("qualityResult", rpt.getQualityResult());
                node.put("qualityTime", rpt.getQualityTime());
                if (rpt.getOperatorId() != null && t.getOperatorId() == null) {
                    node.put("operatorId", rpt.getOperatorId());
                }
                if (rpt.getEquipmentId() != null && t.getEquipmentId() == null) {
                    node.put("equipmentId", rpt.getEquipmentId());
                }
            }

            // 合并追溯数据
            for (QualityTrace qt : traces) {
                if (rpt != null && rpt.getReportId() != null) continue;
                if (qt.getInspector() != null && !node.containsKey("inspector")) {
                    node.put("inspector", qt.getInspector());
                }
                if (qt.getInspectResult() != null && !node.containsKey("qualityResult")) {
                    node.put("qualityResult", qt.getInspectResult());
                }
            }

            processList.add(node);
        }
        result.put("processList", processList);

        // 7. 质量汇总
        Map<String, Object> qcResult = new LinkedHashMap<>();
        int totalQty = 0, totalGood = 0, totalBad = 0;
        for (Map<String, Object> p : processList) {
            Integer g = (Integer) p.get("goodQty");
            Integer b = (Integer) p.get("badQty");
            if (g != null) { totalGood += g; totalQty += g; }
            if (b != null) { totalBad += b; totalQty += b; }
        }
        qcResult.put("totalQty", totalQty);
        qcResult.put("totalGood", totalGood);
        qcResult.put("totalBad", totalBad);
        qcResult.put("passRate", totalQty > 0 ? Math.round(totalGood * 10000.0 / totalQty) / 100.0 : 0);
        qcResult.put("inspectCount", traces.size());
        result.put("qcResult", qcResult);

        return result;
    }

    @Override
    public List<Map<String, Object>> getDistinctOrders() {
        return traceMapper.selectDistinctOrders();
    }

    @Override
    public List<BatchInfo> selectBatchList(BatchInfo batch) {
        return traceMapper.selectBatchList(batch);
    }

    @Override
    public int insertBatch(BatchInfo batch, String operator) {
        batch.setCreateBy(operator);
        return traceMapper.insertBatchInfo(batch);
    }

    @Override
    public List<DefectRecord> selectDefectList(DefectRecord defect) {
        return traceMapper.selectDefectList(defect);
    }

    @Override
    public List<DefectRecord> selectDefectsByWorkOrderId(Long workOrderId) {
        return traceMapper.selectDefectsByWorkOrderId(workOrderId);
    }

    @Override
    public int insertDefect(DefectRecord defect, String operator) {
        defect.setCreateBy(operator);
        defect.setDiscoverTime(new Date());
        return traceMapper.insertDefectRecord(defect);
    }

    @Override
    public int updateDefect(DefectRecord defect) {
        defect.setHandleTime(new Date());
        return traceMapper.updateDefectRecord(defect);
    }
}
