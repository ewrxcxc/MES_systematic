-- MES客户管理菜单与权限
-- 客户管理属于MES工作台(menu_id=2000)下的基础数据模块

-- 客户管理菜单 (C类型)
insert ignore into sys_menu
values (2001, '客户管理', 2000, 1, '/mes/customer', '', 'C', '0', '1', 'mes:customer:view', 'fa fa-address-book', 'admin', sysdate(), '', null, '客户管理菜单');

insert into sys_menu
values (2100, '客户查询', 2001, 1, '#', '', 'F', '0', '1', 'mes:customer:list', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2101, '客户详情', 2001, 2, '#', '', 'F', '0', '1', 'mes:customer:query', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2102, '客户新增', 2001, 3, '#', '', 'F', '0', '1', 'mes:customer:add', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2103, '客户修改', 2001, 4, '#', '', 'F', '0', '1', 'mes:customer:edit', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2104, '客户删除', 2001, 5, '#', '', 'F', '0', '1', 'mes:customer:remove', '#', 'admin', sysdate(), '', null, '');

insert into sys_menu
values (2105, '客户导出', 2001, 6, '#', '', 'F', '0', '1', 'mes:customer:export', '#', 'admin', sysdate(), '', null, '');
