-- ============================================
-- MES系统新模块数据库建表脚本
-- 包含：工序设备映射、领料管理、入库管理、拆卡、追溯
-- ============================================

-- 1. 产线表
DROP TABLE IF EXISTS mes_production_line;
CREATE TABLE mes_production_line (
    line_id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '产线ID',
    line_code VARCHAR(50) NOT NULL COMMENT '产线编码',
    line_name VARCHAR(100) NOT NULL COMMENT '产线名称',
    description VARCHAR(500) COMMENT '描述',
    status VARCHAR(20) DEFAULT 'ACTIVE' COMMENT '状态',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME DEFAULT sysdate() COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME DEFAULT sysdate() COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT '' COMMENT '备注'
) COMMENT='产线表';

-- 2. 工序设备映射表
DROP TABLE IF EXISTS mes_process_equipment_mapping;
CREATE TABLE mes_process_equipment_mapping (
    id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '映射ID',
    process_code VARCHAR(50) NOT NULL COMMENT '工序编码',
    process_name VARCHAR(100) NOT NULL COMMENT '工序名称',
    process_seq INT NOT NULL COMMENT '工序序号',
    equipment_id BIGINT NOT NULL COMMENT '设备ID',
    equipment_code VARCHAR(50) COMMENT '设备编码',
    equipment_name VARCHAR(100) COMMENT '设备名称',
    line_id BIGINT COMMENT '产线ID',
    api_url VARCHAR(200) COMMENT '设备API地址',
    api_type VARCHAR(50) COMMENT 'API类型(REST/MQTT/OPC)',
    status VARCHAR(20) DEFAULT 'ACTIVE' COMMENT '状态',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME DEFAULT sysdate() COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME DEFAULT sysdate() COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT '' COMMENT '备注'
) COMMENT='工序设备映射表';

-- 3. 领料单主表
DROP TABLE IF EXISTS mes_material_picking;
CREATE TABLE mes_material_picking (
    picking_id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '领料单ID',
    picking_no VARCHAR(50) NOT NULL COMMENT '领料单号',
    work_order_id BIGINT NOT NULL COMMENT '工单ID',
    work_order_no VARCHAR(50) COMMENT '工单编号',
    plan_id BIGINT COMMENT '计划ID',
    picking_status VARCHAR(20) DEFAULT 'WAITING' COMMENT '状态(WAITING-待领料/PICKING-领料中/FINISHED-已完成)',
    picking_by VARCHAR(64) COMMENT '领料人',
    picking_time DATETIME COMMENT '领料时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME DEFAULT sysdate() COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME DEFAULT sysdate() COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT '' COMMENT '备注'
) COMMENT='领料单主表';

-- 4. 领料单明细表
DROP TABLE IF EXISTS mes_material_picking_detail;
CREATE TABLE mes_material_picking_detail (
    detail_id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '明细ID',
    picking_id BIGINT NOT NULL COMMENT '领料单ID',
    material_code VARCHAR(50) NOT NULL COMMENT '物料编码',
    material_name VARCHAR(100) NOT NULL COMMENT '物料名称',
    bom_usage DECIMAL(10,4) DEFAULT 0 COMMENT 'BOM单件用量',
    required_qty DECIMAL(10,2) NOT NULL COMMENT '需求数量',
    actual_qty DECIMAL(10,2) DEFAULT 0 COMMENT '实发数量',
    unit VARCHAR(20) COMMENT '单位',
    inventory_id BIGINT COMMENT '库存记录ID(扣减用)',
    status VARCHAR(20) DEFAULT 'WAITING' COMMENT '状态'
) COMMENT='领料单明细表';

-- 5. 入库单主表
DROP TABLE IF EXISTS mes_warehousing;
CREATE TABLE mes_warehousing (
    warehousing_id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '入库单ID',
    warehousing_no VARCHAR(50) NOT NULL COMMENT '入库单号',
    work_order_id BIGINT NOT NULL COMMENT '工单ID',
    work_order_no VARCHAR(50) COMMENT '工单编号',
    plan_id BIGINT COMMENT '计划ID',
    product_id BIGINT COMMENT '产品ID',
    warehousing_type VARCHAR(20) DEFAULT 'FINISHED' COMMENT '入库类型(FINISHED-成品入库/SEMI-半成品入库)',
    warehousing_status VARCHAR(20) DEFAULT 'WAITING' COMMENT '状态(WAITING-待入库/CHECKING-质检中/FINISHED-已入库)',
    inspector VARCHAR(64) COMMENT '质检人',
    inspect_result VARCHAR(20) COMMENT '质检结果(PASS/FAIL)',
    warehousing_by VARCHAR(64) COMMENT '入库经手人',
    warehousing_time DATETIME COMMENT '入库时间',
    location VARCHAR(100) COMMENT '库位',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME DEFAULT sysdate() COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME DEFAULT sysdate() COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT '' COMMENT '备注'
) COMMENT='入库单主表';

