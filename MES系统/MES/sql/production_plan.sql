-- =====================================================
-- MES 生产计划模块 DDL + 菜单 + 追溯字段
-- =====================================================

-- 1. 创建生产计划表
DROP TABLE IF EXISTS production_plan;
CREATE TABLE production_plan (
    plan_id          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '计划ID',
    plan_no          VARCHAR(50)  NOT NULL COMMENT '计划编号',
    sales_order_id   BIGINT       DEFAULT NULL COMMENT '销售订单ID',
    product_id       BIGINT       DEFAULT NULL COMMENT '产品ID',
    planned_qty      INT          NOT NULL COMMENT '计划数量',
    start_date       DATE         DEFAULT NULL COMMENT '计划开始日期',
    end_date         DATE         DEFAULT NULL COMMENT '计划结束日期',
    plan_status      VARCHAR(30)  DEFAULT '待排产' COMMENT '计划状态(待排产/已排产/生产中/已完成)',
    create_by        VARCHAR(64)  DEFAULT '' COMMENT '创建者',
    create_time      DATETIME     DEFAULT NULL COMMENT '创建时间',
    update_by        VARCHAR(64)  DEFAULT '' COMMENT '更新者',
    update_time      DATETIME     DEFAULT NULL COMMENT '更新时间',
    remark           VARCHAR(500) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (plan_id),
    UNIQUE KEY uk_plan_no (plan_no),
    KEY idx_sales_order_id (sales_order_id),
    KEY idx_product_id (product_id),
    KEY idx_plan_status (plan_status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='生产计划表';

-- 2. 工单表增加 plan_id 追溯字段
ALTER TABLE work_order ADD COLUMN plan_id BIGINT DEFAULT NULL COMMENT '生产计划ID' AFTER order_id;
ALTER TABLE work_order ADD INDEX idx_plan_id (plan_id);

-- 3. 生产报工表增加 plan_id 追溯字段
ALTER TABLE production_report ADD COLUMN plan_id BIGINT DEFAULT NULL COMMENT '生产计划ID' AFTER work_order_id;
ALTER TABLE production_report ADD INDEX idx_pr_plan_id (plan_id);

-- 4. 发货记录表增加 plan_id 追溯字段
ALTER TABLE shipment_record ADD COLUMN plan_id BIGINT DEFAULT NULL COMMENT '生产计划ID' AFTER order_id;
ALTER TABLE shipment_record ADD INDEX idx_sr_plan_id (plan_id);

-- 5. 库存表增加 work_order_id 追溯字段
ALTER TABLE inventory ADD COLUMN work_order_id BIGINT DEFAULT NULL COMMENT '关联工单ID' AFTER inventory_type;
ALTER TABLE inventory ADD INDEX idx_inv_wo_id (work_order_id);

-- =====================================================
-- 菜单: 生产管理下增加"生产计划"，调整工单中心顺序
-- =====================================================

-- 先删除旧的工序任务菜单(2055)，将其合并到工单中心
DELETE FROM sys_menu WHERE menu_id = 2055;
DELETE FROM sys_menu WHERE menu_id IN (SELECT tmp.menu_id FROM (SELECT menu_id FROM sys_menu WHERE parent_id = 2055) tmp);

-- 生产计划菜单
INSERT INTO sys_menu VALUES (2012, '生产计划', 2011, 1, '/mes/plan', '', 'C', '0', '1', 'mes:plan:view', 'fa fa-calendar-check-o', 'admin', sysdate(), '', NULL, '生产计划菜单');
-- 工单中心移到生产计划后面
UPDATE sys_menu SET order_num = 2 WHERE menu_id = 2005;
-- 生产报工顺延
UPDATE sys_menu SET order_num = 3 WHERE menu_id = 2006;

-- 生产计划功能按钮权限
INSERT INTO sys_menu VALUES (2120, '计划查询', 2012, 1, '#', '', 'F', '0', '1', 'mes:plan:list', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES (2121, '计划新增', 2012, 2, '#', '', 'F', '0', '1', 'mes:plan:add', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES (2122, '计划修改', 2012, 3, '#', '', 'F', '0', '1', 'mes:plan:edit', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES (2123, '计划删除', 2012, 4, '#', '', 'F', '0', '1', 'mes:plan:remove', '#', 'admin', sysdate(), '', NULL, '');
INSERT INTO sys_menu VALUES (2124, '计划导出', 2012, 5, '#', '', 'F', '0', '1', 'mes:plan:export', '#', 'admin', sysdate(), '', NULL, '');

-- 客户管理增加查询/新增按钮权限（若缺失）
INSERT IGNORE INTO sys_menu VALUES (2100, '客户查询', 2001, 1, '#', '', 'F', '0', '1', 'mes:customer:list', '#', 'admin', sysdate(), '', NULL, '');
INSERT IGNORE INTO sys_menu VALUES (2101, '客户新增', 2001, 2, '#', '', 'F', '0', '1', 'mes:customer:add', '#', 'admin', sysdate(), '', NULL, '');
