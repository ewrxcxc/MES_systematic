-- 删除不需要的 RuoYi 系统菜单
DELETE FROM sys_menu WHERE menu_id IN (2, 3, 4);
DELETE FROM sys_menu WHERE parent_id IN (2, 3, 4);

-- 删除部门管理(103)、岗位管理(104)、字典管理(105)、参数设置(106)、通知公告(107)、日志管理(108)
DELETE FROM sys_menu WHERE menu_id IN (103, 104, 105, 106, 107, 108);
DELETE FROM sys_menu WHERE parent_id IN (103, 104, 105, 106, 107, 108);

-- 删除系统监控(109)、系统工具(110)、代码生成(115)、定时任务(116)
DELETE FROM sys_menu WHERE menu_id IN (109, 110, 115, 116);
DELETE FROM sys_menu WHERE parent_id IN (109, 110, 115, 116);

-- 删除 RuoYi 官网菜单(4和子菜单)
DELETE FROM sys_menu WHERE parent_id = 4;

-- 重建 MES 顶层菜单结构 (先删除旧的 MES 管理菜单)
DELETE FROM sys_menu WHERE menu_id = 2000;
-- 注：不删除 parent_id=2000 的子菜单，保留客户管理等基础数据模块

-- 重新排序系统管理(1)的显示
UPDATE sys_menu SET menu_name = '系统设置', order_num = 1, icon = 'fa fa-gear' WHERE menu_id = 1;

-- 确保系统用户管理(100)和角色管理(101)正常
UPDATE sys_menu SET menu_name = '用户管理', icon = 'fa fa-user' WHERE menu_id = 100;
UPDATE sys_menu SET menu_name = '角色权限', icon = 'fa fa-users' WHERE menu_id = 101;

-- 重建 MES 菜单
INSERT INTO sys_menu VALUES (1,   '系统设置', 0, 1, '#', '', 'M', '0', '1', '', 'fa fa-gear', 'admin', sysdate(), '', null, '系统设置目录');

-- MES工作台(目录)
INSERT INTO sys_menu VALUES (2000, 'MES工作台', 0, 2, '#', '', 'M', '0', '1', '', 'fa fa-industry', 'admin', sysdate(), '', null, 'MES工作台目录');

-- 生产管理(目录)
INSERT INTO sys_menu VALUES (2011, '生产管理', 0, 3, '#', '', 'M', '0', '1', '', 'fa fa-cogs', 'admin', sysdate(), '', null, '生产管理目录');
INSERT INTO sys_menu VALUES (2004, '销售订单', 2011, 1, '/mes/order', '', 'C', '0', '1', 'mes:order:view', 'fa fa-file-text', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2005, '工单中心', 2011, 2, '/mes/workorder', '', 'C', '0', '1', 'mes:workorder:view', 'fa fa-tasks', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2055, '工序任务', 2011, 3, '/mes/workorder', '', 'C', '0', '1', 'mes:process:view', 'fa fa-list-ol', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2006, '生产报工', 2011, 4, '/mes/report', '', 'C', '0', '1', 'mes:report:view', 'fa fa-clipboard-check', 'admin', sysdate(), '', null, '');

-- 物料管理(目录)
INSERT INTO sys_menu VALUES (2022, '物料管理', 0, 4, '#', '', 'M', '0', '1', '', 'fa fa-cubes', 'admin', sysdate(), '', null, '物料管理目录');
INSERT INTO sys_menu VALUES (2002, '产品管理', 2022, 1, '/mes/product', '', 'C', '0', '1', 'mes:product:view', 'fa fa-cube', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2003, 'BOM管理', 2022, 2, '/mes/bom', '', 'C', '0', '1', 'mes:bom:view', 'fa fa-list-alt', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2007, '库存管理', 2022, 3, '/mes/inventory', '', 'C', '0', '1', 'mes:inventory:view', 'fa fa-warehouse', 'admin', sysdate(), '', null, '');

