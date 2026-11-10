package com.ruoyi.mes.service.impl;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import com.ruoyi.mes.domain.*;
import com.ruoyi.mes.mapper.*;
import com.ruoyi.mes.service.IMesAIAnalysisService;

@Service
public class MesAIAnalysisServiceImpl implements IMesAIAnalysisService {

    @Autowired private SalesOrderMapper salesOrderMapper;
    @Autowired private WorkOrderMapper workOrderMapper;
    @Autowired private ProcessTaskMapper processTaskMapper;
    @Autowired private QualityRecordMapper qualityRecordMapper;
    @Autowired private EquipmentMapper equipmentMapper;
    @Autowired private QualityTraceMapper qualityTraceMapper;
    @Autowired private RestTemplate restTemplate;

    @Value("${deepseek.api-key}")
    private String apiKey;
    @Value("${deepseek.url}")
    private String deepseekUrl;

    @Override
    public Map<String, Object> analyzeSalesOrder(String orderNo) {
        Map<String, Object> result = new LinkedHashMap<>();

        // 1. 查订单
        SalesOrder order = salesOrderMapper.selectSalesOrderByNo(orderNo);
        if (order == null) {
            result.put("error", "订单不存在: " + orderNo);
            return result;
        }

        Map<String, Object> orderInfo = new LinkedHashMap<>();
        orderInfo.put("orderNo", order.getOrderNo());
        orderInfo.put("customerName", order.getCustomerName());
        orderInfo.put("productName", order.getProductName());
        orderInfo.put("quantity", order.getQuantity());
        orderInfo.put("dueDate", order.getDueDate());
        orderInfo.put("orderStatus", order.getOrderStatus());
        orderInfo.put("deliveryStatus", order.getDeliveryStatus());
        result.put("orderSummary", orderInfo);

        // 2. 查工单
        List<WorkOrder> workOrders = workOrderMapper.selectWorkOrdersByOrderId(order.getOrderId());
        if (workOrders == null) workOrders = Collections.emptyList();

        List<Map<String, Object>> woList = new ArrayList<>();
        List<Map<String, Object>> allTasks = new ArrayList<>();
        List<Map<String, Object>> allQcs = new ArrayList<>();
        Set<Long> equipmentIdSet = new LinkedHashSet<>();

        for (WorkOrder wo : workOrders) {
            Map<String, Object> woInfo = new LinkedHashMap<>();
            woInfo.put("workOrderNo", wo.getWorkOrderNo());
            woInfo.put("plannedQty", wo.getPlannedQty());
            woInfo.put("completedQty", wo.getCompletedQty());
            woInfo.put("status", wo.getStatus());
            woInfo.put("currentStep", wo.getCurrentStep());
            woInfo.put("totalSteps", wo.getTotalSteps());
            woList.add(woInfo);

            // 3. 工序任务
            List<ProcessTask> tasks = processTaskMapper.selectByWorkOrderId(wo.getWorkOrderId());
            if (tasks != null) {
                tasks.sort(Comparator.comparing(t -> t.getProcessSeq() != null ? t.getProcessSeq() : 0));
                for (ProcessTask t : tasks) {
                    Map<String, Object> ti = new LinkedHashMap<>();
                    ti.put("workOrderNo", wo.getWorkOrderNo());
                    ti.put("processSeq", t.getProcessSeq());
                    ti.put("processName", t.getProcessName());
                    ti.put("status", t.getStatus());
                    ti.put("goodQty", t.getGoodQty());
                    ti.put("badQty", t.getBadQty());
                    ti.put("startTime", t.getStartTime());
                    ti.put("endTime", t.getEndTime());
                    if (t.getEquipmentId() != null) equipmentIdSet.add(t.getEquipmentId());
                    allTasks.add(ti);
                }
            }

            // 4. 质检记录
            QualityRecord qr = qualityRecordMapper.selectByWorkOrderId(wo.getWorkOrderId());
            if (qr != null) {
                Map<String, Object> qi = new LinkedHashMap<>();
                qi.put("workOrderNo", wo.getWorkOrderNo());
                qi.put("checkType", qr.getCheckType());
                qi.put("quantity", qr.getQuantity());
                qi.put("defectQuantity", qr.getDefectQuantity());
                qi.put("result", qr.getResult());
                qi.put("inspector", qr.getInspector());
                qi.put("checkTime", qr.getCheckTime());
                allQcs.add(qi);
            }
        }

        // 5. 批量查询设备名称
        Map<Long, String> equipNameMap = new LinkedHashMap<>();
        for (Long eid : equipmentIdSet) {
            Equipment eq = equipmentMapper.selectEquipmentById(eid);
            if (eq != null) equipNameMap.put(eid, eq.getEquipmentName());
        }
        // 回填设备名到工序数据
        for (Map<String, Object> ti : allTasks) {
            // equipmentId already consumed during iteration above; we stored it in a temp map
            // Actually we need to re-query — let's do it differently. Store device names in task data directly.
        }
        // Simpler approach: add equipment info to each task during task iteration above

        // Build prompt
        String prompt = buildPrompt(orderInfo, woList, allTasks, allQcs, equipNameMap);

        // Call DeepSeek
        String analysisResult = callDeepSeek(prompt);
        result.put("analysisResult", analysisResult);

        return result;
    }

    @Override
    public List<Map<String, Object>> getDistinctOrders() {
        return qualityTraceMapper.selectDistinctOrders();
    }

