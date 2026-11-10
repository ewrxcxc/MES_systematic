-- 修正版数据填充脚本

-- 1. 工序设备映射数据（使用正确的表名 mes_process_equipment_mapping）
-- 先清除旧数据
DELETE FROM mes_process_equipment_mapping;

INSERT INTO mes_process_equipment_mapping (process_code, process_name, process_seq, equipment_id, equipment_code, equipment_name, api_url, api_type, status, create_by, create_time) VALUES
('PROC-001', '原材料领料', 10, 1, 'E-INJ-01', '注塑机#1', '/api/mes/inventory/outbound', 'REST', 'ACTIVE', 'admin', NOW()),
('PROC-002', 'CNC加工', 20, 6, 'E-CNC-01', 'CNC加工中心', '/api/mes/process/start', 'REST', 'ACTIVE', 'admin', NOW()),
('PROC-003', '打磨处理', 30, 6, 'E-CNC-01', 'CNC加工中心', '/api/mes/process/finish', 'REST', 'ACTIVE', 'admin', NOW()),
('PROC-004', '喷砂氧化', 40, 5, 'E-SILICINE-01', '硅胶硫化成型机', '/api/mes/process/start', 'REST', 'ACTIVE', 'admin', NOW()),
('PROC-005', '组装', 50, 7, 'E-ASM-01', '自动组装线#1', '/api/mes/process/finish', 'REST', 'ACTIVE', 'admin', NOW()),
('PROC-006', '功能检测', 60, 10, 'E-INSP-01', '视觉检测设备', '/api/mes/quality/check', 'REST', 'ACTIVE', 'admin', NOW()),
('PROC-007', '包装入库', 70, 9, 'E-PACK-01', '自动包装线', '/api/mes/inventory/finishedInbound', 'REST', 'ACTIVE', 'admin', NOW());

-- 2. 排程数据（使用实际存在的工单ID）
DELETE FROM schedule;

INSERT INTO schedule (schedule_no, work_order_id, product_id, planned_start, planned_end, priority, status, create_by, create_time)
SELECT 'SCH-20260609-001', w.work_order_id, o.product_id, '2026-06-09 08:00:00', '2026-06-09 18:00:00', 1, 'FINISHED', 'admin', NOW()
FROM work_order w LEFT JOIN sales_order o ON o.order_id = w.order_id
WHERE w.work_order_id = 33 LIMIT 1;

INSERT INTO schedule (schedule_no, work_order_id, product_id, planned_start, planned_end, priority, status, create_by, create_time)
SELECT 'SCH-20260609-002', w.work_order_id, o.product_id, '2026-06-09 08:00:00', '2026-06-09 18:00:00', 2, 'RUNNING', 'admin', NOW()
FROM work_order w LEFT JOIN sales_order o ON o.order_id = w.order_id
WHERE w.work_order_id = 31 LIMIT 1;

INSERT INTO schedule (schedule_no, work_order_id, product_id, planned_start, planned_end, priority, status, create_by, create_time)
SELECT 'SCH-20260609-003', w.work_order_id, o.product_id, '2026-06-10 08:00:00', '2026-06-10 18:00:00', 3, 'PENDING', 'admin', NOW()
FROM work_order w LEFT JOIN sales_order o ON o.order_id = w.order_id
WHERE w.work_order_id = 32 LIMIT 1;

-- 3. 确保 product 表有至少5条，使用 INSERT IGNORE
INSERT IGNORE INTO product (product_code, product_name, product_model, specification, unit, create_by, create_time) VALUES
('PRD-001', '手机支架标准版', 'STD-V1', '标准版', '个', 'admin', NOW()),
('PRD-002', '手机支架Pro版', 'PRO-V1', 'Pro版', '个', 'admin', NOW()),
('PRD-003', '金属外壳A型', 'MET-A', '工业版', '套', 'admin', NOW()),
('PRD-004', '数据线Type-C', 'USB-C', '标准版', '件', 'admin', NOW()),
('PRD-005', '充电头30W', 'CHR-30', '标准版', '台', 'admin', NOW());
