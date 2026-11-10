-- AI分析菜单 (parent: 数据分析 2053, order_num=3)
INSERT INTO sys_menu VALUES (2081, 'AI分析', 2053, 3, '/mes/ai/sales', '', 'C', '0', '1', 'mes:ai:view', 'fa fa-magic', 'admin', sysdate(), '', null, 'AI数据分析');

-- 权限按钮
INSERT INTO sys_menu VALUES (28100, 'AI分析查询', 2081, 1, '#', '', 'F', '0', '1', 'mes:ai:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (28101, 'AI分析-执行分析', 2081, 2, '#', '', 'F', '0', '1', 'mes:ai:analyze', '#', 'admin', sysdate(), '', null, '');
