-- 补充和修复测试数据

-- 1. 确保 product 表有数据（使用 INSERT IGNORE 防止重复）
INSERT IGNORE INTO `product` (`product_code`, `product_name`, `product_model`, `specification`, `unit`, `create_by`, `create_time`) VALUES
('PRD-001', '手机支架标准版', 'STD-V1', '标准版', '个', 'admin', NOW()),
('PRD-002', '手机支架Pro版', 'PRO-V1', 'Pro版', '个', 'admin', NOW()),
('PRD-003', '金属外壳A型', 'MET-A', '工业版', '套', 'admin', NOW()),
('PRD-004', '数据线Type-C', 'USB-C', '标准版', '件', 'admin', NOW()),
('PRD-005', '充电头30W', 'CHR-30', '标准版', '台', 'admin', NOW());

-- 2. 确保 equipment 表有数据（使用 status 列，值为 IDLE/RUNNING/MAINTENANCE/OFFLINE）
INSERT IGNORE INTO `equipment` (`equipment_code`, `equipment_name`, `status`, `create_by`, `create_time`) VALUES
('EQ-001', '原料仓储系统', 'IDLE', 'admin', NOW()),
('EQ-002', 'CNC加工中心', 'IDLE', 'admin', NOW()),
('EQ-003', '自动打磨机', 'IDLE', 'admin', NOW()),
('EQ-004', '喷砂氧化线', 'IDLE', 'admin', NOW()),
('EQ-005', '自动组装机', 'IDLE', 'admin', NOW()),
('EQ-006', 'AOI检测设备', 'IDLE', 'admin', NOW()),
('EQ-007', '自动包装机', 'IDLE', 'admin', NOW());

-- 3. 确保 process_equipment_mapping 有数据（7个标准工序映射）
INSERT IGNORE INTO `process_equipment_mapping` (`process_code`, `process_name`, `process_seq`, `equipment_id`, `equipment_code`, `equipment_name`, `api_url`, `api_type`, `status`, `create_by`, `create_time`)
SELECT 'PROC-01', '原材料领料', 1, e.equipment_id, 'EQ-001', '原料仓储系统', '/api/mes/inventory/outbound', 'REST', 'ACTIVE', 'admin', NOW()
FROM equipment e WHERE e.equipment_code = 'EQ-001' LIMIT 1;

INSERT IGNORE INTO `process_equipment_mapping` (`process_code`, `process_name`, `process_seq`, `equipment_id`, `equipment_code`, `equipment_name`, `api_url`, `api_type`, `status`, `create_by`, `create_time`)
SELECT 'PROC-02', 'CNC加工', 2, e.equipment_id, 'EQ-002', 'CNC加工中心', '/api/mes/process/start', 'REST', 'ACTIVE', 'admin', NOW()
FROM equipment e WHERE e.equipment_code = 'EQ-002' LIMIT 1;

INSERT IGNORE INTO `process_equipment_mapping` (`process_code`, `process_name`, `process_seq`, `equipment_id`, `equipment_code`, `equipment_name`, `api_url`, `api_type`, `status`, `create_by`, `create_time`)
SELECT 'PROC-03', '打磨处理', 3, e.equipment_id, 'EQ-003', '自动打磨机', '/api/mes/process/finish', 'REST', 'ACTIVE', 'admin', NOW()
FROM equipment e WHERE e.equipment_code = 'EQ-003' LIMIT 1;

INSERT IGNORE INTO `process_equipment_mapping` (`process_code`, `process_name`, `process_seq`, `equipment_id`, `equipment_code`, `equipment_name`, `api_url`, `api_type`, `status`, `create_by`, `create_time`)
SELECT 'PROC-04', '喷砂氧化', 4, e.equipment_id, 'EQ-004', '喷砂氧化线', '/api/mes/process/start', 'REST', 'ACTIVE', 'admin', NOW()
FROM equipment e WHERE e.equipment_code = 'EQ-004' LIMIT 1;

INSERT IGNORE INTO `process_equipment_mapping` (`process_code`, `process_name`, `process_seq`, `equipment_id`, `equipment_code`, `equipment_name`, `api_url`, `api_type`, `status`, `create_by`, `create_time`)
SELECT 'PROC-05', '组装', 5, e.equipment_id, 'EQ-005', '自动组装机', '/api/mes/process/finish', 'REST', 'ACTIVE', 'admin', NOW()
FROM equipment e WHERE e.equipment_code = 'EQ-005' LIMIT 1;

INSERT IGNORE INTO `process_equipment_mapping` (`process_code`, `process_name`, `process_seq`, `equipment_id`, `equipment_code`, `equipment_name`, `api_url`, `api_type`, `status`, `create_by`, `create_time`)
SELECT 'PROC-06', '功能检测', 6, e.equipment_id, 'EQ-006', 'AOI检测设备', '/api/mes/quality/check', 'REST', 'ACTIVE', 'admin', NOW()
FROM equipment e WHERE e.equipment_code = 'EQ-006' LIMIT 1;

INSERT IGNORE INTO `process_equipment_mapping` (`process_code`, `process_name`, `process_seq`, `equipment_id`, `equipment_code`, `equipment_name`, `api_url`, `api_type`, `status`, `create_by`, `create_time`)
SELECT 'PROC-07', '包装入库', 7, e.equipment_id, 'EQ-007', '自动包装机', '/api/mes/inventory/finishedInbound', 'REST', 'ACTIVE', 'admin', NOW()
FROM equipment e WHERE e.equipment_code = 'EQ-007' LIMIT 1;
