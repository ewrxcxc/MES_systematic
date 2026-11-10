package com.ruoyi.mes.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.ruoyi.mes.service.IProductionPlanService;
import com.ruoyi.mes.vo.ProductionPlanVO;

/**
 * MES业务页面控制器
 *
 * @author mes
 */
@Controller
@RequestMapping("/mes")
public class MESPageController
{
    @Autowired
    private IProductionPlanService productionPlanService;
    /** 客户管理 */
    @GetMapping("/customer")
    public String customer() { return "mes/customer/customer"; }

    @GetMapping("/customer/add")
    public String customerAdd() { return "mes/customer/add"; }

    @GetMapping("/customer/edit/{customerId}")
    public String customerEdit(@PathVariable Long customerId, ModelMap mmap) {
        mmap.put("customerId", customerId);
        return "mes/customer/add";
    }

    /** 产品管理 */
    @GetMapping("/product")
    public String product() { return "mes/product/product"; }

    @GetMapping("/product/add")
    public String productAdd() { return "mes/product/add"; }

    @GetMapping("/product/edit/{productId}")
    public String productEdit(@PathVariable Long productId, ModelMap mmap) {
        mmap.put("productId", productId);
        return "mes/product/add";
    }

    /** BOM管理 */
    @GetMapping("/bom")
    public String bom() { return "mes/bom/bom"; }

    @GetMapping("/bom/add")
    public String bomAdd() { return "mes/bom/add"; }

    @GetMapping("/bom/edit/{bomId}")
    public String bomEdit(@PathVariable Long bomId, ModelMap mmap) {
        mmap.put("bomId", bomId);
        return "mes/bom/add";
    }

    /** 生产计划 */
    @GetMapping("/plan")
    public String plan() { return "mes/plan/plan"; }

    @GetMapping("/plan/add")
    public String planAdd() { return "mes/plan/add"; }

    @GetMapping("/plan/edit/{planId}")
    public String planEdit(@PathVariable Long planId, ModelMap mmap) {
        mmap.put("planId", planId);
        return "mes/plan/add";
    }

    @GetMapping("/plan/detail/{planId}")
    public String planDetail(@PathVariable Long planId, ModelMap mmap) {
        ProductionPlanVO plan = productionPlanService.selectProductionPlanById(planId);
        mmap.put("plan", plan);
        return "mes/plan/detail";
    }

    /** 销售订单 */
    @GetMapping("/order")
    public String order() { return "mes/order/order"; }

    @GetMapping("/order/add")
    public String orderAdd() { return "mes/order/add"; }

    @GetMapping("/order/edit/{orderId}")
    public String orderEdit(@PathVariable Long orderId, ModelMap mmap) {
        mmap.put("orderId", orderId);
        return "mes/order/add";
    }

    /** 工单管理 */
    @GetMapping("/workorder")
    public String workorder() { return "mes/workorder/workorder"; }

    @GetMapping("/workorder/add")
    public String workorderAdd() { return "mes/workorder/add"; }

    @GetMapping("/workorder/edit/{workOrderId}")
    public String workorderEdit(@PathVariable Long workOrderId, ModelMap mmap) {
        mmap.put("workOrderId", workOrderId);
        return "mes/workorder/add";
    }

    @GetMapping("/workorder/detail/{workOrderId}")
    public String workorderDetail(@PathVariable Long workOrderId, ModelMap mmap) {
        mmap.put("workOrderId", workOrderId);
        return "mes/workorder/detail";
    }

    /** 生产报工 */
    @GetMapping("/report")
    public String report() { return "mes/report/report"; }

    @GetMapping("/report/add")
    public String reportAdd() { return "mes/report/add"; }

    @GetMapping("/report/edit/{reportId}")
    public String reportEdit(@PathVariable Long reportId, ModelMap mmap) { mmap.put("reportId", reportId); return "mes/report/add"; }

    /** 库存管理 */
    @GetMapping("/inventory")
    public String inventory() { return "mes/inventory/inventory"; }

    @GetMapping("/inventory/add")
    public String inventoryAdd() { return "mes/inventory/add"; }

    /** 设备管理 */
    @GetMapping("/equipment")
    public String equipment() { return "mes/equipment/equipment"; }

    @GetMapping("/equipment/add")
    public String equipmentAdd() { return "mes/equipment/add"; }

    @GetMapping("/equipment/edit/{id}")
    public String equipmentEdit(@PathVariable Long id, ModelMap mmap) {
        mmap.put("id", id);
        return "mes/equipment/add";
    }

    /** 发货管理 */
    @GetMapping("/shipment")
    public String shipment() { return "mes/shipment/shipment"; }

    @GetMapping("/shipment/add")
    public String shipmentAdd() { return "mes/shipment/add"; }

    /** 工序设备映射 */
    @GetMapping("/mapping")
    public String mapping() { return "mes/equipment/mapping"; }

    @GetMapping("/mapping/add")
    public String mappingAdd() { return "mes/equipment/mapping_add"; }

    @GetMapping("/mapping/edit/{id}")
    public String mappingEdit(@PathVariable Long id, ModelMap mmap) {
        mmap.put("id", id);
        return "mes/equipment/mapping_add";
    }

    /** 领料管理 */
    @GetMapping("/picking")
    public String picking() { return "mes/picking/picking"; }

    @GetMapping("/picking/detail/{pickingId}")
    public String pickingDetail(@PathVariable Long pickingId, ModelMap mmap) {
        mmap.put("pickingId", pickingId);
        return "mes/picking/picking_detail";
    }

    /** 入库管理 */
    @GetMapping("/warehousing")
    public String warehousing() { return "mes/warehousing/warehousing"; }

    @GetMapping("/warehousing/add")
    public String warehousingAdd() { return "mes/warehousing/add"; }

    /** 工单拆卡 */
    @GetMapping("/workorder/split/{workOrderId}")
    public String workorderSplit(@PathVariable Long workOrderId, ModelMap mmap) {
        mmap.put("workOrderId", workOrderId);
        return "mes/workorder/split";
    }

    /** 质量追溯 */
    @GetMapping("/trace")
    public String trace() { return "mes/trace/trace"; }

    /** 工序中心 */
    @GetMapping("/process")
    public String process() { return "mes/process/process"; }

    /** 质检管理 */
    @GetMapping("/quality")
    public String quality() { return "mes/quality/quality"; }

    @GetMapping("/quality/add")
    public String qualityAdd() { return "mes/quality/quality_add"; }

    @GetMapping("/quality/edit/{recordId}")
    public String qualityEdit(@PathVariable Long recordId, ModelMap mmap) {
        mmap.put("recordId", recordId);
        return "mes/quality/quality_add";
    }

    /** 生产看板 */
    @GetMapping("/dashboard")
    public String dashboard() { return "main"; }

    /** AI分析 */
    @GetMapping("/ai/sales")
    public String aiSales() { return "mes/ai/sales"; }

    /** 工单排程 */
    @GetMapping("/schedule")
    public String schedule() { return "mes/plan/schedule"; }

    @GetMapping("/schedule/add")
    public String scheduleAdd() { return "mes/plan/schedule_add"; }

    @GetMapping("/schedule/edit/{scheduleId}")
    public String scheduleEdit(@PathVariable Long scheduleId, ModelMap mmap) {
        mmap.put("scheduleId", scheduleId);
        return "mes/plan/schedule_add";
    }
}
