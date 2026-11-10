package com.ruoyi.mes.vo;

import java.util.List;
import com.ruoyi.mes.domain.SalesOrder;
import com.ruoyi.mes.domain.ProductionPlan;
import com.ruoyi.mes.domain.WorkOrder;
import com.ruoyi.mes.domain.ProcessTask;
import com.ruoyi.mes.domain.ProductionReport;
import com.ruoyi.mes.domain.QualityTrace;
import com.ruoyi.mes.domain.Warehousing;
import com.ruoyi.mes.domain.ShipmentRecord;

public class OrderChainVO
{
    private SalesOrder order;
    private ProductionPlan plan;
    private List<WorkOrder> workOrders;
    private List<ProcessTask> tasks;
    private List<ProductionReport> reports;
    private List<QualityTrace> traces;
    private List<Warehousing> warehousings;
    private ShipmentRecord shipment;

    public SalesOrder getOrder() { return order; }
    public void setOrder(SalesOrder v) { this.order = v; }
    public ProductionPlan getPlan() { return plan; }
    public void setPlan(ProductionPlan v) { this.plan = v; }
    public List<WorkOrder> getWorkOrders() { return workOrders; }
    public void setWorkOrders(List<WorkOrder> v) { this.workOrders = v; }
    public List<ProcessTask> getTasks() { return tasks; }
    public void setTasks(List<ProcessTask> v) { this.tasks = v; }
    public List<ProductionReport> getReports() { return reports; }
    public void setReports(List<ProductionReport> v) { this.reports = v; }
    public List<QualityTrace> getTraces() { return traces; }
    public void setTraces(List<QualityTrace> v) { this.traces = v; }
    public List<Warehousing> getWarehousings() { return warehousings; }
    public void setWarehousings(List<Warehousing> v) { this.warehousings = v; }
    public ShipmentRecord getShipment() { return shipment; }
    public void setShipment(ShipmentRecord v) { this.shipment = v; }
}
