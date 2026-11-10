-- 质检记录表
DROP TABLE IF EXISTS mes_quality_record;
CREATE TABLE mes_quality_record (
    id              bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    work_order_id   bigint DEFAULT NULL COMMENT '工单ID',
    product_id      bigint DEFAULT NULL COMMENT '产品ID',
    check_type      varchar(50) DEFAULT NULL COMMENT '检验类型',
    quantity        int DEFAULT 0 COMMENT '检验数量',
    defect_quantity int DEFAULT 0 COMMENT '不良数量',
    result          varchar(20) DEFAULT NULL COMMENT '检验结果',
    inspector       varchar(100) DEFAULT NULL COMMENT '检验员',
    check_time      datetime DEFAULT NULL COMMENT '检验时间',
    create_by       varchar(64) DEFAULT NULL COMMENT '创建人',
    create_time     datetime DEFAULT NULL COMMENT '创建时间',
    update_by       varchar(64) DEFAULT NULL COMMENT '更新人',
    update_time     datetime DEFAULT NULL COMMENT '更新时间',
    remark          varchar(500) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (id),
    KEY idx_work_order_id (work_order_id),
    KEY idx_product_id (product_id),
    KEY idx_result (result)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='质检记录表';

-- 菜单：质检管理（父级=2011/生产管理）
INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, url, target, menu_type, visible, is_refresh, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT 2090, '质检管理', 2011, 8, '/mes/quality', '', 'C', '0', '1', 'mes:quality:view', 'fa fa-check-circle', 'admin', sysdate(), '', null, ''
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2090);

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, url, target, menu_type, visible, is_refresh, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT 2091, '质检查询', 2090, 1, '#', '', 'F', '0', '1', 'mes:quality:list', '#', 'admin', sysdate(), '', null, ''
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2091);

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, url, target, menu_type, visible, is_refresh, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT 2092, '质检新增', 2090, 2, '#', '', 'F', '0', '1', 'mes:quality:add', '#', 'admin', sysdate(), '', null, ''
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2092);

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, url, target, menu_type, visible, is_refresh, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT 2093, '质检修改', 2090, 3, '#', '', 'F', '0', '1', 'mes:quality:edit', '#', 'admin', sysdate(), '', null, ''
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2093);

INSERT INTO sys_menu (menu_id, menu_name, parent_id, order_num, url, target, menu_type, visible, is_refresh, perms, icon, create_by, create_time, update_by, update_time, remark)
SELECT 2094, '质检删除', 2090, 4, '#', '', 'F', '0', '1', 'mes:quality:remove', '#', 'admin', sysdate(), '', null, ''
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_id = 2094);