-- 6. 入库单明细表
DROP TABLE IF EXISTS mes_warehousing_detail;
CREATE TABLE mes_warehousing_detail (
    detail_id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '明细ID',
    warehousing_id BIGINT NOT NULL COMMENT '入库单ID',
    product_code VARCHAR(50) COMMENT '产品编码',
    product_name VARCHAR(100) COMMENT '产品名称',
    quantity DECIMAL(10,2) NOT NULL COMMENT '入库数量',
    unit VARCHAR(20) COMMENT '单位',
    batch_no VARCHAR(50) COMMENT '批次号',
    location VARCHAR(100) COMMENT '库位',
    inspect_result VARCHAR(20) COMMENT '质检结果'
) COMMENT='入库单明细表';

-- 7. 工单拆卡表
DROP TABLE IF EXISTS mes_work_order_split;
CREATE TABLE mes_work_order_split (
    split_id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '拆卡ID',
    parent_work_order_id BIGINT NOT NULL COMMENT '父工单ID',
    work_order_id BIGINT COMMENT '子工单ID(拆分后生成的工单)',
    split_no VARCHAR(50) COMMENT '子工单号',
    line_id BIGINT COMMENT '分配产线ID',
    line_name VARCHAR(100) COMMENT '分配产线',
    team_name VARCHAR(100) COMMENT '分配班组',
    split_qty INT NOT NULL COMMENT '拆分数量',
    completed_qty INT DEFAULT 0 COMMENT '完成数量',
    status VARCHAR(20) DEFAULT 'WAITING' COMMENT '状态',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME DEFAULT sysdate() COMMENT '创建时间',
    update_by VARCHAR(64) DEFAULT '' COMMENT '更新者',
    update_time DATETIME DEFAULT sysdate() COMMENT '更新时间',
    remark VARCHAR(500) DEFAULT '' COMMENT '备注'
) COMMENT='工单拆卡表';

-- 8. 批次信息表
DROP TABLE IF EXISTS mes_batch_info;
CREATE TABLE mes_batch_info (
    batch_id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '批次ID',
    batch_no VARCHAR(50) NOT NULL COMMENT '批次号',
    material_code VARCHAR(50) COMMENT '物料编码',
    material_name VARCHAR(100) COMMENT '物料名称',
    material_type VARCHAR(20) COMMENT '类型(RAW-原材料/SEMI-半成品/FINISHED-成品)',
    supplier_id BIGINT COMMENT '供应商ID',
    supplier_name VARCHAR(100) COMMENT '供应商名称',
    quantity DECIMAL(10,2) COMMENT '数量',
    unit VARCHAR(20) COMMENT '单位',
    produce_date DATE COMMENT '生产日期',
    receive_date DATE COMMENT '入库日期',
    status VARCHAR(20) DEFAULT 'ACTIVE' COMMENT '状态',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME DEFAULT sysdate() COMMENT '创建时间',
    remark VARCHAR(500) DEFAULT '' COMMENT '备注'
) COMMENT='批次信息表';

-- 9. 缺陷记录表
DROP TABLE IF EXISTS mes_defect_record;
CREATE TABLE mes_defect_record (
    defect_id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '缺陷ID',
    defect_code VARCHAR(50) COMMENT '缺陷代码',
    defect_type VARCHAR(50) COMMENT '缺陷类型(外观/尺寸/功能/其他)',
    defect_desc VARCHAR(200) COMMENT '缺陷描述',
    work_order_id BIGINT COMMENT '工单ID',
    process_task_id BIGINT COMMENT '工序任务ID',
    batch_no VARCHAR(50) COMMENT '关联批次号',
    defect_qty INT DEFAULT 1 COMMENT '缺陷数量',
    severity VARCHAR(20) COMMENT '严重程度(MINOR/MAJOR/CRITICAL)',
    handler VARCHAR(64) COMMENT '处理人',
    handle_result VARCHAR(50) COMMENT '处理结果(返工/报废/让步接收)',
    discover_time DATETIME COMMENT '发现时间',
    handle_time DATETIME COMMENT '处理时间',
    create_by VARCHAR(64) DEFAULT '' COMMENT '创建者',
    create_time DATETIME DEFAULT sysdate() COMMENT '创建时间',
    remark VARCHAR(500) DEFAULT '' COMMENT '备注'
) COMMENT='缺陷记录表';

