-- 生产报工表新增字段：工序信息 + 状态 + 质检
-- 执行日期: 2026-06-12

ALTER TABLE production_report
  ADD COLUMN process_seq    INT          DEFAULT NULL COMMENT '工序序号',
  ADD COLUMN process_name   VARCHAR(100) DEFAULT ''   COMMENT '工序名称',
  ADD COLUMN status         VARCHAR(20)  DEFAULT 'REPORTED' COMMENT '状态(REPORTED/INSPECTED/COMPLETED)',
  ADD COLUMN inspector      VARCHAR(100) DEFAULT NULL  COMMENT '质检人',
  ADD COLUMN quality_result VARCHAR(20)  DEFAULT NULL  COMMENT '质检结果(PASS/FAIL)',
  ADD COLUMN quality_time   DATETIME     DEFAULT NULL  COMMENT '质检时间';

-- 更新已有数据：根据 report_type 推测状态
UPDATE production_report SET status = 'REPORTED' WHERE status IS NULL;

-- 补充报工类型菜单权限（NORMAL/REPAIR）
INSERT INTO sys_menu VALUES (2610, '报工编辑', 2006, 4, '#', '', 'F', '0', '1', 'mes:report:edit', '#', 'admin', sysdate(), '', null, '');