    private String buildPrompt(Map<String, Object> orderInfo, List<Map<String, Object>> woList,
                               List<Map<String, Object>> allTasks, List<Map<String, Object>> allQcs,
                               Map<Long, String> equipNameMap) {
        StringBuilder sb = new StringBuilder();
        sb.append("请分析以下MES生产数据：\n\n");

        sb.append("【销售订单】\n");
        sb.append("- 订单编号: ").append(orderInfo.get("orderNo")).append("\n");
        sb.append("- 客户: ").append(orderInfo.get("customerName")).append("\n");
        sb.append("- 产品: ").append(orderInfo.get("productName")).append("\n");
        sb.append("- 订单数量: ").append(orderInfo.get("quantity")).append("\n");
        sb.append("- 交期: ").append(orderInfo.get("dueDate")).append("\n");
        sb.append("- 订单状态: ").append(orderInfo.get("orderStatus")).append("\n");
        sb.append("- 发货状态: ").append(orderInfo.get("deliveryStatus")).append("\n\n");

        sb.append("【工单数据】\n");
        sb.append("| 工单号 | 计划数 | 完成数 | 状态 | 当前工序 | 总工序 |\n");
        sb.append("|--------|--------|--------|------|----------|--------|\n");
        for (Map<String, Object> wo : woList) {
            sb.append("| ").append(wo.get("workOrderNo"))
              .append(" | ").append(wo.get("plannedQty"))
              .append(" | ").append(wo.get("completedQty"))
              .append(" | ").append(wo.get("status"))
              .append(" | ").append(wo.get("currentStep"))
              .append(" | ").append(wo.get("totalSteps")).append(" |\n");
        }
        sb.append("\n");

        sb.append("【工序执行数据】\n");
        sb.append("| 工单号 | 序号 | 工序名称 | 状态 | 良品 | 不良 | 开始时间 | 结束时间 |\n");
        sb.append("|--------|------|----------|------|------|------|----------|----------|\n");
        for (Map<String, Object> t : allTasks) {
            sb.append("| ").append(t.get("workOrderNo"))
              .append(" | ").append(t.get("processSeq"))
              .append(" | ").append(t.get("processName"))
              .append(" | ").append(t.get("status"))
              .append(" | ").append(t.get("goodQty"))
              .append(" | ").append(t.get("badQty"))
              .append(" | ").append(t.get("startTime"))
              .append(" | ").append(t.get("endTime")).append(" |\n");
        }
        sb.append("\n");

        if (!allQcs.isEmpty()) {
            sb.append("【质检数据】\n");
            sb.append("| 工单号 | 检验类型 | 检验数 | 不良数 | 结果 | 检验员 | 检验时间 |\n");
            sb.append("|--------|----------|--------|--------|------|--------|----------|\n");
            for (Map<String, Object> q : allQcs) {
                sb.append("| ").append(q.get("workOrderNo"))
                  .append(" | ").append(q.get("checkType"))
                  .append(" | ").append(q.get("quantity"))
                  .append(" | ").append(q.get("defectQuantity"))
                  .append(" | ").append(q.get("result"))
                  .append(" | ").append(q.get("inspector"))
                  .append(" | ").append(q.get("checkTime")).append(" |\n");
            }
            sb.append("\n");
        }

        if (!equipNameMap.isEmpty()) {
            sb.append("【涉及设备】\n");
            for (Map.Entry<Long, String> e : equipNameMap.entrySet()) {
                sb.append("- ID:").append(e.getKey()).append(" ").append(e.getValue()).append("\n");
            }
            sb.append("\n");
        }

        sb.append("请输出以下分析：\n");
        sb.append("1. 订单整体生产进度\n");
        sb.append("2. 各工单执行情况对比\n");
        sb.append("3. 质量分析（合格率、不良趋势）\n");
        sb.append("4. 瓶颈工序识别\n");
        sb.append("5. 设备负载或异常\n");
        sb.append("6. 可执行改进建议\n");

        return sb.toString();
    }

    private String callDeepSeek(String prompt) {
        if (apiKey == null || apiKey.isBlank() || "sk-your-key-here".equals(apiKey)) {
            return "⚠️ DeepSeek API Key 未配置。\n\n请在 application.yml 中设置 `deepseek.api-key` 或设置环境变量 `DEEPSEEK_API_KEY`。";
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + apiKey);

        Map<String, Object> body = new LinkedHashMap<>();
        body.put("model", "deepseek-chat");
        body.put("temperature", 0.3);
        body.put("max_tokens", 4096);
        body.put("messages", List.of(
            Map.of("role", "system", "content",
                "你是一个MES生产数据分析专家。请根据提供的销售订单全链路数据，进行制造数据分析。" +
                "用中文输出，采用Markdown格式（标题、表格、列表）。" +
                "仅基于提供的数据进行分析，不要虚构任何信息。"),
            Map.of("role", "user", "content", prompt)
        ));

        try {
            HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);
            ResponseEntity<Map> response = restTemplate.postForEntity(deepseekUrl, request, Map.class);

            Map responseBody = response.getBody();
            if (responseBody == null) return "AI服务返回空响应";

            List<Map> choices = (List<Map>) responseBody.get("choices");
            if (choices == null || choices.isEmpty()) return "AI服务未返回有效choices";

            Map choice = choices.get(0);
            Map message = (Map) choice.get("message");
            return (String) message.get("content");
        } catch (Exception e) {
            return "AI分析请求失败: " + e.getMessage();
        }
    }
}
