-- 工序-产线-API映射管理 改版
-- 执行日期: 2026-06-12

ALTER TABLE mes_process_equipment_mapping
  ADD COLUMN work_center   VARCHAR(100) DEFAULT '' COMMENT '工作中心',
  ADD COLUMN line_action   VARCHAR(100) DEFAULT '' COMMENT '产线动作',
  ADD COLUMN api_command   VARCHAR(100) DEFAULT '' COMMENT 'API命令',
  ADD COLUMN response_time BIGINT       DEFAULT NULL COMMENT '响应时间(ms)',
  ADD COLUMN last_call_time DATETIME    DEFAULT NULL COMMENT '最后调用时间';

-- 清空旧数据，插入新的工序-产线-API映射
DELETE FROM mes_process_equipment_mapping;

INSERT INTO mes_process_equipment_mapping
(process_code, process_name, process_seq, equipment_id, equipment_code, equipment_name, work_center, line_action, api_command, api_url, api_type, status, create_by, create_time, remark)
VALUES
('PROC-001', '原材料领料', 10, 1, 'EQ-IM-01', '注塑机1',   '注塑车间',   '启动初始化',     'start',          'http://localhost:5000/WeatherForecast/command?commandname=start',          'REST', 'ACTIVE', 'admin', sysdate(), ''),
('PROC-002', 'CNC加工',    20, 2, 'EQ-CNC-01','CNC机床',   'CNC加工中心','启动传送带',     'sendstart',      'http://localhost:5000/WeatherForecast/command?commandname=sendstart',      'REST', 'ACTIVE', 'admin', sysdate(), ''),
('PROC-003', '打磨处理',   30, 3, 'EQ-PL-01', '打磨设备',  '打磨工位',   '停止传送带',     'sendstop',       'http://localhost:5000/WeatherForecast/command?commandname=sendstop',       'REST', 'ACTIVE', 'admin', sysdate(), ''),
('PROC-004', '喷砂氧化',   40, 4, 'EQ-SB-01', '喷砂设备',  '表面处理区', '抓取盒子到平台', 'startgrab',      'http://localhost:5000/WeatherForecast/command?commandname=startgrab',      'REST', 'ACTIVE', 'admin', sysdate(), ''),
('PROC-005', '组装',       50, 5, 'EQ-AS-01', '装配线',    '装配车间',   '抓取盒子到传送带','startgrabBack',  'http://localhost:5000/WeatherForecast/command?commandname=startgrabBack',  'REST', 'ACTIVE', 'admin', sysdate(), ''),
('PROC-006', '功能检测',   60, 6, 'EQ-QC-01', '检测设备',  '质检区',     '开始打螺丝',     'startcrue',      'http://localhost:5000/WeatherForecast/command?commandname=startcrue',      'REST', 'ACTIVE', 'admin', sysdate(), ''),
('PROC-007', '包装入库',   70, 7, 'EQ-PK-01', '包装设备',  '包装车间',   '开始激光打标',   'startlay',       'http://localhost:5000/WeatherForecast/command?commandname=startlay',       'REST', 'ACTIVE', 'admin', sysdate(), '');

-- 更新菜单名称
UPDATE sys_menu SET menu_name = '工序-产线-API映射' WHERE menu_id = 2035;
