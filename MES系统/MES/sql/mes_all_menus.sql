-- MES 全部菜单与权限 SQL (含销售订单、工单、生产报工、库存、设备、发货、数据看板)
-- 适用于 RuoYi 4.x sys_menu 表，如已有相同 menu_id 请调整后执行

-- 销售订单管理 (parent: MES管理 2000)
insert into sys_menu values (2004, '销售订单', 2000, 4, '/mes/order', '', 'C', '0', '1', 'mes:order:view', 'fa fa-file-text', 'admin', sysdate(), '', null, '销售订单菜单');
insert into sys_menu values (2400, '订单查询', 2004, 1, '#', '', 'F', '0', '1', 'mes:order:list', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2401, '订单详情', 2004, 2, '#', '', 'F', '0', '1', 'mes:order:query', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2402, '订单新增', 2004, 3, '#', '', 'F', '0', '1', 'mes:order:add', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2403, '订单修改', 2004, 4, '#', '', 'F', '0', '1', 'mes:order:edit', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2404, '订单删除', 2004, 5, '#', '', 'F', '0', '1', 'mes:order:remove', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2405, '订单导出', 2004, 6, '#', '', 'F', '0', '1', 'mes:order:export', '#', 'admin', sysdate(), '', null, '');

-- 工单管理
insert into sys_menu values (2005, '工单管理', 2000, 5, '/mes/workorder', '', 'C', '0', '1', 'mes:workorder:view', 'fa fa-tasks', 'admin', sysdate(), '', null, '工单管理菜单');
insert into sys_menu values (2500, '工单查询', 2005, 1, '#', '', 'F', '0', '1', 'mes:workorder:list', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2501, '工单详情', 2005, 2, '#', '', 'F', '0', '1', 'mes:workorder:query', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2502, '工单新增', 2005, 3, '#', '', 'F', '0', '1', 'mes:workorder:add', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2503, '工单修改', 2005, 4, '#', '', 'F', '0', '1', 'mes:workorder:edit', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2504, '工单删除', 2005, 5, '#', '', 'F', '0', '1', 'mes:workorder:remove', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2505, '工单导出', 2005, 6, '#', '', 'F', '0', '1', 'mes:workorder:export', '#', 'admin', sysdate(), '', null, '');

-- 生产报工
insert into sys_menu values (2006, '生产报工', 2000, 6, '/mes/report', '', 'C', '0', '1', 'mes:report:view', 'fa fa-clipboard-check', 'admin', sysdate(), '', null, '生产报工菜单');
insert into sys_menu values (2600, '报工查询', 2006, 1, '#', '', 'F', '0', '1', 'mes:report:list', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2601, '报工详情', 2006, 2, '#', '', 'F', '0', '1', 'mes:report:query', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2602, '报工新增', 2006, 3, '#', '', 'F', '0', '1', 'mes:report:add', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2603, '报工修改', 2006, 4, '#', '', 'F', '0', '1', 'mes:report:edit', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2604, '报工删除', 2006, 5, '#', '', 'F', '0', '1', 'mes:report:remove', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2605, '报工导出', 2006, 6, '#', '', 'F', '0', '1', 'mes:report:export', '#', 'admin', sysdate(), '', null, '');

-- 库存管理
insert into sys_menu values (2007, '库存管理', 2000, 7, '/mes/inventory', '', 'C', '0', '1', 'mes:inventory:view', 'fa fa-warehouse', 'admin', sysdate(), '', null, '库存管理菜单');
insert into sys_menu values (2700, '库存查询', 2007, 1, '#', '', 'F', '0', '1', 'mes:inventory:list', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2701, '库存详情', 2007, 2, '#', '', 'F', '0', '1', 'mes:inventory:query', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2702, '库存新增', 2007, 3, '#', '', 'F', '0', '1', 'mes:inventory:add', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2703, '库存修改', 2007, 4, '#', '', 'F', '0', '1', 'mes:inventory:edit', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2704, '库存删除', 2007, 5, '#', '', 'F', '0', '1', 'mes:inventory:remove', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2705, '库存导出', 2007, 6, '#', '', 'F', '0', '1', 'mes:inventory:export', '#', 'admin', sysdate(), '', null, '');

-- 设备管理
insert into sys_menu values (2008, '设备管理', 2000, 8, '/mes/equipment', '', 'C', '0', '1', 'mes:equipment:view', 'fa fa-cogs', 'admin', sysdate(), '', null, '设备管理菜单');
insert into sys_menu values (2800, '设备查询', 2008, 1, '#', '', 'F', '0', '1', 'mes:equipment:list', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2801, '设备详情', 2008, 2, '#', '', 'F', '0', '1', 'mes:equipment:query', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2802, '设备新增', 2008, 3, '#', '', 'F', '0', '1', 'mes:equipment:add', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2803, '设备修改', 2008, 4, '#', '', 'F', '0', '1', 'mes:equipment:edit', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2804, '设备删除', 2008, 5, '#', '', 'F', '0', '1', 'mes:equipment:remove', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2805, '设备导出', 2008, 6, '#', '', 'F', '0', '1', 'mes:equipment:export', '#', 'admin', sysdate(), '', null, '');

-- 发货管理
insert into sys_menu values (2009, '发货管理', 2000, 9, '/mes/shipment', '', 'C', '0', '1', 'mes:shipment:view', 'fa fa-truck', 'admin', sysdate(), '', null, '发货管理菜单');
insert into sys_menu values (2900, '发货查询', 2009, 1, '#', '', 'F', '0', '1', 'mes:shipment:list', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2901, '发货详情', 2009, 2, '#', '', 'F', '0', '1', 'mes:shipment:query', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2902, '发货新增', 2009, 3, '#', '', 'F', '0', '1', 'mes:shipment:add', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2903, '发货修改', 2009, 4, '#', '', 'F', '0', '1', 'mes:shipment:edit', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2904, '发货删除', 2009, 5, '#', '', 'F', '0', '1', 'mes:shipment:remove', '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values (2905, '发货导出', 2009, 6, '#', '', 'F', '0', '1', 'mes:shipment:export', '#', 'admin', sysdate(), '', null, '');

-- 数据看板
insert into sys_menu values (2010, '数据看板', 2000, 10, '/mes/dashboard', '', 'C', '0', '1', 'mes:dashboard:view', 'fa fa-chart-bar', 'admin', sysdate(), '', null, '数据看板菜单');
