-- 添加工单排程菜单 (如果不存在)
INSERT INTO `sys_menu` (`menu_name`, `parent_id`, `order_num`, `url`, `target`, `menu_type`, `visible`, `is_refresh`, `perms`, `icon`, `create_by`, `create_time`)
SELECT '工单排程', menu_id, 5, '/mes/schedule', 'menuItem', 'C', '0', '1', 'mes:schedule:view', 'fa fa-calendar', 'admin', NOW()
FROM sys_menu WHERE menu_name = '生产管理' AND parent_id = 0
AND NOT EXISTS (SELECT 1 FROM sys_menu WHERE menu_name = '工单排程' AND url = '/mes/schedule');

-- Add permission entries
INSERT INTO sys_menu (menu_name, parent_id, order_num, url, menu_type, visible, perms, create_by, create_time)
SELECT '工单排程查询', m.menu_id, 1, '#', 'F', '0', 'mes:schedule:list', 'admin', NOW()
FROM sys_menu m WHERE m.menu_name = '工单排程' AND m.url = '/mes/schedule'
AND NOT EXISTS (SELECT 1 FROM sys_menu WHERE perms = 'mes:schedule:list');

INSERT INTO sys_menu (menu_name, parent_id, order_num, url, menu_type, visible, perms, create_by, create_time)
SELECT '工单排程新增', m.menu_id, 2, '#', 'F', '0', 'mes:schedule:add', 'admin', NOW()
FROM sys_menu m WHERE m.menu_name = '工单排程' AND m.url = '/mes/schedule'
AND NOT EXISTS (SELECT 1 FROM sys_menu WHERE perms = 'mes:schedule:add');

INSERT INTO sys_menu (menu_name, parent_id, order_num, url, menu_type, visible, perms, create_by, create_time)
SELECT '工单排程修改', m.menu_id, 3, '#', 'F', '0', 'mes:schedule:edit', 'admin', NOW()
FROM sys_menu m WHERE m.menu_name = '工单排程' AND m.url = '/mes/schedule'
AND NOT EXISTS (SELECT 1 FROM sys_menu WHERE perms = 'mes:schedule:edit');

INSERT INTO sys_menu (menu_name, parent_id, order_num, url, menu_type, visible, perms, create_by, create_time)
SELECT '工单排程删除', m.menu_id, 4, '#', 'F', '0', 'mes:schedule:remove', 'admin', NOW()
FROM sys_menu m WHERE m.menu_name = '工单排程' AND m.url = '/mes/schedule'
AND NOT EXISTS (SELECT 1 FROM sys_menu WHERE perms = 'mes:schedule:remove');
