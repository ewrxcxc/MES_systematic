-- 菜单结构调整：将客户管理从物料管理移动到MES工作台
-- 执行日期: 2026-06-11
--
-- 调整前:
--   MES工作台 (2000)
--   物料管理 (2022)
--     └─ 客户管理 (28003)
--
-- 调整后:
--   MES工作台 (2000)
--     └─ 客户管理 (28003)
--   物料管理 (2022)
--     ├─ 产品管理
--     ├─ BOM管理
--     └─ 库存管理

-- 1. 移动客户管理：parent_id 从 2022(物料管理) 改为 2000(MES工作台)
UPDATE sys_menu SET parent_id = 2000, order_num = 1 WHERE menu_id = 28003;

-- 2. 修复孤儿权限按钮：parent_id 从 2001(不存在) 改为 28003(客户管理)
UPDATE sys_menu SET parent_id = 28003 WHERE parent_id = 2001;

-- 验证
SELECT menu_id, menu_name, parent_id FROM sys_menu WHERE menu_id IN (2000, 2022, 28003, 2100, 2101, 2102, 2103, 2104, 2105);