-- 10. 质量追溯表
DROP TABLE IF EXISTS mes_quality_trace;
CREATE TABLE mes_quality_trace (
    trace_id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '追溯ID',
    trace_type VARCHAR(20) NOT NULL COMMENT '追溯类型(PRODUCT-产品/ORDER-订单/WORK_ORDER-工单/BATCH-批次)',
    trace_key VARCHAR(100) NOT NULL COMMENT '追溯关键字',
    product_id BIGINT COMMENT '产品ID',
    product_code VARCHAR(50) COMMENT '产品编码',
    plan_id BIGINT COMMENT '生产计划ID',
    plan_no VARCHAR(50) COMMENT '计划编号',
    order_id BIGINT COMMENT '销售订单ID',
    order_no VARCHAR(50) COMMENT '销售订单号',
    work_order_id BIGINT COMMENT '工单ID',
    work_order_no VARCHAR(50) COMMENT '工单编号',
    batch_no VARCHAR(50) COMMENT '关联批次号',
    raw_batch_no VARCHAR(50) COMMENT '原材料批次号',
    production_date DATE COMMENT '生产日期',
    inspector VARCHAR(64) COMMENT '检验人',
    inspect_result VARCHAR(20) COMMENT '检验结果',
    trace_data JSON COMMENT '追溯详细数据(JSON)',
    create_time DATETIME DEFAULT sysdate() COMMENT '创建时间',
    remark VARCHAR(500) DEFAULT '' COMMENT '备注'
) COMMENT='质量追溯表';

-- ============================================
-- 初始测试数据
-- ============================================

-- 产线数据
INSERT INTO mes_production_line (line_code, line_name, description) VALUES
('L-01', '注塑产线#1', 'ABS/PC注塑成型产线'),
('L-02', '注塑产线#2', '精密注塑产线'),
('L-03', '五金加工产线', '弹簧绕制/CNC加工产线'),
('L-04', '硅胶成型产线', '硅胶硫化成型产线'),
('L-05', '组装产线#1', '自动组装主线'),
('L-06', '组装产线#2', '半自动组装副线'),
('L-07', '包装产线', '自动包装产线');

-- 工序设备映射数据（7道工序 × 对应设备）
INSERT INTO mes_process_equipment_mapping (process_code, process_name, process_seq, equipment_id, equipment_code, equipment_name, line_id, api_url, api_type, status) VALUES
-- 1. 原材料领料 (没有特定设备，标记为仓库)
('P01', '原材料领料', 1, 1, 'E-INJ-01', '注塑机#1', 1, '/api/mes/equipment/inj01/status', 'REST', 'ACTIVE'),
-- 2. CNC加工
('P02', 'CNC加工', 2, 6, 'E-CNC-01', 'CNC加工中心', 3, '/api/mes/equipment/cnc01/status', 'REST', 'ACTIVE'),
-- 3. 打磨处理
('P03', '打磨处理', 3, 6, 'E-CNC-01', 'CNC加工中心', 3, '/api/mes/equipment/cnc01/status', 'REST', 'ACTIVE'),
-- 4. 喷砂/氧化
('P04', '喷砂/氧化', 4, 5, 'E-SILICINE-01', '硅胶硫化成型机', 4, '/api/mes/equipment/silicone01/status', 'REST', 'ACTIVE'),
-- 5. 组装
('P05', '组装', 5, 7, 'E-ASM-01', '自动组装线#1', 5, '/api/mes/equipment/asm01/status', 'REST', 'ACTIVE'),
('P05-2', '组装', 5, 8, 'E-ASM-02', '自动组装线#2', 6, '/api/mes/equipment/asm02/status', 'REST', 'ACTIVE'),
-- 6. 功能检测
('P06', '功能检测', 6, 10, 'E-INSP-01', '视觉检测设备', 5, '/api/mes/equipment/insp01/status', 'REST', 'ACTIVE'),
-- 7. 包装入库
('P07', '包装入库', 7, 9, 'E-PACK-01', '自动包装线', 7, '/api/mes/equipment/pack01/status', 'REST', 'ACTIVE');
