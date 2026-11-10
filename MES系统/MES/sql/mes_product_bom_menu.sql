-- MES产品管理与BOM管理菜单与权限
-- 适用于 RuoYi 4.x sys_menu 表结构

-- 产品管理菜单 (parent: MES管理 2000)
insert into sys_menu
values (2002, '产品管理', 2000, 2, '/mes/product', '', 'C', '0', '1', 'mes:product:view', 'fa fa-cube', 'admin', sysdate(), '', null, '产品管理菜单');

insert into sys_menu
values (2200, '产品查询', 2002, 1, '#', '', 'F', '0', '1', 'mes:product:list', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2201, '产品详情', 2002, 2, '#', '', 'F', '0', '1', 'mes:product:query', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2202, '产品新增', 2002, 3, '#', '', 'F', '0', '1', 'mes:product:add', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2203, '产品修改', 2002, 4, '#', '', 'F', '0', '1', 'mes:product:edit', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2204, '产品删除', 2002, 5, '#', '', 'F', '0', '1', 'mes:product:remove', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2205, '产品导出', 2002, 6, '#', '', 'F', '0', '1', 'mes:product:export', '#', 'admin', sysdate(), '', null, '');

-- BOM管理菜单 (parent: MES管理 2000)
insert into sys_menu
values (2003, 'BOM管理', 2000, 3, '/mes/bom', '', 'C', '0', '1', 'mes:bom:view', 'fa fa-list-alt', 'admin', sysdate(), '', null, 'BOM管理菜单');

insert into sys_menu
values (2300, 'BOM查询', 2003, 1, '#', '', 'F', '0', '1', 'mes:bom:list', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2301, 'BOM详情', 2003, 2, '#', '', 'F', '0', '1', 'mes:bom:query', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2302, 'BOM新增', 2003, 3, '#', '', 'F', '0', '1', 'mes:bom:add', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2303, 'BOM修改', 2003, 4, '#', '', 'F', '0', '1', 'mes:bom:edit', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2304, 'BOM删除', 2003, 5, '#', '', 'F', '0', '1', 'mes:bom:remove', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2305, 'BOM导出', 2003, 6, '#', '', 'F', '0', '1', 'mes:bom:export', '#', 'admin', sysdate(), '', null, '');