-- 设备管理(目录)
INSERT INTO sys_menu VALUES (2033, '设备管理', 0, 5, '#', '', 'M', '0', '1', '', 'fa fa-microchip', 'admin', sysdate(), '', null, '设备管理目录');
INSERT INTO sys_menu VALUES (2008, '设备监控', 2033, 1, '/mes/equipment', '', 'C', '0', '1', 'mes:equipment:view', 'fa fa-desktop', 'admin', sysdate(), '', null, '');

-- 物流管理(目录)
INSERT INTO sys_menu VALUES (2043, '物流管理', 0, 6, '#', '', 'M', '0', '1', '', 'fa fa-truck', 'admin', sysdate(), '', null, '物流管理目录');
INSERT INTO sys_menu VALUES (2009, '发货管理', 2043, 1, '/mes/shipment', '', 'C', '0', '1', 'mes:shipment:view', 'fa fa-send', 'admin', sysdate(), '', null, '');

-- 数据分析(目录)
INSERT INTO sys_menu VALUES (2053, '数据分析', 0, 7, '#', '', 'M', '0', '1', '', 'fa fa-bar-chart', 'admin', sysdate(), '', null, '数据分析目录');
INSERT INTO sys_menu VALUES (2010, '生产看板', 2053, 1, '/mes/dashboard', '', 'C', '0', '1', 'mes:dashboard:view', 'fa fa-dashboard', 'admin', sysdate(), '', null, '');

-- 功能按钮权限 (F类型)
-- 销售订单
INSERT INTO sys_menu VALUES (2400, '订单查询', 2004, 1, '#', '', 'F', '0', '1', 'mes:order:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2402, '订单新增', 2004, 2, '#', '', 'F', '0', '1', 'mes:order:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2403, '订单修改', 2004, 3, '#', '', 'F', '0', '1', 'mes:order:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2404, '订单删除', 2004, 4, '#', '', 'F', '0', '1', 'mes:order:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2405, '订单导出', 2004, 5, '#', '', 'F', '0', '1', 'mes:order:export', '#', 'admin', sysdate(), '', null, '');

-- 工单中心
INSERT INTO sys_menu VALUES (2500, '工单查询', 2005, 1, '#', '', 'F', '0', '1', 'mes:workorder:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2502, '工单新增', 2005, 2, '#', '', 'F', '0', '1', 'mes:workorder:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2503, '工单修改', 2005, 3, '#', '', 'F', '0', '1', 'mes:workorder:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2504, '工单删除', 2005, 4, '#', '', 'F', '0', '1', 'mes:workorder:remove', '#', 'admin', sysdate(), '', null, '');

-- 生产报工
INSERT INTO sys_menu VALUES (2600, '报工查询', 2006, 1, '#', '', 'F', '0', '1', 'mes:report:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2602, '报工新增', 2006, 2, '#', '', 'F', '0', '1', 'mes:report:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2604, '报工删除', 2006, 3, '#', '', 'F', '0', '1', 'mes:report:remove', '#', 'admin', sysdate(), '', null, '');

-- 产品管理
INSERT INTO sys_menu VALUES (2200, '产品查询', 2002, 1, '#', '', 'F', '0', '1', 'mes:product:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2202, '产品新增', 2002, 2, '#', '', 'F', '0', '1', 'mes:product:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2203, '产品修改', 2002, 3, '#', '', 'F', '0', '1', 'mes:product:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2204, '产品删除', 2002, 4, '#', '', 'F', '0', '1', 'mes:product:remove', '#', 'admin', sysdate(), '', null, '');

-- BOM管理
INSERT INTO sys_menu VALUES (2300, 'BOM查询', 2003, 1, '#', '', 'F', '0', '1', 'mes:bom:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2302, 'BOM新增', 2003, 2, '#', '', 'F', '0', '1', 'mes:bom:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2303, 'BOM修改', 2003, 3, '#', '', 'F', '0', '1', 'mes:bom:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2304, 'BOM删除', 2003, 4, '#', '', 'F', '0', '1', 'mes:bom:remove', '#', 'admin', sysdate(), '', null, '');

-- 库存管理
INSERT INTO sys_menu VALUES (2700, '库存查询', 2007, 1, '#', '', 'F', '0', '1', 'mes:inventory:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2702, '库存新增', 2007, 2, '#', '', 'F', '0', '1', 'mes:inventory:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2704, '库存删除', 2007, 3, '#', '', 'F', '0', '1', 'mes:inventory:remove', '#', 'admin', sysdate(), '', null, '');

-- 设备监控
INSERT INTO sys_menu VALUES (2800, '设备查询', 2008, 1, '#', '', 'F', '0', '1', 'mes:equipment:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2802, '设备新增', 2008, 2, '#', '', 'F', '0', '1', 'mes:equipment:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2803, '设备修改', 2008, 3, '#', '', 'F', '0', '1', 'mes:equipment:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2804, '设备删除', 2008, 4, '#', '', 'F', '0', '1', 'mes:equipment:remove', '#', 'admin', sysdate(), '', null, '');

-- 发货管理
INSERT INTO sys_menu VALUES (2900, '发货查询', 2009, 1, '#', '', 'F', '0', '1', 'mes:shipment:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2902, '发货新增', 2009, 2, '#', '', 'F', '0', '1', 'mes:shipment:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2904, '发货删除', 2009, 3, '#', '', 'F', '0', '1', 'mes:shipment:remove', '#', 'admin', sysdate(), '', null, '');

-- 生产看板
INSERT INTO sys_menu VALUES (20100, '看板查询', 2010, 1, '#', '', 'F', '0', '1', 'mes:dashboard:list', '#', 'admin', sysdate(), '', null, '');

-- 工序设备映射
INSERT INTO sys_menu VALUES (2035, '工序设备映射', 2033, 2, '/mes/mapping', '', 'C', '0', '1', 'mes:mapping:view', 'fa fa-link', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2810, '映射查询', 2035, 1, '#', '', 'F', '0', '1', 'mes:mapping:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2811, '映射新增', 2035, 2, '#', '', 'F', '0', '1', 'mes:mapping:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2812, '映射修改', 2035, 3, '#', '', 'F', '0', '1', 'mes:mapping:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2813, '映射删除', 2035, 4, '#', '', 'F', '0', '1', 'mes:mapping:remove', '#', 'admin', sysdate(), '', null, '');

-- 领料管理
INSERT INTO sys_menu VALUES (2060, '领料管理', 2011, 5, '/mes/picking', '', 'C', '0', '1', 'mes:picking:view', 'fa fa-cart-arrow-down', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (26000, '领料查询', 2060, 1, '#', '', 'F', '0', '1', 'mes:picking:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (26001, '领料新增', 2060, 2, '#', '', 'F', '0', '1', 'mes:picking:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (26002, '领料确认', 2060, 3, '#', '', 'F', '0', '1', 'mes:picking:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (26003, '领料删除', 2060, 4, '#', '', 'F', '0', '1', 'mes:picking:remove', '#', 'admin', sysdate(), '', null, '');

-- 入库管理
INSERT INTO sys_menu VALUES (2070, '入库管理', 2011, 6, '/mes/warehousing', '', 'C', '0', '1', 'mes:warehousing:view', 'fa fa-sign-in', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (27000, '入库查询', 2070, 1, '#', '', 'F', '0', '1', 'mes:warehousing:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (27001, '入库新增', 2070, 2, '#', '', 'F', '0', '1', 'mes:warehousing:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (27002, '入库操作', 2070, 3, '#', '', 'F', '0', '1', 'mes:warehousing:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (27003, '入库删除', 2070, 4, '#', '', 'F', '0', '1', 'mes:warehousing:remove', '#', 'admin', sysdate(), '', null, '');

-- 质量追溯
INSERT INTO sys_menu VALUES (2080, '质量追溯', 2053, 2, '/mes/trace', '', 'C', '0', '1', 'mes:trace:view', 'fa fa-history', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (28000, '追溯查询', 2080, 1, '#', '', 'F', '0', '1', 'mes:trace:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (28001, '追溯新增', 2080, 2, '#', '', 'F', '0', '1', 'mes:trace:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (28002, '缺陷处理', 2080, 3, '#', '', 'F', '0', '1', 'mes:trace:edit', '#', 'admin', sysdate(), '', null, '');
