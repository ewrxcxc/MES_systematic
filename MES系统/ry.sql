/*
 Navicat Premium Dump SQL

 Source Server         : homework
 Source Server Type    : MySQL
 Source Server Version : 90600 (9.6.0)
 Source Host           : localhost:3306
 Source Schema         : ry

 Target Server Type    : MySQL
 Target Server Version : 90600 (9.6.0)
 File Encoding         : 65001

 Date: 12/06/2026 15:16:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bom
-- ----------------------------
DROP TABLE IF EXISTS `bom`;
CREATE TABLE `bom`  (
  `bom_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'BOM ID',
  `product_id` bigint NULL DEFAULT NULL COMMENT '产品ID',
  `material_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物料名称',
  `material_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物料编码',
  `usage_qty` decimal(10, 2) NULL DEFAULT NULL COMMENT '用量',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`bom_id`) USING BTREE,
  INDEX `idx_bom_product`(`product_id` ASC) USING BTREE,
  CONSTRAINT `fk_bom_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'BOM物料表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bom
-- ----------------------------
INSERT INTO `bom` VALUES (1, 1, 'ABS塑料颗粒', 'M-001', 0.15, 'admin', '2026-06-09 10:34:15', '', NULL, '桌面支架Pro');
INSERT INTO `bom` VALUES (2, 1, '硅胶防滑垫', 'M-004', 4.00, 'admin', '2026-06-09 10:34:15', '', NULL, '桌面支架Pro');
INSERT INTO `bom` VALUES (3, 1, '不锈钢螺丝M4x8', 'M-006', 4.00, 'admin', '2026-06-09 10:34:15', '', NULL, '桌面支架Pro');
INSERT INTO `bom` VALUES (4, 2, 'ABS塑料颗粒', 'M-001', 0.08, 'admin', '2026-06-09 10:34:15', '', NULL, '车载支架');
INSERT INTO `bom` VALUES (5, 2, '不锈钢弹簧丝', 'M-003', 0.02, 'admin', '2026-06-09 10:34:15', '', NULL, '车载支架');
INSERT INTO `bom` VALUES (6, 2, '硅胶防滑垫', 'M-004', 2.00, 'admin', '2026-06-09 10:34:15', '', NULL, '车载支架');
INSERT INTO `bom` VALUES (7, 3, '铝合金板材2mm', 'M-005', 0.30, 'admin', '2026-06-09 10:34:15', '', NULL, '折叠支架');
INSERT INTO `bom` VALUES (8, 3, '硅胶防滑垫', 'M-004', 2.00, 'admin', '2026-06-09 10:34:15', '', NULL, '折叠支架');
INSERT INTO `bom` VALUES (9, 4, 'PC聚碳酸酯颗粒', 'M-002', 0.12, 'admin', '2026-06-09 10:34:15', '', NULL, '无线充支架');
INSERT INTO `bom` VALUES (10, 4, '硅胶防滑垫', 'M-004', 3.00, 'admin', '2026-06-09 10:34:15', '', NULL, '无线充支架');
INSERT INTO `bom` VALUES (11, 4, '不锈钢螺丝M4x8', 'M-006', 3.00, 'admin', '2026-06-09 10:34:15', '', NULL, '无线充支架');
INSERT INTO `bom` VALUES (12, 5, '铝合金板材2mm', 'M-005', 0.50, 'admin', '2026-06-09 10:34:15', '', NULL, '直播支架');
INSERT INTO `bom` VALUES (13, 5, '不锈钢螺丝M4x8', 'M-006', 6.00, 'admin', '2026-06-09 10:34:15', '', NULL, '直播支架');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `customer_id` bigint NOT NULL AUTO_INCREMENT COMMENT '客户ID',
  `customer_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户编码',
  `customer_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户名称',
  `contact_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `customer_priority` int NULL DEFAULT 2 COMMENT '客户优先级(1=A,2=B,3=C)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`customer_id`) USING BTREE,
  UNIQUE INDEX `uk_customer_code`(`customer_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '客户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, 'C001', '深圳数码科技有限公司', '张总', '13800138001', 'zhang@szdigital.com', '深圳市福田区华强北电子市场', '0', 2, 'admin', '2026-06-09 10:34:15', '', NULL, '手机配件经销商');
INSERT INTO `customer` VALUES (2, 'C002', '广州汽车用品有限公司', '李经理', '13800138002', 'li@gzautoacc.com', '广州市越秀区永福路汽车用品城', '0', 2, 'admin', '2026-06-09 10:34:15', '', NULL, '车载配件批发商');
INSERT INTO `customer` VALUES (3, 'C003', '东莞电子商贸有限公司', '王总', '13800138003', 'wang@dgecom.com', '东莞市虎门镇电商产业园', '0', 2, 'admin', '2026-06-09 10:34:15', '', NULL, '跨境电商卖家');
INSERT INTO `customer` VALUES (4, 'C004', '义乌手机配件商行', '赵老板', '13800138004', 'zhao@ywsj.com', '义乌市国际商贸城二期', '0', 2, 'admin', '2026-06-09 10:34:15', '', NULL, '批发零售商');
INSERT INTO `customer` VALUES (5, 'C005', '杭州智能品牌有限公司', '刘总监', '13800138005', 'liu@hzzhineng.com', '杭州市滨江区物联网小镇', '0', 2, 'admin', '2026-06-09 10:34:15', '', NULL, '品牌运营商');

-- ----------------------------
-- Table structure for equipment
-- ----------------------------
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE `equipment`  (
  `equipment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '设备ID',
  `equipment_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备编码',
  `equipment_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备名称',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备状态',
  `runtime_hours` decimal(10, 2) NULL DEFAULT NULL COMMENT '运行时间',
  `last_maintenance` datetime NULL DEFAULT NULL COMMENT '上次维护时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `fault_count` int NULL DEFAULT 0 COMMENT '故障次数',
  `last_fault_time` datetime NULL DEFAULT NULL COMMENT '最近故障时间',
  `last_fault_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最近故障描述',
  PRIMARY KEY (`equipment_id`) USING BTREE,
  UNIQUE INDEX `uk_equipment_code`(`equipment_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '设备表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of equipment
-- ----------------------------
INSERT INTO `equipment` VALUES (1, 'E-INJ-01', '注塑机#1', 'RUNNING', 8520.50, '2026-05-15 00:00:00', 'admin', '2026-06-09 10:34:15', '', NULL, '海天天隆MA1200', 0, NULL, NULL);
INSERT INTO `equipment` VALUES (2, 'E-INJ-02', '注塑机#2', 'RUNNING', 7200.00, '2026-05-20 00:00:00', 'admin', '2026-06-09 10:34:15', '', NULL, '海天天隆MA1200', 0, NULL, NULL);
INSERT INTO `equipment` VALUES (3, 'E-INJ-03', '注塑机#3', 'IDLE', 6500.00, '2026-05-10 00:00:00', 'admin', '2026-06-09 10:34:15', '', NULL, '伊之密UN120A5', 0, NULL, NULL);
INSERT INTO `equipment` VALUES (4, 'E-SPRING-01', '弹簧绕制机', 'RUNNING', 4500.00, '2026-04-28 00:00:00', 'admin', '2026-06-09 10:34:15', '', NULL, '', 0, NULL, NULL);
INSERT INTO `equipment` VALUES (5, 'E-SILICINE-01', '硅胶硫化成型机', 'RUNNING', 3800.00, '2026-05-25 00:00:00', 'admin', '2026-06-09 10:34:15', '', NULL, '', 0, NULL, NULL);
INSERT INTO `equipment` VALUES (6, 'E-CNC-01', 'CNC加工中心', 'IDLE', 3200.00, '2026-05-18 00:00:00', 'admin', '2026-06-09 10:34:15', '', NULL, '铝合金件加工', 0, NULL, NULL);
INSERT INTO `equipment` VALUES (7, 'E-ASM-01', '自动组装线#1', 'RUNNING', 5600.00, '2026-05-22 00:00:00', 'admin', '2026-06-09 10:34:15', '', NULL, '', 0, NULL, NULL);
INSERT INTO `equipment` VALUES (8, 'E-ASM-02', '自动组装线#2', 'IDLE', 3800.00, '2026-05-08 00:00:00', 'admin', '2026-06-09 10:34:15', '', NULL, '', 0, NULL, NULL);
INSERT INTO `equipment` VALUES (9, 'E-PACK-01', '自动包装线', 'RUNNING', 4200.00, '2026-05-12 00:00:00', 'admin', '2026-06-09 10:34:15', '', NULL, '', 0, NULL, NULL);
INSERT INTO `equipment` VALUES (10, 'E-INSP-01', '视觉检测设备', 'RUNNING', 5600.00, '2026-05-12 00:00:00', 'admin', '2026-06-09 10:34:15', '', NULL, '成品外观及尺寸检测', 0, NULL, NULL);

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作 sub主子表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `form_col_num` int NULL DEFAULT 1 COMMENT '表单布局（单列 双列 三列）',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for inventory
-- ----------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory`  (
  `inventory_id` bigint NOT NULL AUTO_INCREMENT COMMENT '库存ID',
  `inventory_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '库存类型',
  `work_order_id` bigint NULL DEFAULT NULL COMMENT '关联工单ID',
  `material_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物料编码',
  `material_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物料名称',
  `quantity` decimal(10, 2) NULL DEFAULT NULL COMMENT '库存数量',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '库位',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`inventory_id`) USING BTREE,
  INDEX `idx_inv_wo_id`(`work_order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '库存表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventory
-- ----------------------------
INSERT INTO `inventory` VALUES (1, 'RAW_MATERIAL', NULL, 'M-001', 'ABS塑料颗粒', 79302.50, '原材料仓-A区', 'admin', '2026-06-09 10:34:15', '', '2026-06-09 13:27:10', '');
INSERT INTO `inventory` VALUES (2, 'RAW_MATERIAL', NULL, 'M-002', 'PC聚碳酸酯颗粒', 14347.32, '原材料仓-A区', 'admin', '2026-06-09 10:34:15', '', '2026-06-12 08:52:24', '');
INSERT INTO `inventory` VALUES (3, 'RAW_MATERIAL', NULL, 'M-003', '不锈钢弹簧丝', 10999.00, '原材料仓-B区', 'admin', '2026-06-09 10:34:15', '', '2026-06-09 12:40:06', '');
INSERT INTO `inventory` VALUES (4, 'RAW_MATERIAL', NULL, 'M-004', '硅胶原料', 113307.00, '原材料仓-B区', 'admin', '2026-06-09 10:34:15', '', '2026-06-12 08:52:24', '');
INSERT INTO `inventory` VALUES (5, 'RAW_MATERIAL', NULL, 'M-005', '铝合金板材2mm', 22688.20, '原材料仓-C区', 'admin', '2026-06-09 10:34:15', '', '2026-06-12 08:43:18', '');
INSERT INTO `inventory` VALUES (6, 'RAW_MATERIAL', NULL, 'M-006', '不锈钢螺丝M4x8', 50574005.00, '原材料仓-C区', 'admin', '2026-06-09 10:34:15', '', '2026-06-12 08:52:25', '');
INSERT INTO `inventory` VALUES (7, 'RAW_MATERIAL', NULL, 'M-007', '包装彩盒', 10000.00, '原材料仓-D区', 'admin', '2026-06-09 10:34:15', '', NULL, '');
INSERT INTO `inventory` VALUES (8, 'SEMI_FINISHED', NULL, 'SP-001', '底座注塑件', 10999.00, '半成品仓', 'admin', '2026-06-09 10:34:15', '', '2026-06-09 12:40:27', '');
INSERT INTO `inventory` VALUES (9, 'SEMI_FINISHED', NULL, 'SP-002', '夹臂注塑件', 11199.00, '半成品仓', 'admin', '2026-06-09 10:34:15', '', '2026-06-09 12:40:32', '');
INSERT INTO `inventory` VALUES (10, 'SEMI_FINISHED', NULL, 'SP-003', '硅胶防滑垫成型件', 3000.00, '半成品仓', 'admin', '2026-06-09 10:34:15', '', NULL, '');
INSERT INTO `inventory` VALUES (11, 'SEMI_FINISHED', NULL, 'SP-004', '转轴组件', 400.00, '半成品仓', 'admin', '2026-06-09 10:34:15', '', NULL, '');
INSERT INTO `inventory` VALUES (12, 'FINISHED', NULL, 'P001', '桌面手机支架Pro', 54770.00, '成品仓-A区', 'admin', '2026-06-09 10:34:15', '', '2026-06-09 13:27:13', '');
INSERT INTO `inventory` VALUES (13, 'FINISHED', NULL, 'P002', '车载出风口手机支架', 150.00, '成品仓-A区', 'admin', '2026-06-09 10:34:15', '', NULL, '');
INSERT INTO `inventory` VALUES (14, 'FINISHED', NULL, 'P003', '折叠便携手机支架', 424.00, '成品仓-B区', 'admin', '2026-06-09 10:34:15', '', '2026-06-09 12:50:08', '');
INSERT INTO `inventory` VALUES (15, 'FINISHED', NULL, 'P004', '无线充电手机支架', 2087.00, '成品仓-B区', 'admin', '2026-06-09 10:34:15', '', '2026-06-12 08:52:37', '');
INSERT INTO `inventory` VALUES (16, 'FINISHED', NULL, 'P005', '多角度直播支架', 2422.00, '成品仓-B区', 'admin', '2026-06-09 10:34:15', '', '2026-06-12 08:43:29', '');
INSERT INTO `inventory` VALUES (17, 'CONSUMABLE', NULL, 'LV-001', '脱模剂', 6.00, '辅料仓', 'admin', '2026-06-09 10:34:15', '', NULL, '预警：库存不足');
INSERT INTO `inventory` VALUES (18, 'CONSUMABLE', NULL, 'LV-002', '防锈润滑剂', 8.00, '辅料仓', 'admin', '2026-06-09 10:34:15', '', NULL, '预警：库存不足');

-- ----------------------------
-- Table structure for mes_batch_info
-- ----------------------------
DROP TABLE IF EXISTS `mes_batch_info`;
CREATE TABLE `mes_batch_info`  (
  `batch_id` bigint NOT NULL AUTO_INCREMENT,
  `batch_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `material_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `material_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `material_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `supplier_id` bigint NULL DEFAULT NULL,
  `supplier_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `quantity` decimal(10, 2) NULL DEFAULT NULL,
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `produce_date` date NULL DEFAULT NULL,
  `receive_date` date NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'ACTIVE',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  PRIMARY KEY (`batch_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_batch_info
-- ----------------------------

-- ----------------------------
-- Table structure for mes_defect_record
-- ----------------------------
DROP TABLE IF EXISTS `mes_defect_record`;
CREATE TABLE `mes_defect_record`  (
  `defect_id` bigint NOT NULL AUTO_INCREMENT,
  `defect_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `defect_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `defect_desc` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `work_order_id` bigint NULL DEFAULT NULL,
  `process_task_id` bigint NULL DEFAULT NULL,
  `batch_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `defect_qty` int NULL DEFAULT 1,
  `severity` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `handler` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `handle_result` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `discover_time` datetime NULL DEFAULT NULL,
  `handle_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  PRIMARY KEY (`defect_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_defect_record
-- ----------------------------

-- ----------------------------
-- Table structure for mes_material_picking
-- ----------------------------
DROP TABLE IF EXISTS `mes_material_picking`;
CREATE TABLE `mes_material_picking`  (
  `picking_id` bigint NOT NULL AUTO_INCREMENT,
  `picking_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `work_order_id` bigint NOT NULL,
  `work_order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `plan_id` bigint NULL DEFAULT NULL,
  `picking_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'WAITING',
  `picking_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `picking_time` datetime NULL DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  PRIMARY KEY (`picking_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_material_picking
-- ----------------------------
INSERT INTO `mes_material_picking` VALUES (3, 'MP20260609105349', 23, 'WO20260609105349', 1, 'WAITING', NULL, NULL, 'admin', '2026-06-09 10:53:49', '', '2026-06-09 10:53:49', '');
INSERT INTO `mes_material_picking` VALUES (8, 'MP20260609122444', 28, 'WO20260609122444', 6, 'FINISHED', 'TestOperator', '2026-06-09 12:24:45', 'admin', '2026-06-09 12:24:44', 'admin', '2026-06-09 12:24:45', '');
INSERT INTO `mes_material_picking` VALUES (9, 'MP20260609124641', 29, 'WO20260609124641', 7, 'FINISHED', 'TestOperator', '2026-06-09 12:46:42', 'admin', '2026-06-09 12:46:41', 'admin', '2026-06-09 12:46:42', '');
INSERT INTO `mes_material_picking` VALUES (10, 'MP20260609124900', 30, 'WO20260609124900', 8, 'FINISHED', 'zzz', '2026-06-09 12:49:21', 'admin', '2026-06-09 12:49:00', 'admin', '2026-06-09 12:49:21', '');
INSERT INTO `mes_material_picking` VALUES (11, 'MP20260609125411', 31, 'WO20260609125411', 9, 'WAITING', NULL, NULL, 'admin', '2026-06-09 12:54:11', '', '2026-06-09 12:54:11', '');
INSERT INTO `mes_material_picking` VALUES (12, 'MP20260609132603', 32, 'WO20260609132603', 10, 'FINISHED', 'TestOperator', '2026-06-09 13:26:04', 'admin', '2026-06-09 13:26:03', 'admin', '2026-06-09 13:26:03', '');
INSERT INTO `mes_material_picking` VALUES (13, 'MP20260609132710', 33, 'WO20260609132710', 11, 'FINISHED', 'TestOperator', '2026-06-09 13:27:11', 'admin', '2026-06-09 13:27:10', 'admin', '2026-06-09 13:27:10', '');
INSERT INTO `mes_material_picking` VALUES (14, 'MP20260610102842', 34, 'WO20260610102841', 12, 'FINISHED', 'z', '2026-06-10 10:29:45', 'admin', '2026-06-10 10:28:42', 'admin', '2026-06-10 10:29:44', '');
INSERT INTO `mes_material_picking` VALUES (15, 'MP20260611214457', 35, 'WO20260611214457', 13, 'FINISHED', 'z', '2026-06-11 21:45:19', 'admin', '2026-06-11 21:44:57', 'admin', '2026-06-11 21:45:19', '');
INSERT INTO `mes_material_picking` VALUES (16, 'MP20260611232720', 36, 'WO20260611232720', 14, 'FINISHED', 'z', '2026-06-11 23:32:30', 'admin', '2026-06-11 23:27:20', 'admin', '2026-06-11 23:32:29', '');
INSERT INTO `mes_material_picking` VALUES (17, 'MP20260612084303', 37, 'WO20260612084303', 15, 'FINISHED', 'zz', '2026-06-12 08:43:19', 'admin', '2026-06-12 08:43:03', 'admin', '2026-06-12 08:43:18', '');
INSERT INTO `mes_material_picking` VALUES (18, 'MP20260612085214', 38, 'WO20260612085214', 16, 'FINISHED', 'z', '2026-06-12 08:52:25', 'admin', '2026-06-12 08:52:14', 'admin', '2026-06-12 08:52:25', '');

-- ----------------------------
-- Table structure for mes_material_picking_detail
-- ----------------------------
DROP TABLE IF EXISTS `mes_material_picking_detail`;
CREATE TABLE `mes_material_picking_detail`  (
  `detail_id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `picking_id` bigint NOT NULL COMMENT '领料单ID',
  `material_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料编码',
  `material_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '物料名称',
  `bom_usage` decimal(10, 4) NULL DEFAULT 0.0000 COMMENT 'BOM单件用量',
  `required_qty` decimal(10, 2) NOT NULL COMMENT '需求数量',
  `actual_qty` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '实发数量',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单位',
  `inventory_id` bigint NULL DEFAULT NULL COMMENT '库存记录ID(扣减用)',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'WAITING' COMMENT '状态',
  PRIMARY KEY (`detail_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '领料单明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_material_picking_detail
-- ----------------------------
INSERT INTO `mes_material_picking_detail` VALUES (5, 3, 'M-005', '铝合金板材2mm', 0.3000, 24.60, 0.00, '个', NULL, 'WAITING');
INSERT INTO `mes_material_picking_detail` VALUES (6, 3, 'M-004', '硅胶防滑垫', 2.0000, 164.00, 0.00, '个', NULL, 'WAITING');
INSERT INTO `mes_material_picking_detail` VALUES (19, 8, 'M-001', 'ABS塑料颗粒', 0.1500, 22.50, 22.50, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (20, 8, 'M-004', '硅胶防滑垫', 4.0000, 600.00, 600.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (21, 8, 'M-006', '不锈钢螺丝M4x8', 4.0000, 600.00, 600.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (22, 9, 'M-001', 'ABS塑料颗粒', 0.1500, 22.50, 22.50, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (23, 9, 'M-004', '硅胶防滑垫', 4.0000, 600.00, 600.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (24, 9, 'M-006', '不锈钢螺丝M4x8', 4.0000, 600.00, 600.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (25, 10, 'M-005', '铝合金板材2mm', 0.3000, 55.20, 55.20, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (26, 10, 'M-004', '硅胶防滑垫', 2.0000, 368.00, 368.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (27, 11, 'M-002', 'PC聚碳酸酯颗粒', 0.1200, 7.44, 0.00, '个', NULL, 'WAITING');
INSERT INTO `mes_material_picking_detail` VALUES (28, 11, 'M-004', '硅胶防滑垫', 3.0000, 186.00, 0.00, '个', NULL, 'WAITING');
INSERT INTO `mes_material_picking_detail` VALUES (29, 11, 'M-006', '不锈钢螺丝M4x8', 3.0000, 186.00, 0.00, '个', NULL, 'WAITING');
INSERT INTO `mes_material_picking_detail` VALUES (30, 12, 'M-001', 'ABS塑料颗粒', 0.1500, 22.50, 22.50, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (31, 12, 'M-004', '硅胶防滑垫', 4.0000, 600.00, 600.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (32, 12, 'M-006', '不锈钢螺丝M4x8', 4.0000, 600.00, 600.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (33, 13, 'M-001', 'ABS塑料颗粒', 0.1500, 22.50, 22.50, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (34, 13, 'M-004', '硅胶防滑垫', 4.0000, 600.00, 600.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (35, 13, 'M-006', '不锈钢螺丝M4x8', 4.0000, 600.00, 600.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (36, 14, 'M-002', 'PC聚碳酸酯颗粒', 0.1200, 7.32, 7.32, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (37, 14, 'M-004', '硅胶防滑垫', 3.0000, 183.00, 183.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (38, 14, 'M-006', '不锈钢螺丝M4x8', 3.0000, 183.00, 183.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (39, 15, 'M-002', 'PC聚碳酸酯颗粒', 0.1200, 7.32, 7.32, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (40, 15, 'M-004', '硅胶防滑垫', 3.0000, 183.00, 183.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (41, 15, 'M-006', '不锈钢螺丝M4x8', 3.0000, 183.00, 183.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (42, 16, 'M-005', '铝合金板材2mm', 0.5000, 525.00, 525.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (43, 16, 'M-006', '不锈钢螺丝M4x8', 6.0000, 6300.00, 6300.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (44, 17, 'M-005', '铝合金板材2mm', 0.5000, 41.00, 41.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (45, 17, 'M-006', '不锈钢螺丝M4x8', 6.0000, 492.00, 492.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (46, 18, 'M-002', 'PC聚碳酸酯颗粒', 0.1200, 8.76, 8.76, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (47, 18, 'M-004', '硅胶防滑垫', 3.0000, 219.00, 219.00, '个', NULL, 'FINISHED');
INSERT INTO `mes_material_picking_detail` VALUES (48, 18, 'M-006', '不锈钢螺丝M4x8', 3.0000, 219.00, 219.00, '个', NULL, 'FINISHED');

-- ----------------------------
-- Table structure for mes_process_equipment_mapping
-- ----------------------------
DROP TABLE IF EXISTS `mes_process_equipment_mapping`;
CREATE TABLE `mes_process_equipment_mapping`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `process_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `process_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `process_seq` int NOT NULL,
  `equipment_id` bigint NOT NULL,
  `equipment_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `equipment_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `line_id` bigint NULL DEFAULT NULL,
  `api_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `api_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'ACTIVE',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `request_body` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'API请求体JSON模板',
  `work_center` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '工作中心',
  `line_action` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '产线动作',
  `api_command` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'API命令',
  `response_time` bigint NULL DEFAULT NULL COMMENT '响应时间(ms)',
  `last_call_time` datetime NULL DEFAULT NULL COMMENT '最后调用时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_process_equipment_mapping
-- ----------------------------
INSERT INTO `mes_process_equipment_mapping` VALUES (16, 'PROC-001', '原材料领料', 10, 1, 'EQ-IM-01', '注塑机1', NULL, 'GET /WeatherForecast/command?commandname=start', 'REST', 'ACTIVE', 'admin', '2026-06-12 10:06:31', '', '2026-06-12 10:06:31', '', NULL, '注塑车间', '启动初始化', 'start', 5041, '2026-06-12 14:18:16');
INSERT INTO `mes_process_equipment_mapping` VALUES (17, 'PROC-002', 'CNC加工', 20, 2, 'EQ-CNC-01', 'CNC机床', NULL, 'GET /WeatherForecast/command?commandname=sendstart', 'REST', 'ACTIVE', 'admin', '2026-06-12 10:06:31', '', '2026-06-12 10:06:31', '', NULL, 'CNC加工中心', '启动传送带', 'sendstart', NULL, NULL);
INSERT INTO `mes_process_equipment_mapping` VALUES (18, 'PROC-003', '打磨处理', 30, 3, 'EQ-PL-01', '打磨设备', NULL, 'GET /WeatherForecast/command?commandname=sendstop', 'REST', 'ACTIVE', 'admin', '2026-06-12 10:06:31', '', '2026-06-12 10:06:31', '', NULL, '打磨工位', '停止传送带', 'sendstop', NULL, NULL);
INSERT INTO `mes_process_equipment_mapping` VALUES (19, 'PROC-004', '喷砂氧化', 40, 4, 'EQ-SB-01', '喷砂设备', NULL, 'GET /WeatherForecast/command?commandname=startgrab', 'REST', 'ACTIVE', 'admin', '2026-06-12 10:06:31', '', '2026-06-12 10:06:31', '', NULL, '表面处理区', '抓取盒子到平台', 'startgrab', NULL, NULL);
INSERT INTO `mes_process_equipment_mapping` VALUES (20, 'PROC-005', '组装', 50, 5, 'EQ-AS-01', '装配线', NULL, 'GET /WeatherForecast/command?commandname=startgrabBack', 'REST', 'ACTIVE', 'admin', '2026-06-12 10:06:31', '', '2026-06-12 10:06:31', '', NULL, '装配车间', '抓取盒子到传送带', 'startgrabBack', NULL, NULL);
INSERT INTO `mes_process_equipment_mapping` VALUES (21, 'PROC-006', '功能检测', 60, 6, 'EQ-QC-01', '检测设备', NULL, 'GET /WeatherForecast/command?commandname=startcrue', 'REST', 'ACTIVE', 'admin', '2026-06-12 10:06:31', '', '2026-06-12 10:06:31', '', NULL, '质检区', '开始打螺丝', 'startcrue', NULL, NULL);
INSERT INTO `mes_process_equipment_mapping` VALUES (22, 'PROC-007', '包装入库', 70, 7, 'EQ-PK-01', '包装设备', NULL, 'GET /WeatherForecast/command?commandname=startlay', 'REST', 'ACTIVE', 'admin', '2026-06-12 10:06:31', '', '2026-06-12 10:06:31', '', NULL, '包装车间', '开始激光打标', 'startlay', NULL, NULL);

-- ----------------------------
-- Table structure for mes_process_report
-- ----------------------------
DROP TABLE IF EXISTS `mes_process_report`;
CREATE TABLE `mes_process_report`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '报工ID',
  `work_order_id` bigint NULL DEFAULT NULL,
  `work_order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `task_id` bigint NULL DEFAULT NULL,
  `process_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `process_seq` int NULL DEFAULT NULL,
  `product_id` bigint NULL DEFAULT NULL,
  `product_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `complete_time` datetime NULL DEFAULT NULL,
  `operator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `equipment` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `produced_qty` int NULL DEFAULT 0,
  `good_qty` int NULL DEFAULT 0,
  `bad_qty` int NULL DEFAULT 0,
  `yield_rate` decimal(5, 2) NULL DEFAULT NULL,
  `material_consumed` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `has_fault` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '否',
  `fault_desc` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_work_order_id`(`work_order_id` ASC) USING BTREE,
  INDEX `idx_task_id`(`task_id` ASC) USING BTREE,
  INDEX `idx_process_name`(`process_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工序报工表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_process_report
-- ----------------------------
INSERT INTO `mes_process_report` VALUES (25, 28, 'WO20260609122444', 51, 'CNC加工', 2, NULL, NULL, '2026-06-09 12:24:45', 'TestOperator', 'VisionInspector', 14, 14, 0, 100.00, 'Material-Step2', 'No', '', 'TestOperator', '2026-06-09 12:24:45', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (26, 28, 'WO20260609122444', 52, '打磨处理', 3, NULL, NULL, '2026-06-09 12:24:45', 'TestOperator', 'VisionInspector', 15, 14, 1, 93.33, 'Material-Step3', 'No', '', 'TestOperator', '2026-06-09 12:24:45', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (27, 28, 'WO20260609122444', 53, '喷砂/氧化', 4, NULL, NULL, '2026-06-09 12:24:46', 'TestOperator', 'AssemblyLine#1', 14, 14, 0, 100.00, 'Material-Step4', 'No', '', 'TestOperator', '2026-06-09 12:24:46', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (28, 28, 'WO20260609122444', 54, '组装', 5, NULL, NULL, '2026-06-09 12:24:46', 'TestOperator', 'VisionInspector', 14, 14, 0, 100.00, 'Material-Step5', 'Yes', 'Test fault: slight mold wear', 'TestOperator', '2026-06-09 12:24:46', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (29, 28, 'WO20260609122444', 55, '功能检测', 6, NULL, NULL, '2026-06-09 12:24:47', 'TestOperator', 'VisionInspector', 15, 14, 1, 93.33, 'Material-Step6', 'No', '', 'TestOperator', '2026-06-09 12:24:47', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (30, 28, 'WO20260609122444', 56, '包装入库', 7, NULL, NULL, '2026-06-09 12:24:47', 'TestOperator', 'VisionInspector', 14, 14, 0, 100.00, 'Material-Step7', 'No', '', 'TestOperator', '2026-06-09 12:24:47', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (31, 29, 'WO20260609124641', 57, '原材料领料', 1, NULL, NULL, '2026-06-09 12:46:42', 'admin', '领料区', 150, 150, 0, 100.00, '原材料领料完成', '否', NULL, 'admin', '2026-06-09 12:46:42', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (32, 29, 'WO20260609124641', 58, 'CNC加工', 2, NULL, NULL, '2026-06-09 12:46:42', 'TestOperator', 'VisionInspector', 14, 14, 0, 100.00, 'Material-Step2', 'No', '', 'TestOperator', '2026-06-09 12:46:42', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (33, 29, 'WO20260609124641', 59, '打磨处理', 3, NULL, NULL, '2026-06-09 12:46:42', 'TestOperator', 'VisionInspector', 15, 14, 1, 93.33, 'Material-Step3', 'No', '', 'TestOperator', '2026-06-09 12:46:42', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (34, 29, 'WO20260609124641', 60, '喷砂/氧化', 4, NULL, NULL, '2026-06-09 12:46:43', 'TestOperator', 'AssemblyLine#1', 14, 14, 0, 100.00, 'Material-Step4', 'No', '', 'TestOperator', '2026-06-09 12:46:43', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (35, 29, 'WO20260609124641', 61, '组装', 5, NULL, NULL, '2026-06-09 12:46:43', 'TestOperator', 'VisionInspector', 14, 14, 0, 100.00, 'Material-Step5', 'Yes', 'Test fault: slight mold wear', 'TestOperator', '2026-06-09 12:46:43', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (36, 29, 'WO20260609124641', 62, '功能检测', 6, NULL, NULL, '2026-06-09 12:46:43', 'TestOperator', 'VisionInspector', 15, 14, 1, 93.33, 'Material-Step6', 'No', '', 'TestOperator', '2026-06-09 12:46:43', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (37, 29, 'WO20260609124641', 63, '包装入库', 7, NULL, NULL, '2026-06-09 12:46:44', 'TestOperator', 'VisionInspector', 14, 14, 0, 100.00, 'Material-Step7', 'No', '', 'TestOperator', '2026-06-09 12:46:44', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (38, 30, 'WO20260609124900', 64, '原材料领料', 1, NULL, NULL, '2026-06-09 12:49:21', 'admin', '领料区', 184, 184, 0, 100.00, '原材料领料完成', '否', NULL, 'admin', '2026-06-09 12:49:21', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (39, 32, 'WO20260609132603', 78, '原材料领料', 1, NULL, NULL, '2026-06-09 13:26:03', 'admin', '领料区', 150, 150, 0, 100.00, '原材料领料完成', '否', NULL, 'admin', '2026-06-09 13:26:03', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (40, 32, 'WO20260609132603', 79, 'CNC加工', 2, NULL, NULL, '2026-06-09 13:26:03', 'TestOperator', 'VisionInspector', 14, 14, 0, 100.00, 'Material-Step2', 'No', '', 'TestOperator', '2026-06-09 13:26:03', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (41, 32, 'WO20260609132603', 80, '打磨处理', 3, NULL, NULL, '2026-06-09 13:26:04', 'TestOperator', 'VisionInspector', 15, 14, 1, 93.33, 'Material-Step3', 'No', '', 'TestOperator', '2026-06-09 13:26:04', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (42, 32, 'WO20260609132603', 81, '喷砂/氧化', 4, NULL, NULL, '2026-06-09 13:26:04', 'TestOperator', 'AssemblyLine#1', 14, 14, 0, 100.00, 'Material-Step4', 'No', '', 'TestOperator', '2026-06-09 13:26:04', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (43, 32, 'WO20260609132603', 82, '组装', 5, NULL, NULL, '2026-06-09 13:26:04', 'TestOperator', 'VisionInspector', 14, 14, 0, 100.00, 'Material-Step5', 'Yes', 'Test fault: slight mold wear', 'TestOperator', '2026-06-09 13:26:04', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (44, 32, 'WO20260609132603', 83, '功能检测', 6, NULL, NULL, '2026-06-09 13:26:05', 'TestOperator', 'VisionInspector', 15, 14, 1, 93.33, 'Material-Step6', 'No', '', 'TestOperator', '2026-06-09 13:26:05', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (45, 32, 'WO20260609132603', 84, '包装入库', 7, NULL, NULL, '2026-06-09 13:26:05', 'TestOperator', 'VisionInspector', 14, 14, 0, 100.00, 'Material-Step7', 'No', '', 'TestOperator', '2026-06-09 13:26:05', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (46, 33, 'WO20260609132710', 85, '原材料领料', 1, NULL, NULL, '2026-06-09 13:27:10', 'admin', '领料区', 150, 150, 0, 100.00, '原材料领料完成', '否', NULL, 'admin', '2026-06-09 13:27:10', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (47, 33, 'WO20260609132710', 86, 'CNC加工', 2, NULL, NULL, '2026-06-09 13:27:11', 'TestOperator', 'VisionInspector', 14, 14, 0, 100.00, 'Material-Step2', 'No', '', 'TestOperator', '2026-06-09 13:27:11', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (48, 33, 'WO20260609132710', 87, '打磨处理', 3, NULL, NULL, '2026-06-09 13:27:11', 'TestOperator', 'VisionInspector', 15, 14, 1, 93.33, 'Material-Step3', 'No', '', 'TestOperator', '2026-06-09 13:27:11', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (49, 33, 'WO20260609132710', 88, '喷砂/氧化', 4, NULL, NULL, '2026-06-09 13:27:11', 'TestOperator', 'AssemblyLine#1', 14, 14, 0, 100.00, 'Material-Step4', 'No', '', 'TestOperator', '2026-06-09 13:27:11', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (50, 33, 'WO20260609132710', 89, '组装', 5, NULL, NULL, '2026-06-09 13:27:12', 'TestOperator', 'VisionInspector', 14, 14, 0, 100.00, 'Material-Step5', 'Yes', 'Test fault: slight mold wear', 'TestOperator', '2026-06-09 13:27:12', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (51, 33, 'WO20260609132710', 90, '功能检测', 6, NULL, NULL, '2026-06-09 13:27:12', 'TestOperator', 'VisionInspector', 15, 14, 1, 93.33, 'Material-Step6', 'No', '', 'TestOperator', '2026-06-09 13:27:12', NULL, NULL, NULL);
INSERT INTO `mes_process_report` VALUES (52, 33, 'WO20260609132710', 91, '包装入库', 7, NULL, NULL, '2026-06-09 13:27:13', 'TestOperator', 'VisionInspector', 14, 14, 0, 100.00, 'Material-Step7', 'No', '', 'TestOperator', '2026-06-09 13:27:13', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mes_process_task
-- ----------------------------
DROP TABLE IF EXISTS `mes_process_task`;
CREATE TABLE `mes_process_task`  (
  `task_id` bigint NOT NULL AUTO_INCREMENT COMMENT '工序任务ID',
  `work_order_id` bigint NOT NULL COMMENT '工单ID',
  `process_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工序名称',
  `process_seq` int NOT NULL DEFAULT 1 COMMENT '工序序号',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'WAITING' COMMENT '工序状态(WAITING/RUNNING/FINISHED)',
  `planned_qty` int NULL DEFAULT 0 COMMENT '计划数量',
  `good_qty` int NULL DEFAULT 0 COMMENT '良品数量',
  `bad_qty` int NULL DEFAULT 0 COMMENT '不良品数量',
  `operator_id` bigint NULL DEFAULT NULL COMMENT '操作员ID',
  `equipment_id` bigint NULL DEFAULT NULL COMMENT '设备ID',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `operator_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作员姓名',
  `equipment_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '设备名称',
  `material_consumed` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '原料消耗量',
  PRIMARY KEY (`task_id`) USING BTREE,
  INDEX `idx_task_workorder`(`work_order_id` ASC) USING BTREE,
  CONSTRAINT `fk_task_workorder` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 127 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'MES工序任务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_process_task
-- ----------------------------
INSERT INTO `mes_process_task` VALUES (50, 28, '原材料领料', 1, 'FINISHED', 150, 150, 0, NULL, NULL, NULL, '2026-06-09 12:24:45', 'admin', '2026-06-09 12:24:44', '', '2026-06-09 12:24:45', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (51, 28, 'CNC加工', 2, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 12:24:45', '2026-06-09 12:24:45', 'admin', '2026-06-09 12:24:44', '', '2026-06-09 12:24:45', NULL, 'TestOperator', 'VisionInspector', 'Material-Step2');
INSERT INTO `mes_process_task` VALUES (52, 28, '打磨处理', 3, 'FINISHED', 150, 14, 1, NULL, NULL, '2026-06-09 12:24:46', '2026-06-09 12:24:46', 'admin', '2026-06-09 12:24:44', '', '2026-06-09 12:24:45', NULL, 'TestOperator', 'VisionInspector', 'Material-Step3');
INSERT INTO `mes_process_task` VALUES (53, 28, '喷砂/氧化', 4, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 12:24:46', '2026-06-09 12:24:46', 'admin', '2026-06-09 12:24:44', '', '2026-06-09 12:24:46', NULL, 'TestOperator', 'AssemblyLine#1', 'Material-Step4');
INSERT INTO `mes_process_task` VALUES (54, 28, '组装', 5, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 12:24:47', '2026-06-09 12:24:47', 'admin', '2026-06-09 12:24:44', '', '2026-06-09 12:24:46', NULL, 'TestOperator', 'VisionInspector', 'Material-Step5');
INSERT INTO `mes_process_task` VALUES (55, 28, '功能检测', 6, 'FINISHED', 150, 14, 1, NULL, NULL, '2026-06-09 12:24:47', '2026-06-09 12:24:47', 'admin', '2026-06-09 12:24:44', '', '2026-06-09 12:24:47', NULL, 'TestOperator', 'VisionInspector', 'Material-Step6');
INSERT INTO `mes_process_task` VALUES (56, 28, '包装入库', 7, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 12:24:48', '2026-06-09 12:24:48', 'admin', '2026-06-09 12:24:44', '', '2026-06-09 12:24:47', NULL, 'TestOperator', 'VisionInspector', 'Material-Step7');
INSERT INTO `mes_process_task` VALUES (57, 29, '原材料领料', 1, 'FINISHED', 150, 150, 0, NULL, NULL, NULL, '2026-06-09 12:46:42', 'admin', '2026-06-09 12:46:41', '', '2026-06-09 12:46:42', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (58, 29, 'CNC加工', 2, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 12:46:42', '2026-06-09 12:46:42', 'admin', '2026-06-09 12:46:41', '', '2026-06-09 12:46:42', NULL, 'TestOperator', 'VisionInspector', 'Material-Step2');
INSERT INTO `mes_process_task` VALUES (59, 29, '打磨处理', 3, 'FINISHED', 150, 14, 1, NULL, NULL, '2026-06-09 12:46:43', '2026-06-09 12:46:43', 'admin', '2026-06-09 12:46:41', '', '2026-06-09 12:46:42', NULL, 'TestOperator', 'VisionInspector', 'Material-Step3');
INSERT INTO `mes_process_task` VALUES (60, 29, '喷砂/氧化', 4, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 12:46:43', '2026-06-09 12:46:43', 'admin', '2026-06-09 12:46:41', '', '2026-06-09 12:46:43', NULL, 'TestOperator', 'AssemblyLine#1', 'Material-Step4');
INSERT INTO `mes_process_task` VALUES (61, 29, '组装', 5, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 12:46:43', '2026-06-09 12:46:43', 'admin', '2026-06-09 12:46:41', '', '2026-06-09 12:46:43', NULL, 'TestOperator', 'VisionInspector', 'Material-Step5');
INSERT INTO `mes_process_task` VALUES (62, 29, '功能检测', 6, 'FINISHED', 150, 14, 1, NULL, NULL, '2026-06-09 12:46:44', '2026-06-09 12:46:44', 'admin', '2026-06-09 12:46:41', '', '2026-06-09 12:46:43', NULL, 'TestOperator', 'VisionInspector', 'Material-Step6');
INSERT INTO `mes_process_task` VALUES (63, 29, '包装入库', 7, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 12:46:44', '2026-06-09 12:46:44', 'admin', '2026-06-09 12:46:41', '', '2026-06-09 12:46:44', NULL, 'TestOperator', 'VisionInspector', 'Material-Step7');
INSERT INTO `mes_process_task` VALUES (64, 30, '原材料领料', 1, 'FINISHED', 184, 184, 0, NULL, NULL, NULL, '2026-06-09 12:49:21', 'admin', '2026-06-09 12:49:00', '', '2026-06-09 12:49:21', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (65, 30, 'CNC加工', 2, 'FINISHED', 184, 184, 0, NULL, NULL, NULL, '2026-06-09 12:50:09', 'admin', '2026-06-09 12:49:00', '', '2026-06-09 12:50:08', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (66, 30, '打磨处理', 3, 'FINISHED', 184, 184, 0, NULL, NULL, NULL, '2026-06-09 12:50:09', 'admin', '2026-06-09 12:49:00', '', '2026-06-09 12:50:08', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (67, 30, '喷砂/氧化', 4, 'FINISHED', 184, 184, 0, NULL, NULL, NULL, '2026-06-09 12:50:09', 'admin', '2026-06-09 12:49:00', '', '2026-06-09 12:50:08', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (68, 30, '组装', 5, 'FINISHED', 184, 184, 0, NULL, NULL, NULL, '2026-06-09 12:50:09', 'admin', '2026-06-09 12:49:00', '', '2026-06-09 12:50:08', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (69, 30, '功能检测', 6, 'FINISHED', 184, 184, 0, NULL, NULL, NULL, '2026-06-09 12:50:09', 'admin', '2026-06-09 12:49:00', '', '2026-06-09 12:50:08', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (70, 30, '包装入库', 7, 'FINISHED', 184, 184, 0, NULL, NULL, NULL, '2026-06-09 12:50:09', 'admin', '2026-06-09 12:49:00', '', '2026-06-09 12:50:08', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (71, 31, '原材料领料', 1, 'FINISHED', 62, 62, 0, NULL, NULL, NULL, '2026-06-11 23:30:21', 'admin', '2026-06-09 12:54:11', '', '2026-06-11 23:30:20', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (72, 31, 'CNC加工', 2, 'FINISHED', 62, 62, 0, NULL, NULL, NULL, '2026-06-11 23:30:21', 'admin', '2026-06-09 12:54:11', '', '2026-06-11 23:30:20', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (73, 31, '打磨处理', 3, 'FINISHED', 62, 62, 0, NULL, NULL, NULL, '2026-06-11 23:30:21', 'admin', '2026-06-09 12:54:11', '', '2026-06-11 23:30:20', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (74, 31, '喷砂/氧化', 4, 'FINISHED', 62, 62, 0, NULL, NULL, NULL, '2026-06-11 23:30:21', 'admin', '2026-06-09 12:54:11', '', '2026-06-11 23:30:20', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (75, 31, '组装', 5, 'FINISHED', 62, 62, 0, NULL, NULL, NULL, '2026-06-11 23:30:21', 'admin', '2026-06-09 12:54:11', '', '2026-06-11 23:30:20', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (76, 31, '功能检测', 6, 'FINISHED', 62, 62, 0, NULL, NULL, NULL, '2026-06-11 23:30:21', 'admin', '2026-06-09 12:54:11', '', '2026-06-11 23:30:20', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (77, 31, '包装入库', 7, 'FINISHED', 62, 62, 0, NULL, NULL, NULL, '2026-06-11 23:30:21', 'admin', '2026-06-09 12:54:11', '', '2026-06-11 23:30:20', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (78, 32, '原材料领料', 1, 'FINISHED', 150, 150, 0, NULL, NULL, NULL, '2026-06-09 13:26:04', 'admin', '2026-06-09 13:26:03', '', '2026-06-09 13:26:03', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (79, 32, 'CNC加工', 2, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 13:26:04', '2026-06-09 13:26:04', 'admin', '2026-06-09 13:26:03', '', '2026-06-09 13:26:03', NULL, 'TestOperator', 'VisionInspector', 'Material-Step2');
INSERT INTO `mes_process_task` VALUES (80, 32, '打磨处理', 3, 'FINISHED', 150, 14, 1, NULL, NULL, '2026-06-09 13:26:04', '2026-06-09 13:26:04', 'admin', '2026-06-09 13:26:03', '', '2026-06-09 13:26:04', NULL, 'TestOperator', 'VisionInspector', 'Material-Step3');
INSERT INTO `mes_process_task` VALUES (81, 32, '喷砂/氧化', 4, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 13:26:04', '2026-06-09 13:26:05', 'admin', '2026-06-09 13:26:03', '', '2026-06-09 13:26:04', NULL, 'TestOperator', 'AssemblyLine#1', 'Material-Step4');
INSERT INTO `mes_process_task` VALUES (82, 32, '组装', 5, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 13:26:05', '2026-06-09 13:26:05', 'admin', '2026-06-09 13:26:03', '', '2026-06-09 13:26:04', NULL, 'TestOperator', 'VisionInspector', 'Material-Step5');
INSERT INTO `mes_process_task` VALUES (83, 32, '功能检测', 6, 'FINISHED', 150, 14, 1, NULL, NULL, '2026-06-09 13:26:05', '2026-06-09 13:26:05', 'admin', '2026-06-09 13:26:03', '', '2026-06-09 13:26:05', NULL, 'TestOperator', 'VisionInspector', 'Material-Step6');
INSERT INTO `mes_process_task` VALUES (84, 32, '包装入库', 7, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 13:26:06', '2026-06-09 13:26:06', 'admin', '2026-06-09 13:26:03', '', '2026-06-09 13:26:05', NULL, 'TestOperator', 'VisionInspector', 'Material-Step7');
INSERT INTO `mes_process_task` VALUES (85, 33, '原材料领料', 1, 'FINISHED', 150, 150, 0, NULL, NULL, NULL, '2026-06-09 13:27:11', 'admin', '2026-06-09 13:27:10', '', '2026-06-09 13:27:10', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (86, 33, 'CNC加工', 2, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 13:27:11', '2026-06-09 13:27:11', 'admin', '2026-06-09 13:27:10', '', '2026-06-09 13:27:11', NULL, 'TestOperator', 'VisionInspector', 'Material-Step2');
INSERT INTO `mes_process_task` VALUES (87, 33, '打磨处理', 3, 'FINISHED', 150, 14, 1, NULL, NULL, '2026-06-09 13:27:11', '2026-06-09 13:27:11', 'admin', '2026-06-09 13:27:10', '', '2026-06-09 13:27:11', NULL, 'TestOperator', 'VisionInspector', 'Material-Step3');
INSERT INTO `mes_process_task` VALUES (88, 33, '喷砂/氧化', 4, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 13:27:12', '2026-06-09 13:27:12', 'admin', '2026-06-09 13:27:10', '', '2026-06-09 13:27:11', NULL, 'TestOperator', 'AssemblyLine#1', 'Material-Step4');
INSERT INTO `mes_process_task` VALUES (89, 33, '组装', 5, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 13:27:12', '2026-06-09 13:27:12', 'admin', '2026-06-09 13:27:10', '', '2026-06-09 13:27:12', NULL, 'TestOperator', 'VisionInspector', 'Material-Step5');
INSERT INTO `mes_process_task` VALUES (90, 33, '功能检测', 6, 'FINISHED', 150, 14, 1, NULL, NULL, '2026-06-09 13:27:13', '2026-06-09 13:27:13', 'admin', '2026-06-09 13:27:10', '', '2026-06-09 13:27:12', NULL, 'TestOperator', 'VisionInspector', 'Material-Step6');
INSERT INTO `mes_process_task` VALUES (91, 33, '包装入库', 7, 'FINISHED', 150, 14, 0, NULL, NULL, '2026-06-09 13:27:13', '2026-06-09 13:27:13', 'admin', '2026-06-09 13:27:10', '', '2026-06-09 13:27:13', NULL, 'TestOperator', 'VisionInspector', 'Material-Step7');
INSERT INTO `mes_process_task` VALUES (92, 34, '原材料领料', 1, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-10 10:29:45', 'admin', '2026-06-10 10:28:41', '', '2026-06-10 10:29:44', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (93, 34, 'CNC加工', 2, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-10 10:30:18', 'admin', '2026-06-10 10:28:41', '', '2026-06-10 10:30:17', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (94, 34, '打磨处理', 3, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-10 10:30:18', 'admin', '2026-06-10 10:28:41', '', '2026-06-10 10:30:17', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (95, 34, '喷砂/氧化', 4, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-10 10:30:18', 'admin', '2026-06-10 10:28:41', '', '2026-06-10 10:30:17', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (96, 34, '组装', 5, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-10 10:30:18', 'admin', '2026-06-10 10:28:41', '', '2026-06-10 10:30:17', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (97, 34, '功能检测', 6, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-10 10:30:18', 'admin', '2026-06-10 10:28:41', '', '2026-06-10 10:30:17', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (98, 34, '包装入库', 7, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-10 10:30:18', 'admin', '2026-06-10 10:28:41', '', '2026-06-10 10:30:17', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (99, 35, '原材料领料', 1, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-11 21:45:19', 'admin', '2026-06-11 21:44:57', '', '2026-06-11 21:45:19', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (100, 35, 'CNC加工', 2, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-11 21:45:35', 'admin', '2026-06-11 21:44:57', '', '2026-06-11 21:45:35', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (101, 35, '打磨处理', 3, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-11 21:45:35', 'admin', '2026-06-11 21:44:57', '', '2026-06-11 21:45:35', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (102, 35, '喷砂/氧化', 4, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-11 21:45:35', 'admin', '2026-06-11 21:44:57', '', '2026-06-11 21:45:35', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (103, 35, '组装', 5, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-11 21:45:35', 'admin', '2026-06-11 21:44:57', '', '2026-06-11 21:45:35', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (104, 35, '功能检测', 6, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-11 21:45:35', 'admin', '2026-06-11 21:44:57', '', '2026-06-11 21:45:35', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (105, 35, '包装入库', 7, 'FINISHED', 61, 61, 0, NULL, NULL, NULL, '2026-06-11 21:45:35', 'admin', '2026-06-11 21:44:57', '', '2026-06-11 21:45:35', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (106, 36, '原材料领料', 1, 'FINISHED', 1050, 1050, 0, NULL, NULL, NULL, '2026-06-11 23:28:40', 'admin', '2026-06-11 23:27:20', '', '2026-06-11 23:28:40', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (107, 36, 'CNC加工', 2, 'FINISHED', 1050, 1050, 0, NULL, NULL, NULL, '2026-06-11 23:28:40', 'admin', '2026-06-11 23:27:20', '', '2026-06-11 23:28:40', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (108, 36, '打磨处理', 3, 'FINISHED', 1050, 1050, 0, NULL, NULL, NULL, '2026-06-11 23:28:40', 'admin', '2026-06-11 23:27:20', '', '2026-06-11 23:28:40', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (109, 36, '喷砂/氧化', 4, 'FINISHED', 1050, 1050, 0, NULL, NULL, NULL, '2026-06-11 23:28:40', 'admin', '2026-06-11 23:27:20', '', '2026-06-11 23:28:40', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (110, 36, '组装', 5, 'FINISHED', 1050, 1050, 0, NULL, NULL, NULL, '2026-06-11 23:28:40', 'admin', '2026-06-11 23:27:20', '', '2026-06-11 23:28:40', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (111, 36, '功能检测', 6, 'FINISHED', 1050, 1050, 0, NULL, NULL, NULL, '2026-06-11 23:28:40', 'admin', '2026-06-11 23:27:20', '', '2026-06-11 23:28:40', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (112, 36, '包装入库', 7, 'FINISHED', 1050, 1050, 0, NULL, NULL, NULL, '2026-06-11 23:28:40', 'admin', '2026-06-11 23:27:20', '', '2026-06-11 23:28:40', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (113, 37, '原材料领料', 1, 'FINISHED', 82, 82, 0, NULL, NULL, NULL, '2026-06-12 08:43:19', 'admin', '2026-06-12 08:43:03', '', '2026-06-12 08:43:18', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (114, 37, 'CNC加工', 2, 'FINISHED', 82, 82, 0, NULL, NULL, NULL, '2026-06-12 08:43:29', 'admin', '2026-06-12 08:43:03', '', '2026-06-12 08:43:29', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (115, 37, '打磨处理', 3, 'FINISHED', 82, 82, 0, NULL, NULL, NULL, '2026-06-12 08:43:29', 'admin', '2026-06-12 08:43:03', '', '2026-06-12 08:43:29', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (116, 37, '喷砂/氧化', 4, 'FINISHED', 82, 82, 0, NULL, NULL, NULL, '2026-06-12 08:43:29', 'admin', '2026-06-12 08:43:03', '', '2026-06-12 08:43:29', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (117, 37, '组装', 5, 'FINISHED', 82, 82, 0, NULL, NULL, NULL, '2026-06-12 08:43:29', 'admin', '2026-06-12 08:43:03', '', '2026-06-12 08:43:29', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (118, 37, '功能检测', 6, 'FINISHED', 82, 82, 0, NULL, NULL, NULL, '2026-06-12 08:43:29', 'admin', '2026-06-12 08:43:03', '', '2026-06-12 08:43:29', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (119, 37, '包装入库', 7, 'FINISHED', 82, 82, 0, NULL, NULL, NULL, '2026-06-12 08:43:29', 'admin', '2026-06-12 08:43:03', '', '2026-06-12 08:43:29', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (120, 38, '原材料领料', 1, 'FINISHED', 73, 73, 0, NULL, NULL, NULL, '2026-06-12 08:52:25', 'admin', '2026-06-12 08:52:14', '', '2026-06-12 08:52:25', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (121, 38, 'CNC加工', 2, 'FINISHED', 73, 73, 0, NULL, NULL, NULL, '2026-06-12 08:52:38', 'admin', '2026-06-12 08:52:14', '', '2026-06-12 08:52:37', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (122, 38, '打磨处理', 3, 'FINISHED', 73, 73, 0, NULL, NULL, NULL, '2026-06-12 08:52:38', 'admin', '2026-06-12 08:52:14', '', '2026-06-12 08:52:37', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (123, 38, '喷砂/氧化', 4, 'FINISHED', 73, 73, 0, NULL, NULL, NULL, '2026-06-12 08:52:38', 'admin', '2026-06-12 08:52:14', '', '2026-06-12 08:52:37', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (124, 38, '组装', 5, 'FINISHED', 73, 73, 0, NULL, NULL, NULL, '2026-06-12 08:52:38', 'admin', '2026-06-12 08:52:14', '', '2026-06-12 08:52:37', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (125, 38, '功能检测', 6, 'FINISHED', 73, 73, 0, NULL, NULL, NULL, '2026-06-12 08:52:38', 'admin', '2026-06-12 08:52:14', '', '2026-06-12 08:52:37', NULL, NULL, NULL, NULL);
INSERT INTO `mes_process_task` VALUES (126, 38, '包装入库', 7, 'FINISHED', 73, 73, 0, NULL, NULL, NULL, '2026-06-12 08:52:38', 'admin', '2026-06-12 08:52:14', '', '2026-06-12 08:52:37', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mes_production_line
-- ----------------------------
DROP TABLE IF EXISTS `mes_production_line`;
CREATE TABLE `mes_production_line`  (
  `line_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `line_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `line_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'ACTIVE',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  PRIMARY KEY (`line_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_production_line
-- ----------------------------
INSERT INTO `mes_production_line` VALUES (1, 'L-01', '注塑产线#1', 'ABS/PC注塑成型产线', 'ACTIVE', '', '2026-06-02 15:29:21', '', '2026-06-02 15:29:21', '');
INSERT INTO `mes_production_line` VALUES (2, 'L-02', '注塑产线#2', '精密注塑产线', 'ACTIVE', '', '2026-06-02 15:29:21', '', '2026-06-02 15:29:21', '');
INSERT INTO `mes_production_line` VALUES (3, 'L-03', '五金加工产线', '弹簧绕制/CNC加工产线', 'ACTIVE', '', '2026-06-02 15:29:21', '', '2026-06-02 15:29:21', '');
INSERT INTO `mes_production_line` VALUES (4, 'L-04', '硅胶成型产线', '硅胶硫化成型产线', 'ACTIVE', '', '2026-06-02 15:29:21', '', '2026-06-02 15:29:21', '');
INSERT INTO `mes_production_line` VALUES (5, 'L-05', '组装产线#1', '自动组装主线', 'ACTIVE', '', '2026-06-02 15:29:21', '', '2026-06-02 15:29:21', '');
INSERT INTO `mes_production_line` VALUES (6, 'L-06', '组装产线#2', '半自动组装副线', 'ACTIVE', '', '2026-06-02 15:29:21', '', '2026-06-02 15:29:21', '');
INSERT INTO `mes_production_line` VALUES (7, 'L-07', '包装产线', '自动包装产线', 'ACTIVE', '', '2026-06-02 15:29:21', '', '2026-06-02 15:29:21', '');

-- ----------------------------
-- Table structure for mes_production_schedule
-- ----------------------------
DROP TABLE IF EXISTS `mes_production_schedule`;
CREATE TABLE `mes_production_schedule`  (
  `schedule_id` bigint NOT NULL AUTO_INCREMENT COMMENT '排程ID',
  `schedule_seq` int NOT NULL DEFAULT 0 COMMENT '排程序号',
  `work_order_id` bigint NULL DEFAULT NULL,
  `work_order_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `product_id` bigint NULL DEFAULT NULL,
  `product_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `plan_id` bigint NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT 0,
  `priority` int NULL DEFAULT 0,
  `estimated_start` datetime NULL DEFAULT NULL,
  `estimated_end` datetime NULL DEFAULT NULL,
  `actual_start` datetime NULL DEFAULT NULL,
  `actual_end` datetime NULL DEFAULT NULL,
  `schedule_status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '待执行',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`schedule_id`) USING BTREE,
  INDEX `idx_work_order_id`(`work_order_id` ASC) USING BTREE,
  INDEX `idx_schedule_status`(`schedule_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单排程表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_production_schedule
-- ----------------------------
INSERT INTO `mes_production_schedule` VALUES (2, 1, 1, 'WO20260501001', NULL, NULL, NULL, 500, 99, '2026-06-09 10:54:09', '2026-06-10 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (3, 2, 2, 'WO20260502001', NULL, NULL, NULL, 300, 99, '2026-06-10 10:54:09', '2026-06-11 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (4, 3, 3, 'WO20260503001', NULL, NULL, NULL, 200, 99, '2026-06-11 10:54:09', '2026-06-12 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (5, 4, 4, 'WO20260504001', NULL, NULL, NULL, 400, 99, '2026-06-12 10:54:09', '2026-06-13 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (6, 5, 5, 'WO20260505001', NULL, NULL, NULL, 180, 99, '2026-06-13 10:54:09', '2026-06-14 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (7, 6, 6, 'WO20260506001', NULL, NULL, NULL, 250, 99, '2026-06-14 10:54:09', '2026-06-15 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (8, 7, 10, 'WO20260524001', NULL, NULL, NULL, 100, 99, '2026-06-15 10:54:09', '2026-06-16 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (9, 8, 7, 'WO20260507001', NULL, NULL, NULL, 160, 99, '2026-06-16 10:54:09', '2026-06-17 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (10, 9, 12, 'WO20260525001', NULL, NULL, NULL, 50, 99, '2026-06-17 10:54:09', '2026-06-18 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (11, 10, 13, 'WO20260525002', NULL, NULL, NULL, 60, 99, '2026-06-18 10:54:09', '2026-06-19 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (12, 11, 8, 'WO20260508001', NULL, NULL, NULL, 120, 99, '2026-06-19 10:54:09', '2026-06-20 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (13, 12, 11, 'WO20260524002', NULL, NULL, NULL, 80, 99, '2026-06-20 10:54:09', '2026-06-21 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (14, 13, 9, 'WO20260509001', NULL, NULL, NULL, 220, 99, '2026-06-21 10:54:09', '2026-06-22 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (15, 14, 17, 'WO20260527002', NULL, NULL, NULL, 150, 99, '2026-06-22 10:54:09', '2026-06-23 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (16, 15, 14, 'WO20260526001', NULL, NULL, NULL, 40, 99, '2026-06-23 10:54:09', '2026-06-24 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (17, 16, 15, 'WO20260526002', NULL, NULL, NULL, 70, 99, '2026-06-24 10:54:09', '2026-06-25 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (18, 17, 19, 'WO20260528002', NULL, NULL, NULL, 50, 99, '2026-06-25 10:54:09', '2026-06-26 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (19, 18, 16, 'WO20260527001', NULL, NULL, NULL, 100, 99, '2026-06-26 10:54:09', '2026-06-27 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (20, 19, 18, 'WO20260528001', NULL, NULL, NULL, 200, 99, '2026-06-27 10:54:09', '2026-06-28 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (21, 20, 20, 'WO20260529001', NULL, NULL, NULL, 80, 99, '2026-06-28 10:54:09', '2026-06-29 10:54:09', NULL, NULL, '待执行', 'admin', '2026-06-09 10:54:08', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (27, 21, 28, 'WO20260609122444', 1, '桌面手机支架Pro', 6, 150, 99, '2026-06-09 12:24:45', '2026-06-10 12:24:45', NULL, NULL, '待执行', 'admin', '2026-06-09 12:24:45', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (28, 22, 29, 'WO20260609124641', 1, '桌面手机支架Pro', 7, 150, 99, '2026-06-09 12:46:42', '2026-06-10 12:46:42', NULL, NULL, '待执行', 'admin', '2026-06-09 12:46:41', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (29, 23, 30, 'WO20260609124900', 3, '折叠便携手机支架', 8, 184, 99, '2026-06-09 12:49:01', '2026-06-10 12:49:01', NULL, NULL, '待执行', 'admin', '2026-06-09 12:49:00', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (30, 1, 1, 'WO20260501001', NULL, NULL, NULL, 500, 99, '2026-06-09 12:50:16', '2026-06-10 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (31, 2, 2, 'WO20260502001', NULL, NULL, NULL, 300, 99, '2026-06-10 12:50:16', '2026-06-11 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (32, 3, 3, 'WO20260503001', NULL, NULL, NULL, 200, 99, '2026-06-11 12:50:16', '2026-06-12 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (33, 4, 4, 'WO20260504001', NULL, NULL, NULL, 400, 99, '2026-06-12 12:50:16', '2026-06-13 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (34, 5, 5, 'WO20260505001', NULL, NULL, NULL, 180, 99, '2026-06-13 12:50:16', '2026-06-14 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (35, 6, 6, 'WO20260506001', NULL, NULL, NULL, 250, 99, '2026-06-14 12:50:16', '2026-06-15 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (36, 7, 10, 'WO20260524001', NULL, NULL, NULL, 100, 99, '2026-06-15 12:50:16', '2026-06-16 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (37, 8, 7, 'WO20260507001', NULL, NULL, NULL, 160, 99, '2026-06-16 12:50:16', '2026-06-17 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (38, 9, 12, 'WO20260525001', NULL, NULL, NULL, 50, 99, '2026-06-17 12:50:16', '2026-06-18 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (39, 10, 13, 'WO20260525002', NULL, NULL, NULL, 60, 99, '2026-06-18 12:50:16', '2026-06-19 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (40, 11, 8, 'WO20260508001', NULL, NULL, NULL, 120, 99, '2026-06-19 12:50:16', '2026-06-20 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (41, 12, 11, 'WO20260524002', NULL, NULL, NULL, 80, 99, '2026-06-20 12:50:16', '2026-06-21 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (42, 13, 9, 'WO20260509001', NULL, NULL, NULL, 220, 99, '2026-06-21 12:50:16', '2026-06-22 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (43, 14, 17, 'WO20260527002', NULL, NULL, NULL, 150, 99, '2026-06-22 12:50:16', '2026-06-23 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (44, 15, 14, 'WO20260526001', NULL, NULL, NULL, 40, 99, '2026-06-23 12:50:16', '2026-06-24 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (45, 16, 15, 'WO20260526002', NULL, NULL, NULL, 70, 99, '2026-06-24 12:50:16', '2026-06-25 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (46, 17, 19, 'WO20260528002', NULL, NULL, NULL, 50, 99, '2026-06-25 12:50:16', '2026-06-26 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (47, 18, 16, 'WO20260527001', NULL, NULL, NULL, 100, 99, '2026-06-26 12:50:16', '2026-06-27 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (48, 19, 18, 'WO20260528001', NULL, NULL, NULL, 200, 99, '2026-06-27 12:50:16', '2026-06-28 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (49, 20, 20, 'WO20260529001', NULL, NULL, NULL, 80, 99, '2026-06-28 12:50:16', '2026-06-29 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (50, 21, 28, 'WO20260609122444', 1, '桌面手机支架Pro', 6, 150, 2, '2026-06-29 12:50:16', '2026-06-30 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (51, 22, 29, 'WO20260609124641', 1, '桌面手机支架Pro', 7, 150, 2, '2026-06-30 12:50:16', '2026-07-01 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (52, 23, 30, 'WO20260609124900', 3, '折叠便携手机支架', 8, 184, 2, '2026-07-01 12:50:16', '2026-07-02 12:50:16', NULL, NULL, '待执行', 'admin', '2026-06-09 12:50:15', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (53, 47, 31, 'WO20260609125411', 4, '无线充电手机支架', 9, 62, 99, '2026-06-09 12:54:12', '2026-06-10 12:54:12', NULL, NULL, '待执行', 'admin', '2026-06-09 12:54:11', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (54, 48, 32, 'WO20260609132603', 1, '桌面手机支架Pro', 10, 150, 99, '2026-06-09 13:26:03', '2026-06-10 13:26:03', NULL, NULL, '待执行', 'admin', '2026-06-09 13:26:03', NULL, NULL, NULL);
INSERT INTO `mes_production_schedule` VALUES (55, 49, 33, 'WO20260609132710', 1, '桌面手机支架Pro', 11, 150, 99, '2026-06-09 13:27:11', '2026-06-10 13:27:11', NULL, NULL, '待执行', 'admin', '2026-06-09 13:27:10', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mes_quality_record
-- ----------------------------
DROP TABLE IF EXISTS `mes_quality_record`;
CREATE TABLE `mes_quality_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `work_order_id` bigint NULL DEFAULT NULL COMMENT '工单ID',
  `product_id` bigint NULL DEFAULT NULL COMMENT '产品ID',
  `check_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '检验类型',
  `quantity` int NULL DEFAULT 0 COMMENT '检验数量',
  `defect_quantity` int NULL DEFAULT 0 COMMENT '不良数量',
  `result` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '检验结果',
  `inspector` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '检验员',
  `check_time` datetime NULL DEFAULT NULL COMMENT '检验时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_work_order_id`(`work_order_id` ASC) USING BTREE,
  INDEX `idx_product_id`(`product_id` ASC) USING BTREE,
  INDEX `idx_result`(`result` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '质检记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_quality_record
-- ----------------------------
INSERT INTO `mes_quality_record` VALUES (1, 34, 4, '成品检验', 21, 1, 'PASS', 'z', '2026-06-11 21:41:30', 'admin', '2026-06-11 21:41:43', NULL, NULL, NULL);
INSERT INTO `mes_quality_record` VALUES (2, 35, 4, '成品检验', 10, 1, 'PASS', 'z', '2026-06-11 21:46:16', 'admin', '2026-06-11 21:46:26', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mes_quality_trace
-- ----------------------------
DROP TABLE IF EXISTS `mes_quality_trace`;
CREATE TABLE `mes_quality_trace`  (
  `trace_id` bigint NOT NULL AUTO_INCREMENT,
  `trace_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `trace_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `product_id` bigint NULL DEFAULT NULL,
  `product_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `plan_id` bigint NULL DEFAULT NULL,
  `plan_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `order_id` bigint NULL DEFAULT NULL,
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `work_order_id` bigint NULL DEFAULT NULL,
  `work_order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `batch_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `raw_batch_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `production_date` date NULL DEFAULT NULL,
  `inspector` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `inspect_result` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `trace_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  PRIMARY KEY (`trace_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_quality_trace
-- ----------------------------
INSERT INTO `mes_quality_trace` VALUES (26, 'PROCESS', 'TASK-51', NULL, 'CNC加工', NULL, NULL, NULL, NULL, 28, 'WO20260609122444', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', NULL, '2026-06-09 12:24:45', '工序:CNC加工 良品:14 次品:0');
INSERT INTO `mes_quality_trace` VALUES (27, 'PROCESS', 'TASK-52', NULL, '打磨处理', NULL, NULL, NULL, NULL, 28, 'WO20260609122444', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', NULL, '2026-06-09 12:24:45', '工序:打磨处理 良品:14 次品:1');
INSERT INTO `mes_quality_trace` VALUES (28, 'PROCESS', 'TASK-53', NULL, '喷砂/氧化', NULL, NULL, NULL, NULL, 28, 'WO20260609122444', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', NULL, '2026-06-09 12:24:46', '工序:喷砂/氧化 良品:14 次品:0');
INSERT INTO `mes_quality_trace` VALUES (29, 'PROCESS', 'TASK-54', NULL, '组装', NULL, NULL, NULL, NULL, 28, 'WO20260609122444', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', NULL, '2026-06-09 12:24:46', '工序:组装 良品:14 次品:0');
INSERT INTO `mes_quality_trace` VALUES (30, 'PROCESS', 'TASK-55', NULL, '功能检测', NULL, NULL, NULL, NULL, 28, 'WO20260609122444', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', NULL, '2026-06-09 12:24:47', '工序:功能检测 良品:14 次品:1');
INSERT INTO `mes_quality_trace` VALUES (31, 'PROCESS', 'TASK-56', NULL, '包装入库', NULL, NULL, NULL, NULL, 28, 'WO20260609122444', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', NULL, '2026-06-09 12:24:47', '工序:包装入库 良品:14 次品:0');
INSERT INTO `mes_quality_trace` VALUES (32, 'PROCESS', 'TASK-57', NULL, '原材料领料', NULL, NULL, NULL, NULL, 29, 'WO20260609124641', NULL, NULL, '2026-06-09', 'admin', 'PASS', NULL, '2026-06-09 12:46:42', '工序:原材料领料 良品:150 次品:0');
INSERT INTO `mes_quality_trace` VALUES (33, 'PROCESS', 'TASK-58', NULL, 'CNC加工', NULL, NULL, NULL, NULL, 29, 'WO20260609124641', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"CNC加工\",\"工序序号\":2,\"开始时间\":\"2026-06-09 12:46:42\",\"结束时间\":\"2026-06-09 12:46:42\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step2\",\"良品数\":14,\"次品数\":0,\"良品率\":\"100.00%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 12:46:42', '工序:CNC加工 序号:2 良品:14 次品:0 良品率:100.00% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (34, 'PROCESS', 'TASK-59', NULL, '打磨处理', NULL, NULL, NULL, NULL, 29, 'WO20260609124641', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"打磨处理\",\"工序序号\":3,\"开始时间\":\"2026-06-09 12:46:43\",\"结束时间\":\"2026-06-09 12:46:42\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step3\",\"良品数\":14,\"次品数\":1,\"良品率\":\"93.33%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 12:46:42', '工序:打磨处理 序号:3 良品:14 次品:1 良品率:93.33% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (35, 'PROCESS', 'TASK-60', NULL, '喷砂/氧化', NULL, NULL, NULL, NULL, 29, 'WO20260609124641', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"喷砂/氧化\",\"工序序号\":4,\"开始时间\":\"2026-06-09 12:46:43\",\"结束时间\":\"2026-06-09 12:46:43\",\"操作员\":\"TestOperator\",\"设备\":\"AssemblyLine#1\",\"物料消耗\":\"Material-Step4\",\"良品数\":14,\"次品数\":0,\"良品率\":\"100.00%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 12:46:43', '工序:喷砂/氧化 序号:4 良品:14 次品:0 良品率:100.00% 操作:TestOperator 设备:AssemblyLine#1');
INSERT INTO `mes_quality_trace` VALUES (36, 'PROCESS', 'TASK-61', NULL, '组装', NULL, NULL, NULL, NULL, 29, 'WO20260609124641', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"组装\",\"工序序号\":5,\"开始时间\":\"2026-06-09 12:46:43\",\"结束时间\":\"2026-06-09 12:46:43\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step5\",\"良品数\":14,\"次品数\":0,\"良品率\":\"100.00%\",\"故障状态\":\"Yes\",\"故障描述\":\"Test fault: slight mold wear\"}', '2026-06-09 12:46:43', '工序:组装 序号:5 良品:14 次品:0 良品率:100.00% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (37, 'PROCESS', 'TASK-62', NULL, '功能检测', NULL, NULL, NULL, NULL, 29, 'WO20260609124641', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"功能检测\",\"工序序号\":6,\"开始时间\":\"2026-06-09 12:46:44\",\"结束时间\":\"2026-06-09 12:46:43\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step6\",\"良品数\":14,\"次品数\":1,\"良品率\":\"93.33%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 12:46:43', '工序:功能检测 序号:6 良品:14 次品:1 良品率:93.33% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (38, 'PROCESS', 'TASK-63', NULL, '包装入库', NULL, NULL, NULL, NULL, 29, 'WO20260609124641', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"包装入库\",\"工序序号\":7,\"开始时间\":\"2026-06-09 12:46:44\",\"结束时间\":\"2026-06-09 12:46:44\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step7\",\"良品数\":14,\"次品数\":0,\"良品率\":\"100.00%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 12:46:44', '工序:包装入库 序号:7 良品:14 次品:0 良品率:100.00% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (39, 'PROCESS', 'TASK-64', NULL, '原材料领料', NULL, NULL, NULL, NULL, 30, 'WO20260609124900', NULL, NULL, '2026-06-09', 'admin', 'PASS', NULL, '2026-06-09 12:49:21', '工序:原材料领料 良品:184 次品:0');
INSERT INTO `mes_quality_trace` VALUES (40, 'PROCESS', 'TASK-78', NULL, '原材料领料', NULL, NULL, NULL, NULL, 32, 'WO20260609132603', NULL, NULL, '2026-06-09', 'admin', 'PASS', NULL, '2026-06-09 13:26:03', '工序:原材料领料 良品:150 次品:0');
INSERT INTO `mes_quality_trace` VALUES (41, 'PROCESS', 'TASK-79', NULL, 'CNC加工', NULL, NULL, NULL, NULL, 32, 'WO20260609132603', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"CNC加工\",\"工序序号\":2,\"开始时间\":\"2026-06-09 13:26:04\",\"结束时间\":\"2026-06-09 13:26:03\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step2\",\"良品数\":14,\"次品数\":0,\"良品率\":\"100.00%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 13:26:03', '工序:CNC加工 序号:2 良品:14 次品:0 良品率:100.00% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (42, 'PROCESS', 'TASK-80', NULL, '打磨处理', NULL, NULL, NULL, NULL, 32, 'WO20260609132603', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"打磨处理\",\"工序序号\":3,\"开始时间\":\"2026-06-09 13:26:04\",\"结束时间\":\"2026-06-09 13:26:04\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step3\",\"良品数\":14,\"次品数\":1,\"良品率\":\"93.33%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 13:26:04', '工序:打磨处理 序号:3 良品:14 次品:1 良品率:93.33% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (43, 'PROCESS', 'TASK-81', NULL, '喷砂/氧化', NULL, NULL, NULL, NULL, 32, 'WO20260609132603', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"喷砂/氧化\",\"工序序号\":4,\"开始时间\":\"2026-06-09 13:26:04\",\"结束时间\":\"2026-06-09 13:26:04\",\"操作员\":\"TestOperator\",\"设备\":\"AssemblyLine#1\",\"物料消耗\":\"Material-Step4\",\"良品数\":14,\"次品数\":0,\"良品率\":\"100.00%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 13:26:04', '工序:喷砂/氧化 序号:4 良品:14 次品:0 良品率:100.00% 操作:TestOperator 设备:AssemblyLine#1');
INSERT INTO `mes_quality_trace` VALUES (44, 'PROCESS', 'TASK-82', NULL, '组装', NULL, NULL, NULL, NULL, 32, 'WO20260609132603', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"组装\",\"工序序号\":5,\"开始时间\":\"2026-06-09 13:26:05\",\"结束时间\":\"2026-06-09 13:26:04\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step5\",\"良品数\":14,\"次品数\":0,\"良品率\":\"100.00%\",\"故障状态\":\"Yes\",\"故障描述\":\"Test fault: slight mold wear\"}', '2026-06-09 13:26:04', '工序:组装 序号:5 良品:14 次品:0 良品率:100.00% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (45, 'PROCESS', 'TASK-83', NULL, '功能检测', NULL, NULL, NULL, NULL, 32, 'WO20260609132603', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"功能检测\",\"工序序号\":6,\"开始时间\":\"2026-06-09 13:26:05\",\"结束时间\":\"2026-06-09 13:26:05\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step6\",\"良品数\":14,\"次品数\":1,\"良品率\":\"93.33%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 13:26:05', '工序:功能检测 序号:6 良品:14 次品:1 良品率:93.33% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (46, 'PROCESS', 'TASK-84', NULL, '包装入库', NULL, NULL, NULL, NULL, 32, 'WO20260609132603', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"包装入库\",\"工序序号\":7,\"开始时间\":\"2026-06-09 13:26:06\",\"结束时间\":\"2026-06-09 13:26:05\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step7\",\"良品数\":14,\"次品数\":0,\"良品率\":\"100.00%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 13:26:05', '工序:包装入库 序号:7 良品:14 次品:0 良品率:100.00% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (47, 'PROCESS', 'TASK-85', NULL, '原材料领料', NULL, NULL, NULL, NULL, 33, 'WO20260609132710', NULL, NULL, '2026-06-09', 'admin', 'PASS', NULL, '2026-06-09 13:27:10', '工序:原材料领料 良品:150 次品:0');
INSERT INTO `mes_quality_trace` VALUES (48, 'PROCESS', 'TASK-86', NULL, 'CNC加工', NULL, NULL, NULL, NULL, 33, 'WO20260609132710', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"CNC加工\",\"工序序号\":2,\"开始时间\":\"2026-06-09 13:27:11\",\"结束时间\":\"2026-06-09 13:27:11\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step2\",\"良品数\":14,\"次品数\":0,\"良品率\":\"100.00%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 13:27:11', '工序:CNC加工 序号:2 良品:14 次品:0 良品率:100.00% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (49, 'PROCESS', 'TASK-87', NULL, '打磨处理', NULL, NULL, NULL, NULL, 33, 'WO20260609132710', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"打磨处理\",\"工序序号\":3,\"开始时间\":\"2026-06-09 13:27:11\",\"结束时间\":\"2026-06-09 13:27:11\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step3\",\"良品数\":14,\"次品数\":1,\"良品率\":\"93.33%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 13:27:11', '工序:打磨处理 序号:3 良品:14 次品:1 良品率:93.33% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (50, 'PROCESS', 'TASK-88', NULL, '喷砂/氧化', NULL, NULL, NULL, NULL, 33, 'WO20260609132710', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"喷砂/氧化\",\"工序序号\":4,\"开始时间\":\"2026-06-09 13:27:12\",\"结束时间\":\"2026-06-09 13:27:11\",\"操作员\":\"TestOperator\",\"设备\":\"AssemblyLine#1\",\"物料消耗\":\"Material-Step4\",\"良品数\":14,\"次品数\":0,\"良品率\":\"100.00%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 13:27:11', '工序:喷砂/氧化 序号:4 良品:14 次品:0 良品率:100.00% 操作:TestOperator 设备:AssemblyLine#1');
INSERT INTO `mes_quality_trace` VALUES (51, 'PROCESS', 'TASK-89', NULL, '组装', NULL, NULL, NULL, NULL, 33, 'WO20260609132710', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"组装\",\"工序序号\":5,\"开始时间\":\"2026-06-09 13:27:12\",\"结束时间\":\"2026-06-09 13:27:12\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step5\",\"良品数\":14,\"次品数\":0,\"良品率\":\"100.00%\",\"故障状态\":\"Yes\",\"故障描述\":\"Test fault: slight mold wear\"}', '2026-06-09 13:27:12', '工序:组装 序号:5 良品:14 次品:0 良品率:100.00% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (52, 'PROCESS', 'TASK-90', NULL, '功能检测', NULL, NULL, NULL, NULL, 33, 'WO20260609132710', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"功能检测\",\"工序序号\":6,\"开始时间\":\"2026-06-09 13:27:13\",\"结束时间\":\"2026-06-09 13:27:12\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step6\",\"良品数\":14,\"次品数\":1,\"良品率\":\"93.33%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 13:27:12', '工序:功能检测 序号:6 良品:14 次品:1 良品率:93.33% 操作:TestOperator 设备:VisionInspector');
INSERT INTO `mes_quality_trace` VALUES (53, 'PROCESS', 'TASK-91', NULL, '包装入库', NULL, NULL, NULL, NULL, 33, 'WO20260609132710', NULL, NULL, '2026-06-09', 'TestOperator', 'PASS', '{\"工序名称\":\"包装入库\",\"工序序号\":7,\"开始时间\":\"2026-06-09 13:27:13\",\"结束时间\":\"2026-06-09 13:27:13\",\"操作员\":\"TestOperator\",\"设备\":\"VisionInspector\",\"物料消耗\":\"Material-Step7\",\"良品数\":14,\"次品数\":0,\"良品率\":\"100.00%\",\"故障状态\":\"No\",\"故障描述\":\"\"}', '2026-06-09 13:27:13', '工序:包装入库 序号:7 良品:14 次品:0 良品率:100.00% 操作:TestOperator 设备:VisionInspector');

-- ----------------------------
-- Table structure for mes_report_record
-- ----------------------------
DROP TABLE IF EXISTS `mes_report_record`;
CREATE TABLE `mes_report_record`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '报工记录ID',
  `work_order_id` bigint NOT NULL COMMENT '工单ID',
  `work_order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工单编号',
  `process_task_id` bigint NULL DEFAULT NULL COMMENT '工序任务ID',
  `process_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工序名称',
  `process_seq` int NULL DEFAULT NULL COMMENT '工序序号',
  `quantity` int NOT NULL COMMENT '本次报工数量',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '进行中' COMMENT '报工状态（进行中/完成）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '报工人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '报工时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '报工记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_report_record
-- ----------------------------

-- ----------------------------
-- Table structure for mes_warehousing
-- ----------------------------
DROP TABLE IF EXISTS `mes_warehousing`;
CREATE TABLE `mes_warehousing`  (
  `warehousing_id` bigint NOT NULL AUTO_INCREMENT,
  `warehousing_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `work_order_id` bigint NOT NULL,
  `work_order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `plan_id` bigint NULL DEFAULT NULL,
  `product_id` bigint NULL DEFAULT NULL,
  `warehousing_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'FINISHED',
  `warehousing_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'WAITING',
  `inspector` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `inspect_result` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `warehousing_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `warehousing_time` datetime NULL DEFAULT NULL,
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  PRIMARY KEY (`warehousing_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_warehousing
-- ----------------------------
INSERT INTO `mes_warehousing` VALUES (5, 'WH20260609122447', 28, 'WO20260609122444', 6, NULL, 'FINISHED', 'FINISHED', NULL, 'PASS', 'SYSTEM', '2026-06-09 12:24:48', '成品仓', 'SYSTEM', '2026-06-09 12:24:47', '', '2026-06-09 12:24:47', '');
INSERT INTO `mes_warehousing` VALUES (6, 'WH20260609124644', 29, 'WO20260609124641', 7, NULL, 'FINISHED', 'FINISHED', NULL, 'PASS', 'SYSTEM', '2026-06-09 12:46:44', '成品仓', 'SYSTEM', '2026-06-09 12:46:44', '', '2026-06-09 12:46:44', '');
INSERT INTO `mes_warehousing` VALUES (7, 'WH20260609125008', 30, 'WO20260609124900', 8, NULL, 'FINISHED', 'FINISHED', NULL, 'PASS', 'SYSTEM', '2026-06-09 12:50:09', '成品仓', 'SYSTEM', '2026-06-09 12:50:08', '', '2026-06-09 12:50:08', '');
INSERT INTO `mes_warehousing` VALUES (8, 'WH20260609132605', 32, 'WO20260609132603', 10, NULL, 'FINISHED', 'FINISHED', NULL, 'PASS', 'SYSTEM', '2026-06-09 13:26:06', '成品仓', 'SYSTEM', '2026-06-09 13:26:05', '', '2026-06-09 13:26:05', '');
INSERT INTO `mes_warehousing` VALUES (9, 'WH20260609132713', 33, 'WO20260609132710', 11, NULL, 'FINISHED', 'FINISHED', NULL, 'PASS', 'SYSTEM', '2026-06-09 13:27:13', '成品仓', 'SYSTEM', '2026-06-09 13:27:13', '', '2026-06-09 13:27:13', '');
INSERT INTO `mes_warehousing` VALUES (10, 'WH20260610103017', 34, 'WO20260610102841', 12, NULL, 'FINISHED', 'FINISHED', NULL, 'PASS', 'SYSTEM', '2026-06-10 10:30:18', '成品仓', 'SYSTEM', '2026-06-10 10:30:17', '', '2026-06-10 10:30:17', '');
INSERT INTO `mes_warehousing` VALUES (11, 'WH20260611214535', 35, 'WO20260611214457', 13, NULL, 'FINISHED', 'FINISHED', NULL, 'PASS', 'SYSTEM', '2026-06-11 21:45:35', '成品仓', 'SYSTEM', '2026-06-11 21:45:35', '', '2026-06-11 21:45:35', '');
INSERT INTO `mes_warehousing` VALUES (12, 'WH20260611232840', 36, 'WO20260611232720', 14, NULL, 'FINISHED', 'FINISHED', NULL, 'PASS', 'SYSTEM', '2026-06-11 23:28:40', '成品仓', 'SYSTEM', '2026-06-11 23:28:40', '', '2026-06-11 23:28:40', '');
INSERT INTO `mes_warehousing` VALUES (13, 'WH20260611233020', 31, 'WO20260609125411', 9, NULL, 'FINISHED', 'FINISHED', NULL, 'PASS', 'SYSTEM', '2026-06-11 23:30:21', '成品仓', 'SYSTEM', '2026-06-11 23:30:20', '', '2026-06-11 23:30:20', '');
INSERT INTO `mes_warehousing` VALUES (14, 'WH20260612084329', 37, 'WO20260612084303', 15, NULL, 'FINISHED', 'FINISHED', NULL, 'PASS', 'SYSTEM', '2026-06-12 08:43:29', '成品仓', 'SYSTEM', '2026-06-12 08:43:29', '', '2026-06-12 08:43:29', '');
INSERT INTO `mes_warehousing` VALUES (15, 'WH20260612085237', 38, 'WO20260612085214', 16, NULL, 'FINISHED', 'FINISHED', NULL, 'PASS', 'SYSTEM', '2026-06-12 08:52:38', '成品仓', 'SYSTEM', '2026-06-12 08:52:37', '', '2026-06-12 08:52:37', '');

-- ----------------------------
-- Table structure for mes_warehousing_detail
-- ----------------------------
DROP TABLE IF EXISTS `mes_warehousing_detail`;
CREATE TABLE `mes_warehousing_detail`  (
  `detail_id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `warehousing_id` bigint NOT NULL COMMENT '入库单ID',
  `product_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '产品编码',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `quantity` decimal(10, 2) NOT NULL COMMENT '入库数量',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单位',
  `batch_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '批次号',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '库位',
  `inspect_result` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '质检结果',
  PRIMARY KEY (`detail_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '入库单明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_warehousing_detail
-- ----------------------------
INSERT INTO `mes_warehousing_detail` VALUES (5, 5, 'P001', '桌面手机支架Pro', 14.00, '个', NULL, '成品仓', NULL);
INSERT INTO `mes_warehousing_detail` VALUES (6, 6, 'P001', '桌面手机支架Pro', 14.00, '个', NULL, '成品仓', NULL);
INSERT INTO `mes_warehousing_detail` VALUES (7, 7, 'P003', '折叠便携手机支架', 184.00, '个', NULL, '成品仓', NULL);
INSERT INTO `mes_warehousing_detail` VALUES (8, 8, 'P001', '桌面手机支架Pro', 14.00, '个', NULL, '成品仓', NULL);
INSERT INTO `mes_warehousing_detail` VALUES (9, 9, 'P001', '桌面手机支架Pro', 14.00, '个', NULL, '成品仓', NULL);
INSERT INTO `mes_warehousing_detail` VALUES (10, 10, 'P004', '无线充电手机支架', 61.00, '个', NULL, '成品仓', NULL);
INSERT INTO `mes_warehousing_detail` VALUES (11, 11, 'P004', '无线充电手机支架', 61.00, '个', NULL, '成品仓', NULL);
INSERT INTO `mes_warehousing_detail` VALUES (12, 12, 'P005', '多角度直播支架', 1050.00, '个', NULL, '成品仓', NULL);
INSERT INTO `mes_warehousing_detail` VALUES (13, 13, 'P004', '无线充电手机支架', 1.00, '个', NULL, '成品仓', NULL);
INSERT INTO `mes_warehousing_detail` VALUES (14, 14, 'P005', '多角度直播支架', 82.00, '个', NULL, '成品仓', NULL);
INSERT INTO `mes_warehousing_detail` VALUES (15, 15, 'P004', '无线充电手机支架', 73.00, '个', NULL, '成品仓', NULL);

-- ----------------------------
-- Table structure for mes_work_order_split
-- ----------------------------
DROP TABLE IF EXISTS `mes_work_order_split`;
CREATE TABLE `mes_work_order_split`  (
  `split_id` bigint NOT NULL AUTO_INCREMENT,
  `parent_work_order_id` bigint NOT NULL,
  `work_order_id` bigint NULL DEFAULT NULL,
  `split_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `line_id` bigint NULL DEFAULT NULL,
  `line_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `team_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `split_qty` int NOT NULL,
  `completed_qty` int NULL DEFAULT 0,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'WAITING',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  PRIMARY KEY (`split_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mes_work_order_split
-- ----------------------------

-- ----------------------------
-- Table structure for process_route
-- ----------------------------
DROP TABLE IF EXISTS `process_route`;
CREATE TABLE `process_route`  (
  `route_id` bigint NOT NULL AUTO_INCREMENT,
  `route_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '路线名称',
  `sort_no` int NULL DEFAULT 0,
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`route_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工艺路线' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of process_route
-- ----------------------------
INSERT INTO `process_route` VALUES (1, '手机支架标准工艺路线', 1, 'SYSTEM', '2026-06-02 11:36:28', NULL, '2026-06-02 11:36:28', NULL);

-- ----------------------------
-- Table structure for process_step
-- ----------------------------
DROP TABLE IF EXISTS `process_step`;
CREATE TABLE `process_step`  (
  `step_id` bigint NOT NULL AUTO_INCREMENT,
  `route_id` bigint NOT NULL COMMENT '所属路线ID',
  `step_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '步骤名称',
  `step_order` int NOT NULL COMMENT '步骤顺序',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`step_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工艺步骤' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of process_step
-- ----------------------------
INSERT INTO `process_step` VALUES (1, 1, '原材料领料', 1, 'SYSTEM', '2026-06-02 11:36:28', NULL, '2026-06-02 11:36:28', NULL);
INSERT INTO `process_step` VALUES (2, 1, 'CNC加工', 2, 'SYSTEM', '2026-06-02 11:36:28', NULL, '2026-06-02 11:36:28', NULL);
INSERT INTO `process_step` VALUES (3, 1, '打磨处理', 3, 'SYSTEM', '2026-06-02 11:36:28', NULL, '2026-06-02 11:36:28', NULL);
INSERT INTO `process_step` VALUES (4, 1, '喷砂/氧化', 4, 'SYSTEM', '2026-06-02 11:36:28', NULL, '2026-06-02 11:36:28', NULL);
INSERT INTO `process_step` VALUES (5, 1, '组装', 5, 'SYSTEM', '2026-06-02 11:36:28', NULL, '2026-06-02 11:36:28', NULL);
INSERT INTO `process_step` VALUES (6, 1, '功能检测', 6, 'SYSTEM', '2026-06-02 11:36:28', NULL, '2026-06-02 11:36:28', NULL);
INSERT INTO `process_step` VALUES (7, 1, '包装入库', 7, 'SYSTEM', '2026-06-02 11:36:28', NULL, '2026-06-02 11:36:28', NULL);

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `product_id` bigint NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `product_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品编码',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品名称',
  `specification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '规格',
  `product_model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品型号',
  `unit` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '单位',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`product_id`) USING BTREE,
  UNIQUE INDEX `uk_product_code`(`product_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '产品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, 'P001', '桌面手机支架Pro', '适用4-8寸手机/ABS+硅胶/多角度调节', NULL, '个', 'admin', '2026-06-09 10:34:15', '', NULL, '热销款');
INSERT INTO `product` VALUES (2, 'P002', '车载出风口手机支架', '适用4-7寸手机/弹簧夹持/360°旋转', NULL, '个', 'admin', '2026-06-09 10:34:15', '', NULL, '热销款');
INSERT INTO `product` VALUES (3, 'P003', '折叠便携手机支架', '铝合金材质/折叠式/超薄便携', NULL, '个', 'admin', '2026-06-09 10:34:15', '', NULL, '');
INSERT INTO `product` VALUES (4, 'P004', '无线充电手机支架', '支持Qi协议/15W快充/PC+硅胶', NULL, '个', 'admin', '2026-06-09 10:34:15', '', NULL, '新款');
INSERT INTO `product` VALUES (5, 'P005', '多角度直播支架', '桌面立式/360°旋转/高度可调', NULL, '个', 'admin', '2026-06-09 10:34:15', '', NULL, '');

-- ----------------------------
-- Table structure for production_plan
-- ----------------------------
DROP TABLE IF EXISTS `production_plan`;
CREATE TABLE `production_plan`  (
  `plan_id` bigint NOT NULL AUTO_INCREMENT COMMENT '计划ID',
  `plan_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计划编号',
  `sales_order_id` bigint NULL DEFAULT NULL COMMENT '销售订单ID',
  `customer_id` bigint NULL DEFAULT NULL COMMENT '客户ID',
  `product_id` bigint NULL DEFAULT NULL COMMENT '产品ID',
  `order_quantity` int NULL DEFAULT 0 COMMENT '订单数量',
  `inventory_quantity` int NULL DEFAULT 0 COMMENT '库存数量',
  `safe_stock` int NULL DEFAULT 0 COMMENT '安全库存',
  `required_quantity` int NULL DEFAULT 0 COMMENT '需求数量',
  `priority` int NULL DEFAULT 0 COMMENT '优先级(越小越高)',
  `is_urgent` tinyint NULL DEFAULT 0 COMMENT '是否紧急(0=否,1=是)',
  `planned_qty` int NULL DEFAULT 0 COMMENT '计划数量(旧字段，保留兼容)',
  `start_date` date NULL DEFAULT NULL,
  `end_date` date NULL DEFAULT NULL,
  `plan_status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '待排产' COMMENT '计划状态(待排产/已排产/生产中/已完成)',
  `plan_start_time` datetime NULL DEFAULT NULL COMMENT '计划开始时间',
  `plan_end_time` datetime NULL DEFAULT NULL COMMENT '计划结束时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `audit_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审核人',
  `audit_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `dispatch_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '下派人',
  `dispatch_time` datetime NULL DEFAULT NULL COMMENT '下派时间',
  PRIMARY KEY (`plan_id`) USING BTREE,
  UNIQUE INDEX `uk_plan_no`(`plan_no` ASC) USING BTREE,
  INDEX `idx_sales_order_id`(`sales_order_id` ASC) USING BTREE,
  INDEX `idx_product_id`(`product_id` ASC) USING BTREE,
  INDEX `idx_plan_status`(`plan_status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '生产计划表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of production_plan
-- ----------------------------
INSERT INTO `production_plan` VALUES (6, 'PP20260609122444', 26, 1, 1, 100, 0, 50, 150, 2, 0, 0, NULL, NULL, 'FINISHED', NULL, NULL, 'SYSTEM', '2026-06-09 12:24:44', 'admin', '2026-06-09 12:24:47', NULL, 'admin', '2026-06-09 12:24:45', 'admin', '2026-06-09 12:24:45');
INSERT INTO `production_plan` VALUES (7, 'PP20260609124641', 27, 1, 1, 100, 0, 50, 150, 2, 0, 0, NULL, NULL, 'FINISHED', NULL, NULL, 'SYSTEM', '2026-06-09 12:46:41', 'admin', '2026-06-09 12:46:44', NULL, 'admin', '2026-06-09 12:46:42', 'admin', '2026-06-09 12:46:42');
INSERT INTO `production_plan` VALUES (8, 'PP20260609124836', 28, 5, 3, 134, 0, 50, 184, 2, 0, 0, NULL, NULL, '已下派', NULL, NULL, 'SYSTEM', '2026-06-09 12:48:36', 'admin', '2026-06-09 12:49:00', NULL, 'admin', '2026-06-09 12:48:50', 'admin', '2026-06-09 12:49:01');
INSERT INTO `production_plan` VALUES (9, 'PP20260609125320', 29, 3, 4, 12, 0, 50, 62, 2, 0, 0, NULL, NULL, '已下派', NULL, NULL, 'SYSTEM', '2026-06-09 12:53:21', 'admin', '2026-06-09 12:54:11', NULL, 'admin', '2026-06-09 12:53:37', 'admin', '2026-06-09 12:54:12');
INSERT INTO `production_plan` VALUES (10, 'PP20260609132602', 30, 1, 1, 100, 0, 50, 150, 2, 0, 0, NULL, NULL, 'FINISHED', NULL, NULL, 'SYSTEM', '2026-06-09 13:26:02', 'admin', '2026-06-09 13:26:05', NULL, 'admin', '2026-06-09 13:26:03', 'admin', '2026-06-09 13:26:03');
INSERT INTO `production_plan` VALUES (11, 'PP20260609132710', 31, 1, 1, 100, 0, 50, 150, 2, 0, 0, NULL, NULL, 'FINISHED', NULL, NULL, 'SYSTEM', '2026-06-09 13:27:10', 'admin', '2026-06-09 13:27:13', NULL, 'admin', '2026-06-09 13:27:11', 'admin', '2026-06-09 13:27:11');
INSERT INTO `production_plan` VALUES (12, 'PP20260610102805', 32, 3, 4, 11, 0, 50, 61, 2, 0, 0, NULL, NULL, '已排产', '2026-06-11 10:28:06', '2026-06-12 10:28:06', 'SYSTEM', '2026-06-10 10:28:05', 'admin', '2026-06-10 10:28:42', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `production_plan` VALUES (13, 'PP20260611214427', 33, 4, 4, 11, 0, 50, 61, 2, 0, 0, NULL, NULL, '已排产', '2026-06-12 21:44:27', '2026-06-13 21:44:27', 'SYSTEM', '2026-06-11 21:44:27', 'admin', '2026-06-11 21:44:57', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `production_plan` VALUES (14, 'PP20260611232604', 34, 4, 5, 1000, 0, 50, 1050, 2, 1, 0, NULL, NULL, '已排产', '2026-06-12 23:26:05', '2026-06-13 23:26:05', 'SYSTEM', '2026-06-11 23:26:04', 'admin', '2026-06-11 23:27:20', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `production_plan` VALUES (15, 'PP20260612084222', 35, 4, 5, 32, 0, 50, 82, 2, 0, 0, NULL, NULL, '已排产', '2026-06-13 08:42:23', '2026-06-14 08:42:23', 'SYSTEM', '2026-06-12 08:42:22', 'admin', '2026-06-12 08:43:03', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `production_plan` VALUES (16, 'PP20260612085206', 36, 4, 4, 23, 0, 50, 73, 2, 0, 0, NULL, NULL, '已排产', '2026-06-13 08:52:06', '2026-06-14 08:52:06', 'SYSTEM', '2026-06-12 08:52:06', 'admin', '2026-06-12 08:52:14', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `production_plan` VALUES (17, 'PP20260612085911', 37, 5, 4, 11, 0, 50, 61, 2, 0, 0, NULL, NULL, '已审核', '2026-06-13 09:02:32', '2026-06-14 09:02:32', 'SYSTEM', '2026-06-12 08:59:11', 'SYSTEM', '2026-06-12 09:02:32', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `production_plan` VALUES (18, 'PP20260612090232', 38, 4, 3, 11, 0, 50, 61, 2, 0, 0, NULL, NULL, '已审核', '2026-06-14 09:02:32', '2026-06-15 09:02:32', 'SYSTEM', '2026-06-12 09:02:32', 'SYSTEM', '2026-06-12 09:02:32', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for production_report
-- ----------------------------
DROP TABLE IF EXISTS `production_report`;
CREATE TABLE `production_report`  (
  `report_id` bigint NOT NULL AUTO_INCREMENT COMMENT '报告ID',
  `work_order_id` bigint NULL DEFAULT NULL COMMENT '工单ID',
  `plan_id` bigint NULL DEFAULT NULL COMMENT '生产计划ID',
  `operator_id` bigint NULL DEFAULT NULL COMMENT '操作员ID',
  `equipment_id` bigint NULL DEFAULT NULL COMMENT '设备ID',
  `good_qty` int NULL DEFAULT NULL COMMENT '良品数量',
  `bad_qty` int NULL DEFAULT NULL COMMENT '不良品数量',
  `report_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '报告类型',
  `report_time` datetime NULL DEFAULT NULL COMMENT '报告时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `process_seq` int NULL DEFAULT NULL COMMENT '工序序号',
  `process_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '工序名称',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'REPORTED' COMMENT '状态',
  `inspector` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '质检人',
  `quality_result` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '质检结果',
  `quality_time` datetime NULL DEFAULT NULL COMMENT '质检时间',
  PRIMARY KEY (`report_id`) USING BTREE,
  INDEX `idx_report_workorder`(`work_order_id` ASC) USING BTREE,
  INDEX `idx_report_user`(`operator_id` ASC) USING BTREE,
  INDEX `idx_pr_plan_id`(`plan_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '生产报告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of production_report
-- ----------------------------
INSERT INTO `production_report` VALUES (1, 1, NULL, 1, 1, 120, 3, '完工', '2026-05-22 17:00:00', 'admin', '2026-05-22 17:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (2, 1, NULL, 1, 1, 115, 2, '完工', '2026-05-23 17:00:00', 'admin', '2026-05-23 17:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (3, 2, NULL, 1, 2, 75, 1, '完工', '2026-05-23 16:30:00', 'admin', '2026-05-23 16:30:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (4, 2, NULL, 1, 2, 72, 2, '完工', '2026-05-24 16:30:00', 'admin', '2026-05-24 16:30:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (5, 3, NULL, 2, 1, 50, 1, '完工', '2026-05-24 18:00:00', 'admin', '2026-05-24 18:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (6, 3, NULL, 2, 1, 48, 1, '完工', '2026-05-25 18:00:00', 'admin', '2026-05-25 18:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (7, 4, NULL, 2, 2, 100, 3, '完工', '2026-05-25 17:30:00', 'admin', '2026-05-25 17:30:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (8, 4, NULL, 2, 2, 95, 2, '完工', '2026-05-26 17:30:00', 'admin', '2026-05-26 17:30:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (9, 5, NULL, 1, 4, 40, 2, '完工', '2026-05-26 15:00:00', 'admin', '2026-05-26 15:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (10, 5, NULL, 1, 4, 38, 1, '完工', '2026-05-27 15:00:00', 'admin', '2026-05-27 15:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (11, 6, NULL, 2, 8, 30, 1, '完工', '2026-05-27 14:00:00', 'admin', '2026-05-27 14:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (12, 10, NULL, 1, 1, 25, 0, '完工', '2026-05-24 10:00:00', 'admin', '2026-05-24 10:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (13, 10, NULL, 1, 1, 24, 1, '完工', '2026-05-24 16:00:00', 'admin', '2026-05-24 16:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (14, 12, NULL, 2, 2, 25, 0, '完工', '2026-05-25 11:00:00', 'admin', '2026-05-25 11:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (15, 12, NULL, 2, 2, 23, 2, '完工', '2026-05-25 17:00:00', 'admin', '2026-05-25 17:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (16, 13, NULL, 3, 7, 30, 1, '完工', '2026-05-25 14:00:00', 'admin', '2026-05-25 14:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (17, 13, NULL, 3, 7, 28, 2, '完工', '2026-05-25 18:00:00', 'admin', '2026-05-25 18:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (18, 17, NULL, 1, 4, 75, 2, '完工', '2026-05-27 10:00:00', 'admin', '2026-05-27 10:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (19, 17, NULL, 1, 4, 73, 0, '完工', '2026-05-27 16:00:00', 'admin', '2026-05-27 16:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (20, 19, NULL, 2, 1, 25, 1, '完工', '2026-05-28 09:00:00', 'admin', '2026-05-28 09:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (21, 19, NULL, 2, 1, 24, 1, '完工', '2026-05-28 15:00:00', 'admin', '2026-05-28 15:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (22, 19, NULL, 2, 1, 25, 0, '完工', '2026-05-29 09:00:00', 'admin', '2026-05-29 09:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (23, 1, NULL, 1, 1, 118, 2, '完工', '2026-05-28 17:00:00', 'admin', '2026-05-28 17:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (24, 2, NULL, 1, 2, 70, 2, '完工', '2026-05-28 16:30:00', 'admin', '2026-05-28 16:30:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (25, 3, NULL, 2, 1, 47, 3, '完工', '2026-05-28 18:00:00', 'admin', '2026-05-28 18:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (26, 4, NULL, 2, 2, 98, 2, '完工', '2026-05-27 11:30:00', 'admin', '2026-05-27 11:30:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (27, 5, NULL, 1, 4, 38, 4, '完工', '2026-05-29 10:00:00', 'admin', '2026-05-29 10:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (28, 6, NULL, 2, 8, 30, 2, '完工', '2026-05-29 11:00:00', 'admin', '2026-05-29 11:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (29, 10, NULL, 1, 1, 26, 0, '完工', '2026-05-29 12:00:00', 'admin', '2026-05-29 12:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (30, 12, NULL, 2, 2, 28, 1, '完工', '2026-05-29 13:00:00', 'admin', '2026-05-29 13:00:00', '', NULL, '', NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (31, 35, NULL, NULL, 9, 61, 0, 'FINISH', '2026-06-11 23:31:08', 'admin', '2026-06-11 23:31:08', '', NULL, NULL, NULL, '', 'REPORTED', NULL, NULL, NULL);
INSERT INTO `production_report` VALUES (32, 37, NULL, NULL, 10, 82, 1, 'FINISH', '2026-06-12 09:28:39', 'admin', '2026-06-12 09:28:39', 'admin', '2026-06-12 09:55:37', NULL, NULL, '', 'INSPECTED', 'z', 'PASS', '2026-06-12 09:55:38');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sales_order
-- ----------------------------
DROP TABLE IF EXISTS `sales_order`;
CREATE TABLE `sales_order`  (
  `order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单编号',
  `customer_id` bigint NULL DEFAULT NULL COMMENT '客户ID',
  `product_id` bigint NULL DEFAULT NULL COMMENT '产品ID',
  `quantity` int NULL DEFAULT NULL COMMENT '数量',
  `due_date` date NULL DEFAULT NULL COMMENT '交期',
  `consignee` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货人',
  `consignee_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `delivery_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货地址',
  `order_status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '待处理' COMMENT '订单状态',
  `delivery_status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '未发货' COMMENT '发货状态',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `is_urgent` int NULL DEFAULT 0 COMMENT '是否紧急订单 0=普通 1=紧急',
  PRIMARY KEY (`order_id`) USING BTREE,
  UNIQUE INDEX `uk_order_no`(`order_no` ASC) USING BTREE,
  INDEX `idx_order_customer`(`customer_id` ASC) USING BTREE,
  INDEX `idx_order_product`(`product_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '销售订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sales_order
-- ----------------------------
INSERT INTO `sales_order` VALUES (1, 'SO20260501001', 1, 1, 500, '2026-05-15', '张总', '13800138001', '深圳市福田区华强北电子市场', 'COMPLETED', '已发货', 'admin', '2026-05-01 08:30:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (2, 'SO20260502001', 2, 2, 300, '2026-05-20', '李经理', '13800138002', '广州市越秀区永福路汽车用品城', 'COMPLETED', '已发货', 'admin', '2026-05-02 09:15:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (3, 'SO20260503001', 3, 3, 200, '2026-05-25', '王总', '13800138003', '东莞市虎门镇电商产业园', 'COMPLETED', '已发货', 'admin', '2026-05-03 10:00:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (4, 'SO20260504001', 4, 1, 400, '2026-05-28', '赵老板', '13800138004', '义乌市国际商贸城二期', 'COMPLETED', '已发货', 'admin', '2026-05-04 11:20:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (5, 'SO20260505001', 5, 4, 180, '2026-06-05', '刘总监', '13800138005', '杭州市滨江区物联网小镇', 'PRODUCING', '未发货', 'admin', '2026-05-05 13:45:00', '', NULL, '新品首单', 0);
INSERT INTO `sales_order` VALUES (6, 'SO20260506001', 1, 2, 250, '2026-06-10', '张总', '13800138001', '深圳市福田区华强北电子市场', 'PRODUCING', '未发货', 'admin', '2026-05-06 14:30:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (7, 'SO20260507001', 2, 3, 160, '2026-06-12', '李经理', '13800138002', '广州市越秀区永福路汽车用品城', 'CONFIRMED', '未发货', 'admin', '2026-05-07 15:00:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (8, 'SO20260508001', 3, 5, 120, '2026-06-15', '王总', '13800138003', '东莞市虎门镇电商产业园', 'CONFIRMED', '未发货', 'admin', '2026-05-08 16:20:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (9, 'SO20260509001', 4, 4, 220, '2026-06-18', '赵老板', '13800138004', '义乌市国际商贸城二期', 'PENDING', '未发货', 'admin', '2026-05-09 08:00:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (10, 'SO20260510001', 5, 1, 350, '2026-06-20', '刘总监', '13800138005', '杭州市滨江区物联网小镇', 'PENDING', '未发货', 'admin', '2026-05-10 09:30:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (11, 'SO20260511001', 1, 3, 180, '2026-06-22', '张总', '13800138001', '深圳市福田区华强北电子市场', 'PENDING', '未发货', 'admin', '2026-05-11 10:45:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (12, 'SO20260512001', 2, 5, 100, '2026-06-25', '李经理', '13800138002', '广州市越秀区永福路汽车用品城', 'PENDING', '未发货', 'admin', '2026-05-12 11:00:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (13, 'SO20260513001', 3, 1, 450, '2026-06-28', '王总', '13800138003', '东莞市虎门镇电商产业园', 'PENDING', '未发货', 'admin', '2026-05-13 13:15:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (14, 'SO20260514001', 4, 2, 280, '2026-07-02', '赵老板', '13800138004', '义乌市国际商贸城二期', 'PENDING', '未发货', 'admin', '2026-05-14 14:30:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (15, 'SO20260515001', 5, 3, 150, '2026-07-05', '刘总监', '13800138005', '杭州市滨江区物联网小镇', 'PENDING', '未发货', 'admin', '2026-05-15 15:45:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (16, 'SO20260516001', 1, 4, 200, '2026-07-08', '张总', '13800138001', '深圳市福田区华强北电子市场', 'PENDING', '未发货', 'admin', '2026-05-16 08:20:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (17, 'SO20260517001', 2, 1, 300, '2026-07-10', '李经理', '13800138002', '广州市越秀区永福路汽车用品城', 'PENDING', '未发货', 'admin', '2026-05-17 09:10:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (18, 'SO20260518001', 3, 2, 160, '2026-07-12', '王总', '13800138003', '东莞市虎门镇电商产业园', 'PENDING', '未发货', 'admin', '2026-05-18 10:30:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (19, 'SO20260519001', 4, 5, 90, '2026-07-15', '赵老板', '13800138004', '义乌市国际商贸城二期', 'PENDING', '未发货', 'admin', '2026-05-19 11:45:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (20, 'SO20260520001', 5, 3, 200, '2026-07-18', '刘总监', '13800138005', '杭州市滨江区物联网小镇', 'PENDING', '未发货', 'admin', '2026-05-20 13:00:00', '', NULL, '', 0);
INSERT INTO `sales_order` VALUES (26, 'SO20260609122444', 1, 1, 100, '2026-06-25', 'Test Receiver', '13800138000', 'Test Address', 'CONFIRMED', '未发货', 'admin', '2026-06-09 12:24:44', '', NULL, 'Auto test order', 0);
INSERT INTO `sales_order` VALUES (27, 'SO20260609124641', 1, 1, 100, '2026-06-25', 'Test Receiver', '13800138000', 'Test Address', '已完成', '未发货', 'admin', '2026-06-09 12:46:41', 'SYSTEM', '2026-06-09 12:46:44', 'Auto test order', 0);
INSERT INTO `sales_order` VALUES (28, 'SO20260609124836', 5, 3, 134, '2026-06-26', 'zzz', NULL, NULL, '已确认', '未发货', 'admin', '2026-06-09 12:48:36', '', NULL, NULL, 0);
INSERT INTO `sales_order` VALUES (29, 'SO20260609125320', 3, 4, 12, '2026-06-13', NULL, NULL, NULL, '已确认', '未发货', 'admin', '2026-06-09 12:53:20', '', NULL, NULL, 0);
INSERT INTO `sales_order` VALUES (30, 'SO20260609132602', 1, 1, 100, '2026-06-25', 'Test Receiver', '13800138000', 'Test Address', '已完成', '未发货', 'admin', '2026-06-09 13:26:02', 'SYSTEM', '2026-06-09 13:26:05', 'Auto test order', 0);
INSERT INTO `sales_order` VALUES (31, 'SO20260609132710', 1, 1, 100, '2026-06-25', 'Test Receiver', '13800138000', 'Test Address', '已完成', '未发货', 'admin', '2026-06-09 13:27:10', 'SYSTEM', '2026-06-09 13:27:13', 'Auto test order', 0);
INSERT INTO `sales_order` VALUES (32, 'SO20260610102805', 3, 4, 11, '2026-06-23', NULL, NULL, NULL, 'CONFIRMED', '已发货', 'admin', '2026-06-10 10:28:05', 'admin', '2026-06-11 23:37:51', NULL, 0);
INSERT INTO `sales_order` VALUES (33, 'SO20260611214427', 4, 4, 11, '2026-06-07', NULL, NULL, NULL, 'CONFIRMED', '已发货', 'admin', '2026-06-11 21:44:27', 'admin', '2026-06-11 22:49:58', NULL, 0);
INSERT INTO `sales_order` VALUES (35, 'SO20260612084222', 4, 5, 32, '2026-06-19', NULL, NULL, NULL, 'CONFIRMED', '已发货', 'admin', '2026-06-12 08:42:22', 'admin', '2026-06-12 08:43:56', NULL, 0);
INSERT INTO `sales_order` VALUES (36, 'SO20260612085206', 4, 4, 23, '2026-06-30', NULL, NULL, NULL, 'CONFIRMED', '已发货', 'admin', '2026-06-12 08:52:06', 'admin', '2026-06-12 08:53:12', NULL, 0);
INSERT INTO `sales_order` VALUES (37, 'SO20260612085911', 5, 4, 11, '2026-06-09', NULL, NULL, NULL, 'CONFIRMED', '已发货', 'admin', '2026-06-12 08:59:11', 'admin', '2026-06-12 08:59:22', NULL, 0);
INSERT INTO `sales_order` VALUES (38, 'SO20260612090231', 4, 3, 11, '2026-06-20', NULL, NULL, NULL, 'CONFIRMED', '已发货', 'admin', '2026-06-12 09:02:32', 'admin', '2026-06-12 09:02:37', NULL, 0);

-- ----------------------------
-- Table structure for schedule
-- ----------------------------
DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule`  (
  `scheduler_id` bigint NOT NULL AUTO_INCREMENT COMMENT '排程ID',
  `schedule_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '排程编号',
  `work_order_id` bigint NULL DEFAULT NULL COMMENT '工单ID',
  `product_id` bigint NULL DEFAULT NULL COMMENT '产品ID',
  `planned_start` datetime NULL DEFAULT NULL COMMENT '计划开始时间',
  `planned_end` datetime NULL DEFAULT NULL COMMENT '计划结束时间',
  `priority` int NULL DEFAULT 3 COMMENT '优先级(1-5)',
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'PENDING' COMMENT '状态',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`scheduler_id`) USING BTREE,
  INDEX `idx_work_order_id`(`work_order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单排程表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule
-- ----------------------------
INSERT INTO `schedule` VALUES (1, 'SCH-20260609-001', 33, 1, '2026-06-09 08:00:00', '2026-06-09 18:00:00', 1, 'FINISHED', 'admin', '2026-06-09 17:47:45', NULL, NULL, NULL);
INSERT INTO `schedule` VALUES (2, 'SCH-20260609-002', 31, 4, '2026-06-09 08:00:00', '2026-06-09 18:00:00', 2, 'RUNNING', 'admin', '2026-06-09 17:47:45', NULL, NULL, NULL);
INSERT INTO `schedule` VALUES (3, 'SCH-20260609-003', 32, 1, '2026-06-10 08:00:00', '2026-06-10 18:00:00', 3, 'PENDING', 'admin', '2026-06-09 17:47:45', NULL, NULL, NULL);
INSERT INTO `schedule` VALUES (4, 'SC20260610104128', 34, NULL, '2026-06-11 00:00:00', '2026-06-30 00:00:00', 3, 'PENDING', 'admin', '2026-06-10 10:41:28', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for shipment_record
-- ----------------------------
DROP TABLE IF EXISTS `shipment_record`;
CREATE TABLE `shipment_record`  (
  `shipment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '发货ID',
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `customer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户名称',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '产品名称',
  `plan_id` bigint NULL DEFAULT NULL COMMENT '生产计划ID',
  `shipment_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发货编号',
  `express_company` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '快递公司',
  `tracking_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '快递单号',
  `shipment_qty` int NULL DEFAULT NULL COMMENT '发货数量',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '已发货' COMMENT '发货状态',
  `operator_id` bigint NULL DEFAULT NULL COMMENT '操作人',
  `shipment_time` datetime NULL DEFAULT NULL COMMENT '发货时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`shipment_id`) USING BTREE,
  UNIQUE INDEX `uk_shipment_no`(`shipment_no` ASC) USING BTREE,
  INDEX `idx_shipment_order`(`order_id` ASC) USING BTREE,
  INDEX `idx_shipment_user`(`operator_id` ASC) USING BTREE,
  INDEX `idx_sr_plan_id`(`plan_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '发货记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shipment_record
-- ----------------------------
INSERT INTO `shipment_record` VALUES (1, 1, NULL, NULL, NULL, 'SH20260515001', '顺丰速运', 'SF1234567890', 500, '已发货', 1, '2026-05-15 10:00:00', 'admin', '2026-05-15 10:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (2, 2, NULL, NULL, NULL, 'SH20260520001', '京东物流', 'JD9876543210', 300, '已发货', 1, '2026-05-20 14:00:00', 'admin', '2026-05-20 14:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (3, 3, NULL, NULL, NULL, 'SH20260525001', '德邦物流', 'DB5555666677', 200, '已发货', 1, '2026-05-25 09:00:00', 'admin', '2026-05-25 09:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (4, 4, NULL, NULL, NULL, 'SH20260528001', '顺丰速运', 'SF1122334455', 400, '已发货', 1, '2026-05-28 16:00:00', 'admin', '2026-05-28 16:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (5, 1, NULL, NULL, NULL, 'SH20260516001', '圆通速递', 'YT9988776655', 100, '已发货', 1, '2026-05-16 11:00:00', 'admin', '2026-05-16 11:00:00', '', NULL, '分批发货');
INSERT INTO `shipment_record` VALUES (6, 2, NULL, NULL, NULL, 'SH20260521001', '中通快递', 'ZT1122334455', 80, '已发货', 1, '2026-05-21 10:00:00', 'admin', '2026-05-21 10:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (7, 3, NULL, NULL, NULL, 'SH20260526001', '韵达快递', 'YD5566778899', 100, '已发货', 1, '2026-05-26 14:00:00', 'admin', '2026-05-26 14:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (8, 4, NULL, NULL, NULL, 'SH20260529001', '顺丰速运', 'SF6677889900', 200, '已发货', 1, '2026-05-29 08:00:00', 'admin', '2026-05-29 08:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (9, 4, NULL, NULL, NULL, 'SH20260529002', '京东物流', 'JD3344556677', 120, '已发货', 1, '2026-05-29 15:00:00', 'admin', '2026-05-29 15:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (10, 5, NULL, NULL, NULL, 'SH20260522001', '顺丰速运', 'SF2233445566', 80, '已发货', 1, '2026-05-22 09:00:00', 'admin', '2026-05-22 09:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (11, 6, NULL, NULL, NULL, 'SH20260523001', '德邦物流', 'DB8899001122', 100, '已发货', 1, '2026-05-23 11:00:00', 'admin', '2026-05-23 11:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (12, 7, NULL, NULL, NULL, 'SH20260524001', '中通快递', 'ZT7788990011', 100, '已发货', 1, '2026-05-24 13:00:00', 'admin', '2026-05-24 13:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (13, 12, NULL, NULL, NULL, 'SH20260525002', '圆通速递', 'YT5566778899', 50, '已发货', 1, '2026-05-25 10:00:00', 'admin', '2026-05-25 10:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (14, 13, NULL, NULL, NULL, 'SH20260526002', '韵达快递', 'YD3344556677', 60, '已发货', 1, '2026-05-26 15:00:00', 'admin', '2026-05-26 15:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (15, 10, NULL, NULL, NULL, 'SH20260527001', '顺丰速运', 'SF4455667788', 25, '已发货', 1, '2026-05-27 08:30:00', 'admin', '2026-05-27 08:30:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (16, 8, NULL, NULL, NULL, 'SH20260527002', '京东物流', 'JD1122003344', 150, '已发货', 1, '2026-05-27 16:00:00', 'admin', '2026-05-27 16:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (17, 17, NULL, NULL, NULL, 'SH20260528002', '德邦物流', 'DB5566889900', 150, '已发货', 1, '2026-05-28 09:00:00', 'admin', '2026-05-28 09:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (18, 19, NULL, NULL, NULL, 'SH20260528003', '顺丰速运', 'SF9988001122', 50, '已发货', 1, '2026-05-28 14:00:00', 'admin', '2026-05-28 14:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (19, 20, NULL, NULL, NULL, 'SH20260529003', '中通快递', 'ZT6677889900', 80, '已发货', 1, '2026-05-29 10:00:00', 'admin', '2026-05-29 10:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (20, 15, NULL, NULL, NULL, 'SH20260529004', '圆通速递', 'YT1122003344', 60, '已发货', 1, '2026-05-29 16:00:00', 'admin', '2026-05-29 16:00:00', '', NULL, '');
INSERT INTO `shipment_record` VALUES (21, 33, NULL, NULL, NULL, 'FH20260611224958', '中通快递', NULL, 11, '已发货', NULL, '2026-06-11 22:49:56', 'admin', '2026-06-11 22:49:58', '', NULL, NULL);
INSERT INTO `shipment_record` VALUES (22, 34, NULL, NULL, NULL, 'FH20260611233654', '中通快递', NULL, 1000, '已发货', NULL, '2026-06-11 23:36:46', 'admin', '2026-06-11 23:36:54', '', NULL, NULL);
INSERT INTO `shipment_record` VALUES (23, 32, NULL, NULL, NULL, 'FH20260611233751', '中通快递', NULL, 11, '已发货', NULL, '2026-06-11 23:37:48', 'admin', '2026-06-11 23:37:51', '', NULL, NULL);
INSERT INTO `shipment_record` VALUES (24, 35, NULL, NULL, NULL, 'FH20260612084356', '中通快递', NULL, 32, '已发货', NULL, '2026-06-12 08:43:52', 'admin', '2026-06-12 08:43:56', '', NULL, NULL);
INSERT INTO `shipment_record` VALUES (25, 36, NULL, NULL, NULL, 'FH20260612085312', '韵达快递', NULL, 23, '已发货', NULL, '2026-06-12 08:53:08', 'admin', '2026-06-12 08:53:12', '', NULL, NULL);
INSERT INTO `shipment_record` VALUES (26, 37, NULL, NULL, NULL, 'FH20260612085922', '中通快递', 'FH20260612085922', 11, '已发货', NULL, '2026-06-12 08:59:19', 'admin', '2026-06-12 08:59:22', '', NULL, NULL);
INSERT INTO `shipment_record` VALUES (27, 38, '义乌手机配件商行', '折叠便携手机支架', NULL, 'FH20260612090237', '中通快递', 'FH20260612090237', 11, '已发货', NULL, '2026-06-12 09:02:35', 'admin', '2026-06-12 09:02:37', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-05-29 10:04:58', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-05-29 10:04:58', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-05-29 10:04:58', '', NULL, '深黑主题theme-dark，浅色主题theme-light，深蓝主题theme-blue');
INSERT INTO `sys_config` VALUES (4, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2026-05-29 10:04:58', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '用户管理-密码字符范围', 'sys.account.chrtype', '0', 'Y', 'admin', '2026-05-29 10:04:58', '', NULL, '默认任意字符范围，0任意（密码可以输入任意字符），1数字（密码只能为0-9数字），2英文字母（密码只能为a-z和A-Z字母），3字母和数字（密码必须包含字母，数字）,4字母数字和特殊字符（目前支持的特殊字符包括：~!@#$%^&*()-=_+）');
INSERT INTO `sys_config` VALUES (6, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2026-05-29 10:04:58', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (7, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2026-05-29 10:04:58', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '主框架页-菜单导航显示风格', 'sys.index.menuStyle', 'default', 'Y', 'admin', '2026-05-29 10:04:58', '', NULL, '菜单导航显示风格（default为左侧导航菜单，topnav为顶部导航菜单）');
INSERT INTO `sys_config` VALUES (9, '主框架页-是否开启页脚', 'sys.index.footer', 'true', 'Y', 'admin', '2026-05-29 10:04:58', '', NULL, '是否开启底部页脚显示（true显示，false隐藏）');
INSERT INTO `sys_config` VALUES (10, '主框架页-是否开启页签', 'sys.index.tagsView', 'true', 'Y', 'admin', '2026-05-29 10:04:58', '', NULL, '是否开启菜单多页签显示（true显示，false隐藏）');
INSERT INTO `sys_config` VALUES (11, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-05-29 10:04:58', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (100, '验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2026-06-09 11:08:17', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 10:04:57', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 10:04:57', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 10:04:57', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 10:04:57', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 10:04:57', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 10:04:57', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 10:04:57', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 10:04:57', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 10:04:57', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-05-29 10:04:57', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-05-29 10:04:58', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-05-29 10:04:58', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `start_time` datetime NULL DEFAULT NULL COMMENT '执行开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '执行结束时间',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `login_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 220 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-29 11:33:19');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-29 11:38:27');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Code 1.122.0', 'Windows 10.0', '0', '登录成功', '2026-05-29 12:25:59');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-29 13:38:17');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-05-29 14:03:00');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-05-29 14:03:11');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-05-29 14:13:52');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '1', '验证码错误', '2026-05-29 14:30:24');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '1', '验证码错误', '2026-05-29 14:30:31');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '1', '验证码错误', '2026-05-29 14:30:39');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '1', '验证码错误', '2026-05-29 14:30:48');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '1', '验证码错误', '2026-05-29 14:32:42');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-29 14:36:58');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-05-29 15:26:01');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '密码输入错误1次', '2026-05-29 15:27:37');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-05-29 15:30:39');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-29 15:33:07');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'TraeCN 1.107.1', 'Windows 10.0', '0', '登录成功', '2026-05-30 12:04:57');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-30 12:56:21');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-05-30 13:38:56');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-05-30 13:44:22');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-30 13:47:36');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-05-30 13:54:36');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-05-30 13:58:15');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-05-30 14:07:42');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-30 16:24:51');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-05-30 16:32:44');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-01 08:45:45');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '1', '验证码错误', '2026-06-01 08:45:50');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-01 08:45:55');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 08:52:56');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 08:54:27');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '1', '验证码错误', '2026-06-02 08:55:02');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '1', '验证码错误', '2026-06-02 08:55:02');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 08:55:09');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '1', '验证码错误', '2026-06-02 08:57:11');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '1', '验证码错误', '2026-06-02 08:57:14');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 08:57:20');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 09:39:11');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '1', '验证码错误', '2026-06-02 09:39:21');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 09:39:24');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '1', '验证码错误', '2026-06-02 09:40:00');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 09:40:03');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-02 11:24:32');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-02 12:16:19');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 13:10:49');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-02 13:40:57');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 14:46:39');
INSERT INTO `sys_logininfor` VALUES (148, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 17:29:48');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-02 18:19:37');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Edge 148', 'Windows >=10', '0', '登录成功', '2026-06-05 12:59:12');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-08 08:41:44');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-08 15:28:45');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-08 20:28:36');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-09 08:30:33');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '验证码错误', '2026-06-09 08:50:50');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '验证码错误', '2026-06-09 08:50:52');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-09 08:50:57');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '验证码错误', '2026-06-09 08:54:47');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-09 08:54:51');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-09 09:15:31');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-09 09:15:48');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-09 11:03:37');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Netscape 5.0', '', '1', '验证码错误', '2026-06-09 11:09:27');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'Netscape 5.0', '', '0', '登录成功', '2026-06-09 11:10:23');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-06-09 11:17:26');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '内网IP', 'MES-Test 1.0', '', '0', '登录成功', '2026-06-09 11:18:08');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'MES-Test 1.0', '', '0', '登录成功', '2026-06-09 11:37:29');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-06-09 11:38:36');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-06-09 11:39:28');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'MES-Test 1.0', '', '0', '登录成功', '2026-06-09 11:41:33');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'MES-Test 1.0', '', '0', '登录成功', '2026-06-09 11:42:22');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'MES-Test 1.0', '', '0', '登录成功', '2026-06-09 12:23:02');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'MES-Test 1.0', '', '0', '登录成功', '2026-06-09 12:24:44');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-09 12:28:04');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'MES-Test 1.0', '', '0', '登录成功', '2026-06-09 12:46:41');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-09 12:47:44');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-09 12:53:49');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'MES-Test 1.0', '', '0', '登录成功', '2026-06-09 13:26:02');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'MES-Test 1.0', '', '0', '登录成功', '2026-06-09 13:27:10');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-09 13:45:06');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-09 15:24:11');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-09 17:16:15');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-09 17:37:46');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-09 17:37:53');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-09 17:48:26');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-06-09 17:50:09');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-06-09 17:54:18');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-06-09 17:56:17');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-09 18:29:17');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-06-09 18:29:53');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-09 18:33:13');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-06-09 18:44:49');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-09 18:49:49');
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-10 08:40:43');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-10 08:46:58');
INSERT INTO `sys_logininfor` VALUES (196, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-10 08:51:23');
INSERT INTO `sys_logininfor` VALUES (197, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-10 08:51:38');
INSERT INTO `sys_logininfor` VALUES (198, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-06-10 09:08:59');
INSERT INTO `sys_logininfor` VALUES (199, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-06-10 09:20:31');
INSERT INTO `sys_logininfor` VALUES (200, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-10 09:24:24');
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-11 20:47:16');
INSERT INTO `sys_logininfor` VALUES (202, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-11 20:50:09');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-11 20:54:21');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-11 20:55:56');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-11 21:00:26');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '0', '登录成功', '2026-06-11 21:13:51');
INSERT INTO `sys_logininfor` VALUES (207, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-11 21:16:33');
INSERT INTO `sys_logininfor` VALUES (208, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-11 21:18:03');
INSERT INTO `sys_logininfor` VALUES (209, 'admin', '127.0.0.1', '内网IP', 'Curl 8.18.0', '', '1', '验证码错误', '2026-06-11 21:40:13');
INSERT INTO `sys_logininfor` VALUES (210, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-11 23:22:47');
INSERT INTO `sys_logininfor` VALUES (211, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-11 23:23:00');
INSERT INTO `sys_logininfor` VALUES (212, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-11 23:23:04');
INSERT INTO `sys_logininfor` VALUES (213, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '退出成功', '2026-06-11 23:23:27');
INSERT INTO `sys_logininfor` VALUES (214, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '验证码错误', '2026-06-11 23:23:32');
INSERT INTO `sys_logininfor` VALUES (215, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-11 23:23:36');
INSERT INTO `sys_logininfor` VALUES (216, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '验证码错误', '2026-06-12 08:41:45');
INSERT INTO `sys_logininfor` VALUES (217, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '1', '验证码错误', '2026-06-12 08:41:48');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-12 08:41:53');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'Edge 149', 'Windows >=10', '0', '登录成功', '2026-06-12 11:54:00');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '请求地址',
  `target` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '打开方式（menuItem页签 menuBlank新窗口）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `is_refresh` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否刷新（0刷新 1不刷新）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28007 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统设置', 0, 7, '#', '', 'M', '0', '1', '', 'fa fa-gear', 'admin', '2026-05-29 10:04:58', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, '/system/user', '', 'C', '0', '1', 'system:user:view', 'fa fa-user-o', 'admin', '2026-05-29 10:04:58', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色权限', 1, 2, '/system/role', '', 'C', '0', '1', 'system:role:view', 'fa fa-users', 'admin', '2026-05-29 10:04:58', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '#', '', 'F', '0', '1', 'system:user:list', '#', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '#', '', 'F', '0', '1', 'system:user:add', '#', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '#', '', 'F', '0', '1', 'system:user:edit', '#', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '#', '', 'F', '0', '1', 'system:user:remove', '#', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '#', '', 'F', '0', '1', 'system:user:export', '#', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '#', '', 'F', '0', '1', 'system:user:import', '#', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '#', '', 'F', '0', '1', 'system:user:resetPwd', '#', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '#', '', 'F', '0', '1', 'system:role:list', '#', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '#', '', 'F', '0', '1', 'system:role:add', '#', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '#', '', 'F', '0', '1', 'system:role:edit', '#', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '#', '', 'F', '0', '1', 'system:role:remove', '#', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '#', '', 'F', '0', '1', 'system:role:export', '#', 'admin', '2026-05-29 10:04:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, 'MES工作台', 0, 1, '#', 'menuItem', 'M', '0', '1', '', 'fa fa-industry', 'admin', '2026-05-29 12:58:17', 'admin', '2026-05-29 12:58:17', 'MES智能制造执行系统');
INSERT INTO `sys_menu` VALUES (2002, '产品管理', 2022, 1, '/mes/product', '', 'C', '0', '1', 'mes:product:view', 'fa fa-cube', 'admin', '2026-05-29 13:55:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, 'BOM管理', 2022, 2, '/mes/bom', '', 'C', '0', '1', 'mes:bom:view', 'fa fa-list-alt', 'admin', '2026-05-29 13:55:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '销售订单', 2011, 1, '/mes/order', '', 'C', '0', '1', 'mes:order:view', 'fa fa-file-text', 'admin', '2026-05-29 13:55:55', 'admin', '2026-06-09 11:00:05', '');
INSERT INTO `sys_menu` VALUES (2005, '工单中心', 2011, 3, '/mes/workorder', '', 'C', '0', '1', 'mes:workorder:view', 'fa fa-tasks', 'admin', '2026-05-29 13:55:55', 'admin', '2026-06-09 11:00:05', '');
INSERT INTO `sys_menu` VALUES (2006, '生产报工', 2011, 6, '/mes/report', '', 'C', '0', '1', 'mes:report:view', 'fa fa-clipboard-check', 'admin', '2026-05-29 13:55:55', 'admin', '2026-06-09 11:00:05', '');
INSERT INTO `sys_menu` VALUES (2007, '库存管理', 2022, 3, '/mes/inventory', '', 'C', '0', '1', 'mes:inventory:view', 'fa fa-warehouse', 'admin', '2026-05-29 13:55:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '设备监控', 2033, 1, '/mes/equipment', '', 'C', '0', '1', 'mes:equipment:view', 'fa fa-desktop', 'admin', '2026-05-29 13:55:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '发货管理', 2043, 1, '/mes/shipment', '', 'C', '0', '1', 'mes:shipment:view', 'fa fa-send', 'admin', '2026-05-29 13:55:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '生产看板', 2053, 1, '/mes/dashboard', '', 'C', '0', '1', 'mes:dashboard:view', 'fa fa-dashboard', 'admin', '2026-05-29 13:55:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '生产管理', 0, 2, '#', '', 'M', '0', '1', '', 'fa fa-cogs', 'admin', '2026-05-29 14:23:36', '', NULL, '生产管理目录');
INSERT INTO `sys_menu` VALUES (2012, '生产计划', 2011, 2, '/mes/plan', '', 'C', '0', '1', 'mes:plan:view', 'fa fa-calendar-check-o', 'admin', '2026-06-02 10:44:42', 'admin', '2026-06-09 11:00:05', '生产计划菜单');
INSERT INTO `sys_menu` VALUES (2022, '物料管理', 0, 3, '#', '', 'M', '0', '1', '', 'fa fa-cubes', 'admin', '2026-05-29 14:23:36', '', NULL, '物料管理目录');
INSERT INTO `sys_menu` VALUES (2023, '工单排程', 2011, 4, '/mes/schedule', '', 'C', '0', '1', 'mes:schedule:view', 'fa fa-sort-amount-asc', 'admin', '2026-06-09 10:14:13', 'admin', '2026-06-09 11:00:05', '');
INSERT INTO `sys_menu` VALUES (2033, '设备管理', 0, 4, '#', '', 'M', '0', '1', '', 'fa fa-microchip', 'admin', '2026-05-29 14:23:36', '', NULL, '设备管理目录');
INSERT INTO `sys_menu` VALUES (2035, '工序-产线-API映射', 2033, 2, '/mes/mapping', '', 'C', '0', '1', 'mes:mapping:view', 'fa fa-link', 'admin', '2026-06-02 15:32:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2043, '物流管理', 0, 5, '#', '', 'M', '0', '1', '', 'fa fa-truck', 'admin', '2026-05-29 14:23:36', '', NULL, '物流管理目录');
INSERT INTO `sys_menu` VALUES (2053, '数据分析', 0, 6, '#', '', 'M', '0', '1', '', 'fa fa-bar-chart', 'admin', '2026-05-29 14:23:36', '', NULL, '数据分析目录');
INSERT INTO `sys_menu` VALUES (2060, '领料管理', 2011, 7, '/mes/picking', '', 'C', '0', '1', 'mes:picking:view', 'fa fa-cart-arrow-down', 'admin', '2026-06-02 15:32:15', 'admin', '2026-06-09 11:00:05', '');
INSERT INTO `sys_menu` VALUES (2070, '入库管理', 2011, 8, '/mes/warehousing', '', 'C', '0', '1', 'mes:warehousing:view', 'fa fa-sign-in', 'admin', '2026-06-02 15:32:15', 'admin', '2026-06-09 11:00:05', '');
INSERT INTO `sys_menu` VALUES (2080, '质量追溯', 2053, 2, '/mes/trace', '', 'C', '0', '1', 'mes:trace:view', 'fa fa-history', 'admin', '2026-06-02 15:32:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2090, '质检管理', 2011, 8, '/mes/quality', '', 'C', '0', '1', 'mes:quality:view', 'fa fa-check-circle', 'admin', '2026-06-11 21:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2091, '质检查询', 2090, 1, '#', '', 'F', '0', '1', 'mes:quality:list', '#', 'admin', '2026-06-11 21:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2092, '质检新增', 2090, 2, '#', '', 'F', '0', '1', 'mes:quality:add', '#', 'admin', '2026-06-11 21:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2093, '质检修改', 2090, 3, '#', '', 'F', '0', '1', 'mes:quality:edit', '#', 'admin', '2026-06-11 21:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2094, '质检删除', 2090, 4, '#', '', 'F', '0', '1', 'mes:quality:remove', '#', 'admin', '2026-06-11 21:37:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2100, '客户查询', 28003, 1, '#', '', 'F', '0', '1', 'mes:customer:list', '#', 'admin', '2026-05-29 10:08:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2101, '客户详情', 28003, 2, '#', '', 'F', '0', '1', 'mes:customer:query', '#', 'admin', '2026-05-29 10:08:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2102, '客户新增', 28003, 3, '#', '', 'F', '0', '1', 'mes:customer:add', '#', 'admin', '2026-05-29 10:08:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2103, '客户修改', 28003, 4, '#', '', 'F', '0', '1', 'mes:customer:edit', '#', 'admin', '2026-05-29 10:08:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2104, '客户删除', 28003, 5, '#', '', 'F', '0', '1', 'mes:customer:remove', '#', 'admin', '2026-05-29 10:08:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2105, '客户导出', 28003, 6, '#', '', 'F', '0', '1', 'mes:customer:export', '#', 'admin', '2026-05-29 10:08:58', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2120, '计划查询', 2012, 1, '#', '', 'F', '0', '1', 'mes:plan:list', '#', 'admin', '2026-06-02 10:44:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2121, '计划新增', 2012, 2, '#', '', 'F', '0', '1', 'mes:plan:add', '#', 'admin', '2026-06-02 10:30:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2122, '计划修改', 2012, 3, '#', '', 'F', '0', '1', 'mes:plan:edit', '#', 'admin', '2026-06-02 10:30:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2123, '计划删除', 2012, 4, '#', '', 'F', '0', '1', 'mes:plan:remove', '#', 'admin', '2026-06-02 10:30:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2124, '计划导出', 2012, 5, '#', '', 'F', '0', '1', 'mes:plan:export', '#', 'admin', '2026-06-02 10:30:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2200, '产品查询', 2002, 1, '#', '', 'F', '0', '1', 'mes:product:list', '#', 'admin', '2026-05-29 10:25:42', 'admin', '2026-06-09 11:00:05', '');
INSERT INTO `sys_menu` VALUES (2201, '产品详情', 2002, 2, '#', '', 'F', '0', '1', 'mes:product:query', '#', 'admin', '2026-05-29 10:25:42', 'admin', '2026-06-09 11:00:05', '');
INSERT INTO `sys_menu` VALUES (2202, '产品新增', 2002, 3, '#', '', 'F', '0', '1', 'mes:product:add', '#', 'admin', '2026-05-29 10:25:42', 'admin', '2026-06-09 11:00:05', '');
INSERT INTO `sys_menu` VALUES (2203, '产品修改', 2002, 4, '#', '', 'F', '0', '1', 'mes:product:edit', '#', 'admin', '2026-05-29 10:25:42', 'admin', '2026-06-09 11:00:05', '');
INSERT INTO `sys_menu` VALUES (2204, '产品删除', 2002, 5, '#', '', 'F', '0', '1', 'mes:product:remove', '#', 'admin', '2026-05-29 10:25:42', 'admin', '2026-06-09 11:00:05', '');
INSERT INTO `sys_menu` VALUES (2205, '产品导出', 2002, 6, '#', '', 'F', '0', '1', 'mes:product:export', '#', 'admin', '2026-05-29 10:25:42', 'admin', '2026-06-09 11:00:05', '');
INSERT INTO `sys_menu` VALUES (2300, 'BOM查询', 2003, 1, '#', '', 'F', '0', '1', 'mes:bom:list', '#', 'admin', '2026-05-29 10:25:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2301, 'BOM详情', 2003, 2, '#', '', 'F', '0', '1', 'mes:bom:query', '#', 'admin', '2026-05-29 10:25:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2302, 'BOM新增', 2003, 3, '#', '', 'F', '0', '1', 'mes:bom:add', '#', 'admin', '2026-05-29 10:25:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2303, 'BOM修改', 2003, 4, '#', '', 'F', '0', '1', 'mes:bom:edit', '#', 'admin', '2026-05-29 10:25:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2304, 'BOM删除', 2003, 5, '#', '', 'F', '0', '1', 'mes:bom:remove', '#', 'admin', '2026-05-29 10:25:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2305, 'BOM导出', 2003, 6, '#', '', 'F', '0', '1', 'mes:bom:export', '#', 'admin', '2026-05-29 10:25:42', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2400, '订单查询', 2004, 1, '#', '', 'F', '0', '1', 'mes:order:list', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2401, '订单详情', 2004, 2, '#', '', 'F', '0', '1', 'mes:order:query', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2402, '订单新增', 2004, 3, '#', '', 'F', '0', '1', 'mes:order:add', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2403, '订单修改', 2004, 4, '#', '', 'F', '0', '1', 'mes:order:edit', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2404, '订单删除', 2004, 5, '#', '', 'F', '0', '1', 'mes:order:remove', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2405, '订单导出', 2004, 6, '#', '', 'F', '0', '1', 'mes:order:export', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2500, '工单查询', 2005, 1, '#', '', 'F', '0', '1', 'mes:workorder:list', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2501, '工单详情', 2005, 2, '#', '', 'F', '0', '1', 'mes:workorder:query', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2502, '工单新增', 2005, 3, '#', '', 'F', '0', '1', 'mes:workorder:add', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2503, '工单修改', 2005, 4, '#', '', 'F', '0', '1', 'mes:workorder:edit', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2504, '工单删除', 2005, 5, '#', '', 'F', '0', '1', 'mes:workorder:remove', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2505, '工单导出', 2005, 6, '#', '', 'F', '0', '1', 'mes:workorder:export', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2600, '报工查询', 2006, 1, '#', '', 'F', '0', '1', 'mes:report:list', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2601, '报工详情', 2006, 2, '#', '', 'F', '0', '1', 'mes:report:query', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2602, '报工新增', 2006, 3, '#', '', 'F', '0', '1', 'mes:report:add', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2603, '报工修改', 2006, 4, '#', '', 'F', '0', '1', 'mes:report:edit', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2604, '报工删除', 2006, 5, '#', '', 'F', '0', '1', 'mes:report:remove', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2605, '报工导出', 2006, 6, '#', '', 'F', '0', '1', 'mes:report:export', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2700, '库存查询', 2007, 1, '#', '', 'F', '0', '1', 'mes:inventory:list', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2701, '库存详情', 2007, 2, '#', '', 'F', '0', '1', 'mes:inventory:query', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2702, '库存新增', 2007, 3, '#', '', 'F', '0', '1', 'mes:inventory:add', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2703, '库存修改', 2007, 4, '#', '', 'F', '0', '1', 'mes:inventory:edit', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2704, '库存删除', 2007, 5, '#', '', 'F', '0', '1', 'mes:inventory:remove', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2705, '库存导出', 2007, 6, '#', '', 'F', '0', '1', 'mes:inventory:export', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2800, '设备查询', 2008, 1, '#', '', 'F', '0', '1', 'mes:equipment:list', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2801, '设备详情', 2008, 2, '#', '', 'F', '0', '1', 'mes:equipment:query', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2802, '设备新增', 2008, 3, '#', '', 'F', '0', '1', 'mes:equipment:add', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2803, '设备修改', 2008, 4, '#', '', 'F', '0', '1', 'mes:equipment:edit', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2804, '设备删除', 2008, 5, '#', '', 'F', '0', '1', 'mes:equipment:remove', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2805, '设备导出', 2008, 6, '#', '', 'F', '0', '1', 'mes:equipment:export', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2810, '映射查询', 2035, 1, '#', '', 'F', '0', '1', 'mes:mapping:list', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2811, '映射新增', 2035, 2, '#', '', 'F', '0', '1', 'mes:mapping:add', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2812, '映射修改', 2035, 3, '#', '', 'F', '0', '1', 'mes:mapping:edit', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2813, '映射删除', 2035, 4, '#', '', 'F', '0', '1', 'mes:mapping:remove', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2900, '发货查询', 2009, 1, '#', '', 'F', '0', '1', 'mes:shipment:list', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2901, '发货详情', 2009, 2, '#', '', 'F', '0', '1', 'mes:shipment:query', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2902, '发货新增', 2009, 3, '#', '', 'F', '0', '1', 'mes:shipment:add', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2903, '发货修改', 2009, 4, '#', '', 'F', '0', '1', 'mes:shipment:edit', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2904, '发货删除', 2009, 5, '#', '', 'F', '0', '1', 'mes:shipment:remove', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2905, '发货导出', 2009, 6, '#', '', 'F', '0', '1', 'mes:shipment:export', '#', 'admin', '2026-05-29 11:25:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (26000, '领料查询', 2060, 1, '#', '', 'F', '0', '1', 'mes:picking:list', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (26001, '领料新增', 2060, 2, '#', '', 'F', '0', '1', 'mes:picking:add', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (26002, '领料确认', 2060, 3, '#', '', 'F', '0', '1', 'mes:picking:edit', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (26003, '领料删除', 2060, 4, '#', '', 'F', '0', '1', 'mes:picking:remove', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (27000, '入库查询', 2070, 1, '#', '', 'F', '0', '1', 'mes:warehousing:list', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (27001, '入库新增', 2070, 2, '#', '', 'F', '0', '1', 'mes:warehousing:add', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (27002, '入库操作', 2070, 3, '#', '', 'F', '0', '1', 'mes:warehousing:edit', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (27003, '入库删除', 2070, 4, '#', '', 'F', '0', '1', 'mes:warehousing:remove', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (28000, '追溯查询', 2080, 1, '#', '', 'F', '0', '1', 'mes:trace:list', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (28001, '追溯新增', 2080, 2, '#', '', 'F', '0', '1', 'mes:trace:add', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (28002, '缺陷处理', 2080, 3, '#', '', 'F', '0', '1', 'mes:trace:edit', '#', 'admin', '2026-06-02 15:29:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (28003, '客户管理', 2000, 1, '/mes/customer', '', 'C', '0', '1', 'mes:customer:view', 'fa fa-user-circle-o', 'admin', '2026-06-09 12:33:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (28004, '工单排程新增', 2023, 2, '#', '', 'F', '0', '1', 'mes:schedule:add', '#', 'admin', '2026-06-09 17:45:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (28005, '工单排程修改', 2023, 3, '#', '', 'F', '0', '1', 'mes:schedule:edit', '#', 'admin', '2026-06-09 17:45:54', '', NULL, '');
INSERT INTO `sys_menu` VALUES (28006, '工单排程删除', 2023, 4, '#', '', 'F', '0', '1', 'mes:schedule:remove', '#', 'admin', '2026-06-09 17:45:54', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-05-29 10:04:58', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-05-29 10:04:58', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (3, '若依开源框架介绍', '1', 0x3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE9A1B9E79BAEE4BB8BE7BB8D3C2F7370616E3E3C2F703E3C703E3C666F6E7420636F6C6F723D2223333333333333223E52756F5969E5BC80E6BA90E9A1B9E79BAEE698AFE4B8BAE4BC81E4B89AE794A8E688B7E5AE9AE588B6E79A84E5908EE58FB0E8849AE6898BE69EB6E6A186E69EB6EFBC8CE4B8BAE4BC81E4B89AE68993E980A0E79A84E4B880E7AB99E5BC8FE8A7A3E586B3E696B9E6A188EFBC8CE9998DE4BD8EE4BC81E4B89AE5BC80E58F91E68890E69CACEFBC8CE68F90E58D87E5BC80E58F91E69588E78E87E38082E4B8BBE8A681E58C85E68BACE794A8E688B7E7AEA1E79086E38081E8A792E889B2E7AEA1E79086E38081E983A8E997A8E7AEA1E79086E38081E88F9CE58D95E7AEA1E79086E38081E58F82E695B0E7AEA1E79086E38081E5AD97E585B8E7AEA1E79086E380813C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE5B297E4BD8DE7AEA1E790863C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E5AE9AE697B6E4BBBBE58AA13C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE380813C2F7370616E3E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE69C8DE58AA1E79B91E68EA7E38081E799BBE5BD95E697A5E5BF97E38081E6938DE4BD9CE697A5E5BF97E38081E4BBA3E7A081E7949FE68890E7AD89E58A9FE883BDE38082E585B6E4B8ADEFBC8CE8BF98E694AFE68C81E5A49AE695B0E68DAEE6BA90E38081E695B0E68DAEE69D83E99990E38081E59BBDE99985E58C96E380815265646973E7BC93E5AD98E38081446F636B6572E983A8E7BDB2E38081E6BB91E58AA8E9AA8CE8AF81E7A081E38081E7ACACE4B889E696B9E8AEA4E8AF81E799BBE5BD95E38081E58886E5B883E5BC8FE4BA8BE58AA1E380813C2F7370616E3E3C666F6E7420636F6C6F723D2223333333333333223EE58886E5B883E5BC8FE69687E4BBB6E5AD98E582A83C2F666F6E743E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE38081E58886E5BA93E58886E8A1A8E5A484E79086E7AD89E68A80E69CAFE789B9E782B9E380823C2F7370616E3E3C2F703E3C703E3C696D67207372633D2268747470733A2F2F666F727564612E67697465652E636F6D2F696D616765732F313730353033303538333937373430313635312F35656435646236615F313135313030342E706E6722207374796C653D2277696474683A20363470783B223E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A20726762283233302C20302C2030293B223EE5AE98E7BD91E58F8AE6BC94E7A4BA3C2F7370616E3E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE5AE98E7BD91E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F72756F79692E7669703C2F613E3C6120687265663D22687474703A2F2F72756F79692E76697022207461726765743D225F626C616E6B223E3C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE88BA5E4BE9DE69687E6A1A3E59CB0E59D80EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F646F632E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F646F632E72756F79692E7669703C2F613E3C62723E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E4B88DE58886E7A6BBE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F64656D6F2E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F64656D6F2E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E58886E7A6BBE78988E69CACE38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F7675652E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F7675652E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E5BEAEE69C8DE58AA1E78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F636C6F75642E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F636C6F75642E72756F79692E7669703C2F613E3C2F703E3C703E3C7370616E207374796C653D22636F6C6F723A207267622835312C2035312C203531293B223EE6BC94E7A4BAE59CB0E59D80E38090E7A7BBE58AA8E7ABAFE78988E38091EFBC9A266E6273703B3C2F7370616E3E3C6120687265663D22687474703A2F2F68352E72756F79692E76697022207461726765743D225F626C616E6B223E687474703A2F2F68352E72756F79692E7669703C2F613E3C2F703E3C703E3C6272207374796C653D22636F6C6F723A207267622834382C2034392C203531293B20666F6E742D66616D696C793A202671756F743B48656C766574696361204E6575652671756F743B2C2048656C7665746963612C20417269616C2C2073616E732D73657269663B20666F6E742D73697A653A20313270783B223E3C2F703E, '0', 'admin', '2026-05-29 10:04:58', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_notice_read
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_read`;
CREATE TABLE `sys_notice_read`  (
  `read_id` bigint NOT NULL AUTO_INCREMENT COMMENT '已读主键',
  `notice_id` int NOT NULL COMMENT '公告id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `read_time` datetime NOT NULL COMMENT '阅读时间',
  PRIMARY KEY (`read_id`) USING BTREE,
  UNIQUE INDEX `uk_user_notice`(`user_id` ASC, `notice_id` ASC) USING BTREE COMMENT '同一用户同一公告只记录一次'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公告已读记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice_read
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 319 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '重置密码', 2, 'com.ruoyi.web.controller.system.SysProfileController.resetPwd()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/resetPwd', '127.0.0.1', '内网IP', '{\"userId\":[\"1\"],\"loginName\":[\"admin\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-05-29 14:37:50', 76);
INSERT INTO `sys_oper_log` VALUES (101, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.update()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/update', '127.0.0.1', '内网IP', '{\"id\":[\"\"],\"userName\":[\"若依\"],\"phonenumber\":[\"15888888888\"],\"email\":[\"ry@163.com\"],\"sex\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-05-29 14:54:18', 29);
INSERT INTO `sys_oper_log` VALUES (102, '客户管理', 1, 'com.ruoyi.mes.controller.CustomerController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/customer/create', '127.0.0.1', '内网IP', '{\"contactPhone\":\"13800138000\",\"customerCode\":\"TEST001\",\"customerName\":\"TestCustomer\",\"status\":\"NORMAL\"} ', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\r\n### The error may exist in URL [jar:nested:/D:/JAVA/MES/ruoyi-admin/target/ruoyi-admin.jar/!BOOT-INF/classes/!/mapper/mes/CustomerMapper.xml]\r\n### The error may involve com.ruoyi.mes.mapper.CustomerMapper.insertCustomer-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into customer(              customer_code,               customer_name,                             contact_phone,                                           status,                             create_by,              create_time         ) values (              ?,               ?,                             ?,                                           ?,                             ?,              sysdate()         )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\n; Data truncation: Data too long for column \'status\' at row 1', '2026-05-29 15:33:32', 636);
INSERT INTO `sys_oper_log` VALUES (103, '客户管理', 1, 'com.ruoyi.mes.controller.CustomerController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/customer/create', '127.0.0.1', '内网IP', '{\"contactPhone\":\"13800138000\",\"customerCode\":\"TEST001\",\"customerName\":\"TestCustomer\",\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-05-29 15:35:17', 13);
INSERT INTO `sys_oper_log` VALUES (104, '设备', 1, 'com.ruoyi.mes.controller.EquipmentController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/equipment/create', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"equipmentCode\":\"EQ-TEST01\",\"equipmentId\":110,\"equipmentName\":\"TestEquip01\",\"params\":{},\"status\":\"IDLE\"} ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-05-29 15:35:45', 11);
INSERT INTO `sys_oper_log` VALUES (105, '客户管理', 3, 'com.ruoyi.mes.controller.CustomerController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/customer/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"6\"]}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2026-05-29 15:36:42', 6);
INSERT INTO `sys_oper_log` VALUES (106, '设备', 3, 'com.ruoyi.mes.controller.EquipmentController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/equipment/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"6\"]}', '{\"msg\":\"操作失败\",\"code\":500}', 0, NULL, '2026-05-29 15:36:42', 3);
INSERT INTO `sys_oper_log` VALUES (107, '客户管理', 3, 'com.ruoyi.mes.controller.CustomerController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/customer/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"110\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-05-29 15:37:33', 13);
INSERT INTO `sys_oper_log` VALUES (108, '设备', 3, 'com.ruoyi.mes.controller.EquipmentController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/equipment/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"110\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-05-29 15:37:33', 6);
INSERT INTO `sys_oper_log` VALUES (109, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.update()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/update', '127.0.0.1', '内网IP', '{\"id\":[\"\"],\"userName\":[\"zzz\"],\"phonenumber\":[\"15888888888\"],\"email\":[\"ry@163.com\"],\"sex\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 08:54:56', 102);
INSERT INTO `sys_oper_log` VALUES (110, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateAvatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/updateAvatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"Cannot invoke \\\"String.length()\\\" because the return value of \\\"com.ruoyi.common.config.RuoYiConfig.getProfile()\\\" is null\",\"code\":500}', 0, NULL, '2026-06-02 08:55:32', 189);
INSERT INTO `sys_oper_log` VALUES (111, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateAvatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/updateAvatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"Cannot invoke \\\"String.length()\\\" because the return value of \\\"com.ruoyi.common.config.RuoYiConfig.getProfile()\\\" is null\",\"code\":500}', 0, NULL, '2026-06-02 08:55:37', 2);
INSERT INTO `sys_oper_log` VALUES (112, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/119', '127.0.0.1', '内网IP', '119 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 08:57:39', 31);
INSERT INTO `sys_oper_log` VALUES (113, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"3\"],\"productId\":[\"5\"],\"quantity\":[\"123\"],\"dueDate\":[\"2026-06-26\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'planned_qty\' doesn\'t have a default value\r\n### The error may exist in URL [jar:nested:/D:/JAVA/MES/ruoyi-admin/target/ruoyi-admin.jar/!BOOT-INF/classes/!/mapper/mes/ProductionPlanMapper.xml]\r\n### The error may involve com.ruoyi.mes.mapper.ProductionPlanMapper.insertProductionPlan-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into production_plan(              plan_no,               sales_order_id,               customer_id,               product_id,               order_quantity,               inventory_quantity,               safe_stock,               required_quantity,               priority,               is_urgent,               plan_status,                                                         create_by,              create_time         ) values (              ?,               ?,               ?,               ?,               ?,               ?,               ?,               ?,               ?,               ?,               ?,                                                         ?,              sysdate()         )\r\n### Cause: java.sql.SQLException: Field \'planned_qty\' doesn\'t have a default value\n; Field \'planned_qty\' doesn\'t have a default value', '2026-06-02 11:46:35', 748);
INSERT INTO `sys_oper_log` VALUES (114, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"3\"],\"productId\":[\"5\"],\"quantity\":[\"123\"],\"dueDate\":[\"2026-06-13\"],\"consignee\":[\"杨瑞去\"],\"consigneePhone\":[\"18815283921\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 11:55:08', 77);
INSERT INTO `sys_oper_log` VALUES (115, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"4\"],\"productId\":[\"3\"],\"quantity\":[\"1234\"],\"dueDate\":[\"2026-06-13\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 12:18:37', 145);
INSERT INTO `sys_oper_log` VALUES (116, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/1', '127.0.0.1', '内网IP', '1 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 12:21:24', 12);
INSERT INTO `sys_oper_log` VALUES (117, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/1', '127.0.0.1', '内网IP', '1 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 12:22:00', 11);
INSERT INTO `sys_oper_log` VALUES (118, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateAvatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/updateAvatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"Cannot invoke \\\"String.length()\\\" because the return value of \\\"com.ruoyi.common.config.RuoYiConfig.getProfile()\\\" is null\",\"code\":500}', 0, NULL, '2026-06-02 13:24:48', 170);
INSERT INTO `sys_oper_log` VALUES (119, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateAvatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/updateAvatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 13:28:52', 183);
INSERT INTO `sys_oper_log` VALUES (120, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.update()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/update', '127.0.0.1', '内网IP', '{\"id\":[\"\"],\"userName\":[\"zzz\"],\"phonenumber\":[\"15888888888\"],\"email\":[\"zzz@163.com\"],\"sex\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 13:29:02', 21);
INSERT INTO `sys_oper_log` VALUES (121, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/24', '127.0.0.1', '内网IP', '24 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 14:06:39', 271);
INSERT INTO `sys_oper_log` VALUES (122, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/22', '127.0.0.1', '内网IP', '22 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 14:07:04', 17);
INSERT INTO `sys_oper_log` VALUES (123, '工单管理', 3, 'com.ruoyi.mes.controller.WorkOrderController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"24\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`ry`.`mes_process_task`, CONSTRAINT `fk_task_workorder` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`))\r\n### The error may exist in URL [jar:nested:/D:/JAVA/MES/ruoyi-admin/target/ruoyi-admin.jar/!BOOT-INF/classes/!/mapper/mes/WorkOrderMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: delete from work_order where work_order_id in          (  ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`ry`.`mes_process_task`, CONSTRAINT `fk_task_workorder` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`ry`.`mes_process_task`, CONSTRAINT `fk_task_workorder` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`))', '2026-06-02 14:07:20', 486);
INSERT INTO `sys_oper_log` VALUES (124, '工单管理', 3, 'com.ruoyi.mes.controller.WorkOrderController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"24\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`ry`.`mes_process_task`, CONSTRAINT `fk_task_workorder` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`))\r\n### The error may exist in URL [jar:nested:/D:/JAVA/MES/ruoyi-admin/target/ruoyi-admin.jar/!BOOT-INF/classes/!/mapper/mes/WorkOrderMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: delete from work_order where work_order_id in          (  ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`ry`.`mes_process_task`, CONSTRAINT `fk_task_workorder` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`ry`.`mes_process_task`, CONSTRAINT `fk_task_workorder` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`))', '2026-06-02 14:07:26', 4);
INSERT INTO `sys_oper_log` VALUES (125, '工单管理', 3, 'com.ruoyi.mes.controller.WorkOrderController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"23\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 14:07:33', 6);
INSERT INTO `sys_oper_log` VALUES (126, '工单管理', 3, 'com.ruoyi.mes.controller.WorkOrderController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"22\"]}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`ry`.`mes_process_task`, CONSTRAINT `fk_task_workorder` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`))\r\n### The error may exist in URL [jar:nested:/D:/JAVA/MES/ruoyi-admin/target/ruoyi-admin.jar/!BOOT-INF/classes/!/mapper/mes/WorkOrderMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: delete from work_order where work_order_id in          (  ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Cannot delete or update a parent row: a foreign key constraint fails (`ry`.`mes_process_task`, CONSTRAINT `fk_task_workorder` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`))\n; Cannot delete or update a parent row: a foreign key constraint fails (`ry`.`mes_process_task`, CONSTRAINT `fk_task_workorder` FOREIGN KEY (`work_order_id`) REFERENCES `work_order` (`work_order_id`))', '2026-06-02 14:07:37', 5);
INSERT INTO `sys_oper_log` VALUES (127, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/12', '127.0.0.1', '内网IP', '12 ', NULL, 1, '当前计划状态不允许审核，仅待审核状态可审核', '2026-06-02 14:09:03', 63);
INSERT INTO `sys_oper_log` VALUES (128, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/12', '127.0.0.1', '内网IP', '12 ', NULL, 1, '当前计划状态不允许生成工单，请先审核通过', '2026-06-02 14:09:17', 5);
INSERT INTO `sys_oper_log` VALUES (129, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/1', '127.0.0.1', '内网IP', '1 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 14:09:24', 37);
INSERT INTO `sys_oper_log` VALUES (130, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/11', '127.0.0.1', '内网IP', '11 ', NULL, 1, '当前计划状态不允许生成工单，请先审核通过', '2026-06-02 14:09:35', 4);
INSERT INTO `sys_oper_log` VALUES (131, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/11', '127.0.0.1', '内网IP', '11 ', NULL, 1, '当前计划状态不允许审核，仅待审核状态可审核', '2026-06-02 14:09:39', 5);
INSERT INTO `sys_oper_log` VALUES (132, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/11', '127.0.0.1', '内网IP', '11 ', NULL, 1, '当前计划状态不允许生成工单，请先审核通过', '2026-06-02 14:10:23', 5);
INSERT INTO `sys_oper_log` VALUES (133, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/11', '127.0.0.1', '内网IP', '11 ', NULL, 1, '当前计划状态不允许审核，仅待审核状态可审核', '2026-06-02 14:10:28', 3);
INSERT INTO `sys_oper_log` VALUES (134, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"2\"],\"productId\":[\"3\"],\"quantity\":[\"210\"],\"dueDate\":[\"2026-06-12\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 14:12:47', 32);
INSERT INTO `sys_oper_log` VALUES (135, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"1\"],\"productId\":[\"4\"],\"quantity\":[\"321\"],\"dueDate\":[\"\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 14:13:22', 33);
INSERT INTO `sys_oper_log` VALUES (136, '销售订单', 3, 'com.ruoyi.mes.controller.SalesOrderController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"25\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 14:13:53', 7);
INSERT INTO `sys_oper_log` VALUES (137, '销售订单', 3, 'com.ruoyi.mes.controller.SalesOrderController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"24\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 14:13:55', 7);
INSERT INTO `sys_oper_log` VALUES (138, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"3\"],\"productId\":[\"5\"],\"quantity\":[\"432\"],\"dueDate\":[\"2026-06-10\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 14:14:20', 36);
INSERT INTO `sys_oper_log` VALUES (139, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/15', '127.0.0.1', '内网IP', '15 ', NULL, 1, '当前计划状态不允许审核，仅待审核状态可审核', '2026-06-02 14:14:26', 3);
INSERT INTO `sys_oper_log` VALUES (140, '生产计划', 3, 'com.ruoyi.mes.controller.ProductionPlanController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"15\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 14:15:12', 6);
INSERT INTO `sys_oper_log` VALUES (141, '生产计划', 3, 'com.ruoyi.mes.controller.ProductionPlanController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"14\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 14:15:13', 5);
INSERT INTO `sys_oper_log` VALUES (142, '生产计划', 3, 'com.ruoyi.mes.controller.ProductionPlanController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"13\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 14:15:18', 7);
INSERT INTO `sys_oper_log` VALUES (143, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/22', '127.0.0.1', '内网IP', '{\"completedQty\":[\"1234\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 16:00:06', 73);
INSERT INTO `sys_oper_log` VALUES (144, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"3\"],\"productId\":[\"4\"],\"quantity\":[\"2313\"],\"dueDate\":[\"2026-06-19\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 16:01:55', 38);
INSERT INTO `sys_oper_log` VALUES (145, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/16', '127.0.0.1', '内网IP', '16 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 16:02:07', 47);
INSERT INTO `sys_oper_log` VALUES (146, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/1', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zhy\"]}', '{\"msg\":\"请填写实发数量：PC聚碳酸酯颗粒\",\"code\":500}', 0, NULL, '2026-06-02 16:02:55', 7);
INSERT INTO `sys_oper_log` VALUES (147, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/1', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zhy\"]}', '{\"msg\":\"请填写实发数量：PC聚碳酸酯颗粒\",\"code\":500}', 0, NULL, '2026-06-02 16:03:24', 4);
INSERT INTO `sys_oper_log` VALUES (148, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/1', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zhy\"]}', '{\"msg\":\"请填写实发数量：PC聚碳酸酯颗粒\",\"code\":500}', 0, NULL, '2026-06-02 16:03:52', 5);
INSERT INTO `sys_oper_log` VALUES (149, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/1', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zhy\"]}', '{\"msg\":\"请填写实发数量：PC聚碳酸酯颗粒\",\"code\":500}', 0, NULL, '2026-06-02 16:11:18', 5);
INSERT INTO `sys_oper_log` VALUES (150, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/1', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zhy\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 17:32:39', 104);
INSERT INTO `sys_oper_log` VALUES (151, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"3\"],\"productId\":[\"5\"],\"quantity\":[\"10\"],\"dueDate\":[\"\"],\"isUrgent\":[\"1\"],\"consignee\":[\"ss\"],\"consigneePhone\":[\"057487600018\"],\"deliveryAddress\":[\"浙江省慈溪市白沙路街道学林路三号门宁波大学科学技术学院行政楼二楼\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 18:10:15', 36);
INSERT INTO `sys_oper_log` VALUES (152, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/26', '127.0.0.1', '内网IP', '26 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 18:12:02', 20);
INSERT INTO `sys_oper_log` VALUES (153, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/25', '127.0.0.1', '内网IP', '25 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 18:12:15', 12);
INSERT INTO `sys_oper_log` VALUES (154, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"1\"],\"productId\":[\"4\"],\"quantity\":[\"10\"],\"dueDate\":[\"2026-06-12\"],\"consignee\":[\"ss\"],\"consigneePhone\":[\"057487600018\"],\"deliveryAddress\":[\"浙江省慈溪市白沙路街道学林路三号门宁波大学科学技术学院行政楼二楼\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 18:21:52', 59);
INSERT INTO `sys_oper_log` VALUES (155, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/18', '127.0.0.1', '内网IP', '18 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 18:26:11', 82);
INSERT INTO `sys_oper_log` VALUES (156, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/27', '127.0.0.1', '内网IP', '27 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-02 18:26:18', 24);
INSERT INTO `sys_oper_log` VALUES (157, '库存', 1, 'com.ruoyi.mes.controller.InventoryController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/inventory/create', '127.0.0.1', '内网IP', '{\"inventoryType\":[\"\"],\"materialName\":[\"转轴组件\"],\"materialCode\":[\"SP-004\"],\"quantity\":[\"1000\"],\"location\":[\"半成品仓\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 13:16:53', 92);
INSERT INTO `sys_oper_log` VALUES (158, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/17', '127.0.0.1', '内网IP', '17 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 13:22:34', 54);
INSERT INTO `sys_oper_log` VALUES (159, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/28', '127.0.0.1', '内网IP', '28 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 13:58:07', 236);
INSERT INTO `sys_oper_log` VALUES (160, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/3', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zhy\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 13:58:34', 28);
INSERT INTO `sys_oper_log` VALUES (161, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/21', '127.0.0.1', '内网IP', '21 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 14:10:38', 237);
INSERT INTO `sys_oper_log` VALUES (162, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/21', '127.0.0.1', '内网IP', '21 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 14:10:43', 16);
INSERT INTO `sys_oper_log` VALUES (163, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"2\"],\"productId\":[\"3\"],\"quantity\":[\"1234\"],\"dueDate\":[\"2026-06-19\"],\"consignee\":[\"ss\"],\"consigneePhone\":[\"057487600018\"],\"deliveryAddress\":[\"浙江省慈溪市白沙路街道学林路三号门宁波大学科学技术学院行政楼二楼\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 14:21:11', 256);
INSERT INTO `sys_oper_log` VALUES (164, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/19', '127.0.0.1', '内网IP', '19 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 14:22:14', 44);
INSERT INTO `sys_oper_log` VALUES (165, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/29', '127.0.0.1', '内网IP', '29 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 14:41:39', 81);
INSERT INTO `sys_oper_log` VALUES (166, '库存', 1, 'com.ruoyi.mes.controller.InventoryController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/inventory/create', '127.0.0.1', '内网IP', '{\"inventoryType\":[\"\"],\"materialName\":[\"防锈润滑剂\"],\"materialCode\":[\"LV-002\"],\"quantity\":[\"99999\"],\"location\":[\"辅料仓\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 14:46:07', 17);
INSERT INTO `sys_oper_log` VALUES (167, '库存', 1, 'com.ruoyi.mes.controller.InventoryController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/inventory/create', '127.0.0.1', '内网IP', '{\"inventoryType\":[\"\"],\"materialName\":[\"硅胶原料\"],\"materialCode\":[\"M-004\"],\"quantity\":[\"99999\"],\"location\":[\"原材料仓-B区\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 14:46:16', 12);
INSERT INTO `sys_oper_log` VALUES (168, '库存', 1, 'com.ruoyi.mes.controller.InventoryController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/inventory/create', '127.0.0.1', '内网IP', '{\"inventoryType\":[\"\"],\"materialName\":[\"硅胶防滑垫成型件\"],\"materialCode\":[\"SP-003\"],\"quantity\":[\"99999\"],\"location\":[\"半成品仓\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 14:46:47', 11);
INSERT INTO `sys_oper_log` VALUES (169, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/4', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"郑海煜\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 14:47:14', 19);
INSERT INTO `sys_oper_log` VALUES (170, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/29', '127.0.0.1', '内网IP', '{\"completedQty\":[\"1284\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 15:00:43', 275);
INSERT INTO `sys_oper_log` VALUES (171, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"1\"],\"productId\":[\"4\"],\"quantity\":[\"12\"],\"dueDate\":[\"2026-06-09\"],\"consignee\":[\"ss\"],\"consigneePhone\":[\"057487600018\"],\"deliveryAddress\":[\"浙江省慈溪市白沙路街道学林路三号门宁波大学科学技术学院行政楼二楼\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 15:01:11', 38);
INSERT INTO `sys_oper_log` VALUES (172, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/20', '127.0.0.1', '内网IP', '20 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 15:01:19', 44);
INSERT INTO `sys_oper_log` VALUES (173, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/5', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zhy\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 15:01:40', 22);
INSERT INTO `sys_oper_log` VALUES (174, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/30', '127.0.0.1', '内网IP', '{\"completedQty\":[\"62\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 15:15:59', 304);
INSERT INTO `sys_oper_log` VALUES (175, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"2\"],\"productId\":[\"4\"],\"quantity\":[\"11\"],\"dueDate\":[\"2026-06-18\"],\"consignee\":[\"ss\"],\"consigneePhone\":[\"057487600018\"],\"deliveryAddress\":[\"浙江省慈溪市白沙路街道学林路三号门宁波大学科学技术学院行政楼二楼\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 15:16:20', 38);
INSERT INTO `sys_oper_log` VALUES (176, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/21', '127.0.0.1', '内网IP', '21 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 15:16:29', 44);
INSERT INTO `sys_oper_log` VALUES (177, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/6', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zzz\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 15:16:46', 27);
INSERT INTO `sys_oper_log` VALUES (178, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/31', '127.0.0.1', '内网IP', '{\"completedQty\":[\"61\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 15:32:35', 280);
INSERT INTO `sys_oper_log` VALUES (179, '入库单', 1, 'com.ruoyi.mes.controller.WarehousingController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/warehousing/create', '127.0.0.1', '内网IP', '{\"warehousingNo\":[\"\"],\"warehousingType\":[\"FINISHED\"],\"workOrderId\":[\"30\"],\"location\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"该工单已生成入库单：WH20260605151559\",\"code\":500}', 0, NULL, '2026-06-05 15:32:46', 11);
INSERT INTO `sys_oper_log` VALUES (180, '入库单', 1, 'com.ruoyi.mes.controller.WarehousingController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/warehousing/create', '127.0.0.1', '内网IP', '{\"warehousingNo\":[\"\"],\"warehousingType\":[\"FINISHED\"],\"workOrderId\":[\"30\"],\"location\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"该工单已生成入库单：WH20260605151559\",\"code\":500}', 0, NULL, '2026-06-05 15:32:48', 8);
INSERT INTO `sys_oper_log` VALUES (181, '入库单', 1, 'com.ruoyi.mes.controller.WarehousingController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/warehousing/create', '127.0.0.1', '内网IP', '{\"warehousingNo\":[\"\"],\"warehousingType\":[\"FINISHED\"],\"workOrderId\":[\"27\"],\"location\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 15:32:52', 15);
INSERT INTO `sys_oper_log` VALUES (182, '入库单', 2, 'com.ruoyi.mes.controller.WarehousingController.inspect()', 'POST', 1, 'admin', '研发部门', '/api/mes/warehousing/inspect/4', '127.0.0.1', '内网IP', '{\"inspector\":[\"zzz\"],\"inspectResult\":[\"PASS\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 15:33:23', 15);
INSERT INTO `sys_oper_log` VALUES (183, '入库单', 2, 'com.ruoyi.mes.controller.WarehousingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/warehousing/confirm/4', '127.0.0.1', '内网IP', '{\"warehousingBy\":[\"zzz\"],\"location\":[\"成品仓-A区\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-05 15:33:39', 44);
INSERT INTO `sys_oper_log` VALUES (184, '领料单', 3, 'com.ruoyi.mes.controller.MaterialPickingController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"4\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-08 15:31:56', 124);
INSERT INTO `sys_oper_log` VALUES (185, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.updateTime()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/updateTime/11', '127.0.0.1', '内网IP', '{\"planStartTime\":[\"2026-06-05 12:18:37\"],\"planEndTime\":[\"2026-06-06 12:18:37\"]}', '{\"msg\":\"操作成功\",\"code\":0,\"data\":{\"planStart\":\"2026-06-05 12:18:37\",\"planEnd\":\"2026-06-06 12:18:37\"}}', 0, NULL, '2026-06-09 08:47:21', 113);
INSERT INTO `sys_oper_log` VALUES (186, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"1\"],\"productId\":[\"1\"],\"quantity\":[\"11\"],\"dueDate\":[\"2026-06-09\"],\"consignee\":[\"ss\"],\"consigneePhone\":[\"057487600018\"],\"deliveryAddress\":[\"浙江省慈溪市白沙路街道学林路三号门宁波大学科学技术学院行政楼二楼\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 08:48:04', 34);
INSERT INTO `sys_oper_log` VALUES (187, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"3\"],\"productId\":[\"4\"],\"quantity\":[\"123\"],\"dueDate\":[\"2026-06-12\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:07:45', 26);
INSERT INTO `sys_oper_log` VALUES (188, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/23', '127.0.0.1', '内网IP', '23 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:08:09', 41);
INSERT INTO `sys_oper_log` VALUES (189, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/7', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zzz\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:08:27', 24);
INSERT INTO `sys_oper_log` VALUES (190, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/32', '127.0.0.1', '内网IP', '32 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:08:46', 13);
INSERT INTO `sys_oper_log` VALUES (191, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/32', '127.0.0.1', '内网IP', '{\"completedQty\":[\"173\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:08:53', 43);
INSERT INTO `sys_oper_log` VALUES (192, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/32', '127.0.0.1', '内网IP', '{\"completedQty\":[\"123\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:09:07', 10);
INSERT INTO `sys_oper_log` VALUES (193, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"1\"],\"productId\":[\"5\"],\"quantity\":[\"12\"],\"dueDate\":[\"2026-06-09\"],\"consignee\":[\"郑海燕\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:15:16', 29);
INSERT INTO `sys_oper_log` VALUES (194, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/24', '127.0.0.1', '内网IP', '24 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:16:33', 22);
INSERT INTO `sys_oper_log` VALUES (195, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/8', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zzz\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:17:00', 18);
INSERT INTO `sys_oper_log` VALUES (196, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/33', '127.0.0.1', '内网IP', '{\"completedQty\":[\"62\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:17:23', 26);
INSERT INTO `sys_oper_log` VALUES (197, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"1\"],\"productId\":[\"5\"],\"quantity\":[\"12\"],\"dueDate\":[\"2026-06-09\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:23:19', 32);
INSERT INTO `sys_oper_log` VALUES (198, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/25', '127.0.0.1', '内网IP', '25 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:23:28', 48);
INSERT INTO `sys_oper_log` VALUES (199, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/9', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zz\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:23:47', 32);
INSERT INTO `sys_oper_log` VALUES (200, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/34', '127.0.0.1', '内网IP', '{\"completedQty\":[\"62\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 09:24:34', 43);
INSERT INTO `sys_oper_log` VALUES (201, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"3\"],\"productId\":[\"3\"],\"quantity\":[\"32\"],\"dueDate\":[\"2026-06-04\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 10:39:59', 223);
INSERT INTO `sys_oper_log` VALUES (202, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/1', '127.0.0.1', '内网IP', '1 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 10:53:49', 275);
INSERT INTO `sys_oper_log` VALUES (203, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"customerId\":[\"1\"],\"productId\":[\"1\"],\"quantity\":[\"100\"],\"dueDate\":[\"2026-06-25\"],\"consignee\":[\"Test Receiver\"],\"consigneePhone\":[\"13800138000\"],\"deliveryAddress\":[\"Test Address\"],\"remark\":[\"Auto test order\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 11:37:30', 131);
INSERT INTO `sys_oper_log` VALUES (204, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/2', '127.0.0.1', '内网IP', '2 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 11:37:30', 15);
INSERT INTO `sys_oper_log` VALUES (205, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/2', '127.0.0.1', '内网IP', '2 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 11:37:30', 82);
INSERT INTO `sys_oper_log` VALUES (206, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/24', '127.0.0.1', '内网IP', '24 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 11:37:30', 21);
INSERT INTO `sys_oper_log` VALUES (207, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"customerId\":[\"1\"],\"productId\":[\"1\"],\"quantity\":[\"100\"],\"dueDate\":[\"2026-06-25\"],\"consignee\":[\"Test Receiver\"],\"consigneePhone\":[\"13800138000\"],\"deliveryAddress\":[\"Test Address\"],\"remark\":[\"Auto test order\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 11:41:33', 18);
INSERT INTO `sys_oper_log` VALUES (208, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/3', '127.0.0.1', '内网IP', '3 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 11:41:33', 9);
INSERT INTO `sys_oper_log` VALUES (209, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/3', '127.0.0.1', '内网IP', '3 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 11:41:33', 40);
INSERT INTO `sys_oper_log` VALUES (210, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/25', '127.0.0.1', '内网IP', '25 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 11:41:33', 12);
INSERT INTO `sys_oper_log` VALUES (211, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"23\"],\"expressCompany\":[\"SF Express\"],\"trackingNo\":[\"SF1780976496\"],\"shipmentQty\":[\"100\"]}', '{\"msg\":\"订单尚未完成生产，无法发货\",\"code\":500}', 0, NULL, '2026-06-09 11:41:36', 6);
INSERT INTO `sys_oper_log` VALUES (212, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"customerId\":[\"1\"],\"productId\":[\"1\"],\"quantity\":[\"100\"],\"dueDate\":[\"2026-06-25\"],\"consignee\":[\"Test Receiver\"],\"consigneePhone\":[\"13800138000\"],\"deliveryAddress\":[\"Test Address\"],\"remark\":[\"Auto test order\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 11:42:22', 15);
INSERT INTO `sys_oper_log` VALUES (213, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 11:42:22', 8);
INSERT INTO `sys_oper_log` VALUES (214, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/4', '127.0.0.1', '内网IP', '4 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 11:42:22', 45);
INSERT INTO `sys_oper_log` VALUES (215, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/26', '127.0.0.1', '内网IP', '26 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 11:42:22', 11);
INSERT INTO `sys_oper_log` VALUES (216, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"24\"],\"expressCompany\":[\"SF Express\"],\"trackingNo\":[\"SF1780976545\"],\"shipmentQty\":[\"100\"]}', '{\"msg\":\"订单尚未完成生产，无法发货\",\"code\":500}', 0, NULL, '2026-06-09 11:42:25', 3);
INSERT INTO `sys_oper_log` VALUES (217, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"customerId\":[\"1\"],\"productId\":[\"1\"],\"quantity\":[\"100\"],\"dueDate\":[\"2026-06-25\"],\"consignee\":[\"Test Receiver\"],\"consigneePhone\":[\"13800138000\"],\"deliveryAddress\":[\"Test Address\"],\"remark\":[\"Auto test order\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:23:02', 21);
INSERT INTO `sys_oper_log` VALUES (218, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/5', '127.0.0.1', '内网IP', '5 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:23:02', 7);
INSERT INTO `sys_oper_log` VALUES (219, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/5', '127.0.0.1', '内网IP', '5 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:23:02', 42);
INSERT INTO `sys_oper_log` VALUES (220, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/27', '127.0.0.1', '内网IP', '27 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:23:02', 12);
INSERT INTO `sys_oper_log` VALUES (221, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/7', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"TestOperator\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:23:02', 32);
INSERT INTO `sys_oper_log` VALUES (222, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"25\"],\"expressCompany\":[\"SF Express\"],\"trackingNo\":[\"SF1780978986\"],\"shipmentQty\":[\"100\"]}', '{\"msg\":\"订单尚未完成生产，无法发货\",\"code\":500}', 0, NULL, '2026-06-09 12:23:06', 3);
INSERT INTO `sys_oper_log` VALUES (223, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"customerId\":[\"1\"],\"productId\":[\"1\"],\"quantity\":[\"100\"],\"dueDate\":[\"2026-06-25\"],\"consignee\":[\"Test Receiver\"],\"consigneePhone\":[\"13800138000\"],\"deliveryAddress\":[\"Test Address\"],\"remark\":[\"Auto test order\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:24:44', 29);
INSERT INTO `sys_oper_log` VALUES (224, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/6', '127.0.0.1', '内网IP', '6 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:24:44', 12);
INSERT INTO `sys_oper_log` VALUES (225, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/6', '127.0.0.1', '内网IP', '6 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:24:45', 52);
INSERT INTO `sys_oper_log` VALUES (226, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/28', '127.0.0.1', '内网IP', '28 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:24:45', 15);
INSERT INTO `sys_oper_log` VALUES (227, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/8', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"TestOperator\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:24:45', 34);
INSERT INTO `sys_oper_log` VALUES (228, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"26\"],\"expressCompany\":[\"SF Express\"],\"trackingNo\":[\"SF1780979088\"],\"shipmentQty\":[\"100\"]}', '{\"msg\":\"订单尚未完成生产，无法发货\",\"code\":500}', 0, NULL, '2026-06-09 12:24:48', 5);
INSERT INTO `sys_oper_log` VALUES (229, '库存', 1, 'com.ruoyi.mes.controller.InventoryController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/inventory/create', '127.0.0.1', '内网IP', '{\"inventoryType\":[\"\"],\"materialName\":[\"不锈钢弹簧丝\"],\"materialCode\":[\"M-003\"],\"quantity\":[\"9999\"],\"location\":[\"原材料仓-B区\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:40:06', 14);
INSERT INTO `sys_oper_log` VALUES (230, '库存', 1, 'com.ruoyi.mes.controller.InventoryController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/inventory/create', '127.0.0.1', '内网IP', '{\"inventoryType\":[\"\"],\"materialName\":[\"底座注塑件\"],\"materialCode\":[\"SP-001\"],\"quantity\":[\"9999\"],\"location\":[\"半成品仓\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:40:27', 12);
INSERT INTO `sys_oper_log` VALUES (231, '库存', 1, 'com.ruoyi.mes.controller.InventoryController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/inventory/create', '127.0.0.1', '内网IP', '{\"inventoryType\":[\"\"],\"materialName\":[\"夹臂注塑件\"],\"materialCode\":[\"SP-002\"],\"quantity\":[\"9999\"],\"location\":[\"半成品仓\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:40:32', 11);
INSERT INTO `sys_oper_log` VALUES (232, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"customerId\":[\"1\"],\"productId\":[\"1\"],\"quantity\":[\"100\"],\"dueDate\":[\"2026-06-25\"],\"consignee\":[\"Test Receiver\"],\"consigneePhone\":[\"13800138000\"],\"deliveryAddress\":[\"Test Address\"],\"remark\":[\"Auto test order\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:46:41', 143);
INSERT INTO `sys_oper_log` VALUES (233, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/7', '127.0.0.1', '内网IP', '7 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:46:41', 14);
INSERT INTO `sys_oper_log` VALUES (234, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/7', '127.0.0.1', '内网IP', '7 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:46:41', 69);
INSERT INTO `sys_oper_log` VALUES (235, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/29', '127.0.0.1', '内网IP', '29 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:46:41', 18);
INSERT INTO `sys_oper_log` VALUES (236, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/9', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"TestOperator\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:46:42', 51);
INSERT INTO `sys_oper_log` VALUES (237, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"27\"],\"expressCompany\":[\"SF Express\"],\"trackingNo\":[\"SF1780980404\"],\"shipmentQty\":[\"100\"]}', '{\"msg\":\"该订单对应产品无成品库存，请先完成入库\",\"code\":500}', 0, NULL, '2026-06-09 12:46:45', 33);
INSERT INTO `sys_oper_log` VALUES (238, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"5\"],\"productId\":[\"3\"],\"quantity\":[\"134\"],\"dueDate\":[\"2026-06-26\"],\"consignee\":[\"zzz\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:48:36', 24);
INSERT INTO `sys_oper_log` VALUES (239, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/8', '127.0.0.1', '内网IP', '8 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:48:50', 18);
INSERT INTO `sys_oper_log` VALUES (240, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/8', '127.0.0.1', '内网IP', '8 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:49:00', 39);
INSERT INTO `sys_oper_log` VALUES (241, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/10', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zzz\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:49:21', 28);
INSERT INTO `sys_oper_log` VALUES (242, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/30', '127.0.0.1', '内网IP', '30 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:49:31', 12);
INSERT INTO `sys_oper_log` VALUES (243, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/10', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zzz\"]}', '{\"msg\":\"当前状态不允许领料\",\"code\":500}', 0, NULL, '2026-06-09 12:49:54', 4);
INSERT INTO `sys_oper_log` VALUES (244, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/30', '127.0.0.1', '内网IP', '{\"completedQty\":[\"184\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:50:08', 35);
INSERT INTO `sys_oper_log` VALUES (245, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"3\"],\"productId\":[\"4\"],\"quantity\":[\"12\"],\"dueDate\":[\"2026-06-13\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:53:21', 14);
INSERT INTO `sys_oper_log` VALUES (246, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/9', '127.0.0.1', '内网IP', '9 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:53:37', 15);
INSERT INTO `sys_oper_log` VALUES (247, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/9', '127.0.0.1', '内网IP', '9 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 12:54:11', 34);
INSERT INTO `sys_oper_log` VALUES (248, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"customerId\":[\"1\"],\"productId\":[\"1\"],\"quantity\":[\"100\"],\"dueDate\":[\"2026-06-25\"],\"consignee\":[\"Test Receiver\"],\"consigneePhone\":[\"13800138000\"],\"deliveryAddress\":[\"Test Address\"],\"remark\":[\"Auto test order\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 13:26:02', 136);
INSERT INTO `sys_oper_log` VALUES (249, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/10', '127.0.0.1', '内网IP', '10 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 13:26:03', 18);
INSERT INTO `sys_oper_log` VALUES (250, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/10', '127.0.0.1', '内网IP', '10 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 13:26:03', 94);
INSERT INTO `sys_oper_log` VALUES (251, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/32', '127.0.0.1', '内网IP', '32 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 13:26:03', 17);
INSERT INTO `sys_oper_log` VALUES (252, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/12', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"TestOperator\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 13:26:03', 50);
INSERT INTO `sys_oper_log` VALUES (253, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"30\"],\"expressCompany\":[\"SF Express\"],\"trackingNo\":[\"SF1780982766\"],\"shipmentQty\":[\"100\"]}', '{\"msg\":\"该订单对应产品无成品库存，请先完成入库\",\"code\":500}', 0, NULL, '2026-06-09 13:26:06', 11);
INSERT INTO `sys_oper_log` VALUES (254, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"customerId\":[\"1\"],\"productId\":[\"1\"],\"quantity\":[\"100\"],\"dueDate\":[\"2026-06-25\"],\"consignee\":[\"Test Receiver\"],\"consigneePhone\":[\"13800138000\"],\"deliveryAddress\":[\"Test Address\"],\"remark\":[\"Auto test order\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 13:27:10', 27);
INSERT INTO `sys_oper_log` VALUES (255, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.audit()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/audit/11', '127.0.0.1', '内网IP', '11 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 13:27:10', 16);
INSERT INTO `sys_oper_log` VALUES (256, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/11', '127.0.0.1', '内网IP', '11 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 13:27:10', 61);
INSERT INTO `sys_oper_log` VALUES (257, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/33', '127.0.0.1', '内网IP', '33 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 13:27:10', 20);
INSERT INTO `sys_oper_log` VALUES (258, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/13', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"TestOperator\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-09 13:27:10', 45);
INSERT INTO `sys_oper_log` VALUES (259, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"31\"],\"expressCompany\":[\"SF Express\"],\"trackingNo\":[\"SF1780982833\"],\"shipmentQty\":[\"100\"]}', '{\"msg\":\"该订单对应产品无成品库存，请先完成入库\",\"code\":500}', 0, NULL, '2026-06-09 13:27:13', 8);
INSERT INTO `sys_oper_log` VALUES (260, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"3\"],\"productId\":[\"4\"],\"quantity\":[\"11\"],\"dueDate\":[\"2026-06-23\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-10 10:28:05', 209);
INSERT INTO `sys_oper_log` VALUES (261, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/12', '127.0.0.1', '内网IP', '12 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-10 10:28:42', 46);
INSERT INTO `sys_oper_log` VALUES (262, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/14', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"z\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-10 10:29:44', 30);
INSERT INTO `sys_oper_log` VALUES (263, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/34', '127.0.0.1', '内网IP', '34 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-10 10:29:58', 15);
INSERT INTO `sys_oper_log` VALUES (264, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/34', '127.0.0.1', '内网IP', '{\"completedQty\":[\"61\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-10 10:30:17', 34);
INSERT INTO `sys_oper_log` VALUES (265, '排程管理', 1, 'com.ruoyi.mes.controller.ScheduleController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/schedule/create', '127.0.0.1', '内网IP', '{\"scheduleId\":[\"\"],\"scheduleNo\":[\"\"],\"workOrderId\":[\"34\"],\"productName\":[\"无线充电手机支架\"],\"priority\":[\"3\"],\"plannedStart\":[\"2026-06-11 00:00:00\"],\"plannedEnd\":[\"2026-06-30 00:00:00\"],\"status\":[\"PENDING\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-10 10:41:28', 187);
INSERT INTO `sys_oper_log` VALUES (266, '排程管理', 1, 'com.ruoyi.mes.controller.ScheduleController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/schedule/create', '127.0.0.1', '内网IP', '{\"scheduleId\":[\"\"],\"scheduleNo\":[\"\"],\"workOrderId\":[\"32\"],\"productName\":[\"桌面手机支架Pro\"],\"priority\":[\"3\"],\"plannedStart\":[\"2026-06-11 00:00:00\"],\"plannedEnd\":[\"2026-06-29 00:00:00\"],\"status\":[\"RUNNING\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-10 10:41:51', 7);
INSERT INTO `sys_oper_log` VALUES (267, '排程管理', 1, 'com.ruoyi.mes.controller.ScheduleController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/schedule/create', '127.0.0.1', '内网IP', '{\"scheduleId\":[\"\"],\"productId\":[\"1\"],\"scheduleNo\":[\"\"],\"workOrderId\":[\"33\"],\"productName\":[\"桌面手机支架Pro\"],\"priority\":[\"3\"],\"plannedStart\":[\"2026-06-10 10:51:39\"],\"plannedEnd\":[\"2026-06-27 00:00:00\"],\"status\":[\"PENDING\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-10 10:51:48', 210);
INSERT INTO `sys_oper_log` VALUES (268, '排程管理', 3, 'com.ruoyi.mes.controller.ScheduleController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/schedule/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"6,5\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-10 10:52:01', 13);
INSERT INTO `sys_oper_log` VALUES (269, '入库单', 1, 'com.ruoyi.mes.controller.WarehousingController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/warehousing/create', '127.0.0.1', '内网IP', '{\"warehousingNo\":[\"\"],\"warehousingType\":[\"FINISHED\"],\"workOrderId\":[\"33\"],\"location\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"该工单已生成入库单：WH20260609132713\",\"code\":500}', 0, NULL, '2026-06-10 10:52:45', 9);
INSERT INTO `sys_oper_log` VALUES (270, '质检记录', 1, 'com.ruoyi.mes.controller.QualityRecordController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/quality/create', '127.0.0.1', '内网IP', '{\"id\":[\"\"],\"productId\":[\"4\"],\"workOrderId\":[\"34\"],\"productName\":[\"无线充电手机支架\"],\"checkType\":[\"成品检验\"],\"checkTime\":[\"2026-06-11 21:41:30\"],\"quantity\":[\"21\"],\"defectQuantity\":[\"1\"],\"result\":[\"PASS\"],\"inspector\":[\"z\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 21:41:43', 65);
INSERT INTO `sys_oper_log` VALUES (271, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"4\"],\"productId\":[\"4\"],\"quantity\":[\"11\"],\"dueDate\":[\"2026-06-07\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 21:44:27', 41);
INSERT INTO `sys_oper_log` VALUES (272, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/13', '127.0.0.1', '内网IP', '13 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 21:44:57', 45);
INSERT INTO `sys_oper_log` VALUES (273, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/15', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"z\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 21:45:19', 33);
INSERT INTO `sys_oper_log` VALUES (274, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/35', '127.0.0.1', '内网IP', '35 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 21:45:29', 14);
INSERT INTO `sys_oper_log` VALUES (275, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/35', '127.0.0.1', '内网IP', '{\"completedQty\":[\"61\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 21:45:35', 36);
INSERT INTO `sys_oper_log` VALUES (276, '质检记录', 1, 'com.ruoyi.mes.controller.QualityRecordController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/quality/create', '127.0.0.1', '内网IP', '{\"id\":[\"\"],\"productId\":[\"4\"],\"workOrderId\":[\"35\"],\"productName\":[\"无线充电手机支架\"],\"checkType\":[\"成品检验\"],\"checkTime\":[\"2026-06-11 21:46:16\"],\"quantity\":[\"10\"],\"defectQuantity\":[\"1\"],\"result\":[\"PASS\"],\"inspector\":[\"z\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 21:46:26', 8);
INSERT INTO `sys_oper_log` VALUES (277, '质检记录', 1, 'com.ruoyi.mes.controller.QualityRecordController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/quality/create', '127.0.0.1', '内网IP', '{\"id\":[\"\"],\"productId\":[\"4\"],\"workOrderId\":[\"35\"],\"productName\":[\"无线充电手机支架\"],\"checkType\":[\"成品检验\"],\"checkTime\":[\"2026-06-11 21:46:48\"],\"quantity\":[\"111\"],\"defectQuantity\":[\"1\"],\"result\":[\"PASS\"],\"inspector\":[\"z\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 21:47:01', 10);
INSERT INTO `sys_oper_log` VALUES (278, '质检记录', 3, 'com.ruoyi.mes.controller.QualityRecordController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/quality/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"3\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 21:47:10', 6);
INSERT INTO `sys_oper_log` VALUES (279, '质检记录', 1, 'com.ruoyi.mes.controller.QualityRecordController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/quality/create', '127.0.0.1', '内网IP', '{\"id\":[\"\"],\"productId\":[\"4\"],\"workOrderId\":[\"35\"],\"productName\":[\"无线充电手机支架\"],\"checkType\":[\"成品检验\"],\"checkTime\":[\"2026-06-11 21:47:19\"],\"quantity\":[\"12\"],\"defectQuantity\":[\"1\"],\"result\":[\"PASS\"],\"inspector\":[\"z\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 21:47:27', 8);
INSERT INTO `sys_oper_log` VALUES (280, '质检记录', 3, 'com.ruoyi.mes.controller.QualityRecordController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/quality/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"4\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 21:47:37', 7);
INSERT INTO `sys_oper_log` VALUES (281, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"33\"],\"expressCompany\":[\"中通快递\"],\"shipmentQty\":[\"11\"],\"shipmentTime\":[\"2026-06-11 22:49:56\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 22:49:59', 230);
INSERT INTO `sys_oper_log` VALUES (282, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"4\"],\"productId\":[\"5\"],\"quantity\":[\"1000\"],\"dueDate\":[\"2026-06-28\"],\"isUrgent\":[\"1\"],\"consignee\":[\"wjj\"],\"consigneePhone\":[\"114514\"],\"deliveryAddress\":[\"图书馆的0721\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:26:04', 139);
INSERT INTO `sys_oper_log` VALUES (283, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/14', '127.0.0.1', '内网IP', '14 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:27:20', 45);
INSERT INTO `sys_oper_log` VALUES (284, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/36', '127.0.0.1', '内网IP', '36 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:28:05', 16);
INSERT INTO `sys_oper_log` VALUES (285, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/36', '127.0.0.1', '内网IP', '36 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:28:08', 16);
INSERT INTO `sys_oper_log` VALUES (286, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/36', '127.0.0.1', '内网IP', '36 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:28:11', 15);
INSERT INTO `sys_oper_log` VALUES (287, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/36', '127.0.0.1', '内网IP', '36 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:28:13', 16);
INSERT INTO `sys_oper_log` VALUES (288, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/36', '127.0.0.1', '内网IP', '{\"completedQty\":[\"1050\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:28:40', 47);
INSERT INTO `sys_oper_log` VALUES (289, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/36', '127.0.0.1', '内网IP', '{\"completedQty\":[\"1000\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:29:52', 12);
INSERT INTO `sys_oper_log` VALUES (290, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/31', '127.0.0.1', '内网IP', '{\"completedQty\":[\"1\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:30:20', 39);
INSERT INTO `sys_oper_log` VALUES (291, '生产报工', 1, 'com.ruoyi.mes.controller.ProductionReportController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/report/create', '127.0.0.1', '内网IP', '{\"badQty\":0,\"equipmentId\":9,\"goodQty\":61,\"processSeq\":1,\"remark\":\"\",\"reportTime\":1781191868000,\"reportType\":\"FINISH\",\"workOrderId\":35} ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:31:08', 44);
INSERT INTO `sys_oper_log` VALUES (292, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/16', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"z\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:32:29', 20);
INSERT INTO `sys_oper_log` VALUES (293, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"34\"],\"expressCompany\":[\"中通快递\"],\"shipmentQty\":[\"1000\"],\"shipmentTime\":[\"2026-06-11 23:36:46\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:36:54', 15);
INSERT INTO `sys_oper_log` VALUES (294, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"34\"],\"expressCompany\":[\"中通快递\"],\"shipmentQty\":[\"1000\"],\"shipmentTime\":[\"2026-06-11 23:36:46\"],\"remark\":[\"\"]}', '{\"msg\":\"该订单已发货，请勿重复操作\",\"code\":500}', 0, NULL, '2026-06-11 23:36:57', 8);
INSERT INTO `sys_oper_log` VALUES (295, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"34\"],\"expressCompany\":[\"圆通速递\"],\"shipmentQty\":[\"1000\"],\"shipmentTime\":[\"2026-06-11 23:37:00\"],\"remark\":[\"\"]}', '{\"msg\":\"该订单已发货，请勿重复操作\",\"code\":500}', 0, NULL, '2026-06-11 23:37:04', 4);
INSERT INTO `sys_oper_log` VALUES (296, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"34\"],\"expressCompany\":[\"圆通速递\"],\"shipmentQty\":[\"1000\"],\"shipmentTime\":[\"2026-06-11 23:37:36\"],\"remark\":[\"\"]}', '{\"msg\":\"该订单已发货，请勿重复操作\",\"code\":500}', 0, NULL, '2026-06-11 23:37:41', 3);
INSERT INTO `sys_oper_log` VALUES (297, '销售订单', 3, 'com.ruoyi.mes.controller.SalesOrderController.delete()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/delete', '127.0.0.1', '内网IP', '{\"ids\":[\"34\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:37:46', 9);
INSERT INTO `sys_oper_log` VALUES (298, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"32\"],\"expressCompany\":[\"中通快递\"],\"shipmentQty\":[\"11\"],\"shipmentTime\":[\"2026-06-11 23:37:48\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-11 23:37:51', 13);
INSERT INTO `sys_oper_log` VALUES (299, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"4\"],\"productId\":[\"5\"],\"quantity\":[\"32\"],\"dueDate\":[\"2026-06-19\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:42:22', 125);
INSERT INTO `sys_oper_log` VALUES (300, '生产计划', 2, 'com.ruoyi.mes.controller.ProductionPlanController.updateTime()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/updateTime/15', '127.0.0.1', '内网IP', '{\"planStartTime\":[\"2026-06-13 08:42:23\"],\"planEndTime\":[\"2026-06-14 08:42:23\"]}', '{\"msg\":\"操作成功\",\"code\":0,\"data\":{\"planStart\":\"2026-06-13 08:42:23\",\"planEnd\":\"2026-06-14 08:42:23\"}}', 0, NULL, '2026-06-12 08:42:56', 22);
INSERT INTO `sys_oper_log` VALUES (301, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/15', '127.0.0.1', '内网IP', '15 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:43:03', 48);
INSERT INTO `sys_oper_log` VALUES (302, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/17', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"zz\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:43:18', 34);
INSERT INTO `sys_oper_log` VALUES (303, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/37', '127.0.0.1', '内网IP', '37 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:43:26', 18);
INSERT INTO `sys_oper_log` VALUES (304, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/37', '127.0.0.1', '内网IP', '{\"completedQty\":[\"82\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:43:29', 46);
INSERT INTO `sys_oper_log` VALUES (305, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"35\"],\"expressCompany\":[\"中通快递\"],\"shipmentQty\":[\"32\"],\"shipmentTime\":[\"2026-06-12 08:43:52\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:43:56', 19);
INSERT INTO `sys_oper_log` VALUES (306, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"4\"],\"productId\":[\"4\"],\"quantity\":[\"23\"],\"dueDate\":[\"2026-06-30\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:52:06', 308);
INSERT INTO `sys_oper_log` VALUES (307, '生产计划', 1, 'com.ruoyi.mes.controller.ProductionPlanController.generateWorkOrder()', 'POST', 1, 'admin', '研发部门', '/api/mes/plan/generateWorkOrder/16', '127.0.0.1', '内网IP', '16 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:52:14', 63);
INSERT INTO `sys_oper_log` VALUES (308, '领料单', 2, 'com.ruoyi.mes.controller.MaterialPickingController.confirm()', 'POST', 1, 'admin', '研发部门', '/api/mes/picking/confirm/18', '127.0.0.1', '内网IP', '{\"pickingBy\":[\"z\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:52:25', 48);
INSERT INTO `sys_oper_log` VALUES (309, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.start()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/start/38', '127.0.0.1', '内网IP', '38 ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:52:32', 19);
INSERT INTO `sys_oper_log` VALUES (310, '工单管理', 2, 'com.ruoyi.mes.controller.WorkOrderController.finish()', 'POST', 1, 'admin', '研发部门', '/api/mes/workorder/finish/38', '127.0.0.1', '内网IP', '{\"completedQty\":[\"73\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:52:37', 51);
INSERT INTO `sys_oper_log` VALUES (311, '入库单', 1, 'com.ruoyi.mes.controller.WarehousingController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/warehousing/create', '127.0.0.1', '内网IP', '{\"warehousingNo\":[\"\"],\"warehousingType\":[\"FINISHED\"],\"workOrderId\":[\"35\"],\"location\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"该工单已生成入库单：WH20260611214535\",\"code\":500}', 0, NULL, '2026-06-12 08:52:45', 12);
INSERT INTO `sys_oper_log` VALUES (312, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"36\"],\"expressCompany\":[\"韵达快递\"],\"shipmentQty\":[\"23\"],\"shipmentTime\":[\"2026-06-12 08:53:08\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:53:12', 18);
INSERT INTO `sys_oper_log` VALUES (313, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"5\"],\"productId\":[\"4\"],\"quantity\":[\"11\"],\"dueDate\":[\"2026-06-09\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:59:11', 324);
INSERT INTO `sys_oper_log` VALUES (314, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"37\"],\"expressCompany\":[\"中通快递\"],\"shipmentQty\":[\"11\"],\"shipmentTime\":[\"2026-06-12 08:59:19\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 08:59:22', 17);
INSERT INTO `sys_oper_log` VALUES (315, '销售订单', 1, 'com.ruoyi.mes.controller.SalesOrderController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/create', '127.0.0.1', '内网IP', '{\"orderId\":[\"\"],\"orderNo\":[\"\"],\"customerId\":[\"4\"],\"productId\":[\"3\"],\"quantity\":[\"11\"],\"dueDate\":[\"2026-06-20\"],\"consignee\":[\"\"],\"consigneePhone\":[\"\"],\"deliveryAddress\":[\"\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 09:02:32', 285);
INSERT INTO `sys_oper_log` VALUES (316, '销售订单', 2, 'com.ruoyi.mes.controller.SalesOrderController.ship()', 'POST', 1, 'admin', '研发部门', '/api/mes/order/ship', '127.0.0.1', '内网IP', '{\"orderId\":[\"38\"],\"expressCompany\":[\"中通快递\"],\"shipmentQty\":[\"11\"],\"shipmentTime\":[\"2026-06-12 09:02:35\"],\"remark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 09:02:37', 22);
INSERT INTO `sys_oper_log` VALUES (317, '生产报工', 1, 'com.ruoyi.mes.controller.ProductionReportController.create()', 'POST', 1, 'admin', '研发部门', '/api/mes/report/create', '127.0.0.1', '内网IP', '{\"badQty\":1,\"equipmentId\":10,\"goodQty\":82,\"processSeq\":1,\"remark\":\"\",\"reportTime\":1781227719000,\"reportType\":\"FINISH\",\"workOrderId\":37} ', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 09:28:40', 209);
INSERT INTO `sys_oper_log` VALUES (318, '生产报工', 2, 'com.ruoyi.mes.controller.ProductionReportController.inspect()', 'POST', 1, 'admin', '研发部门', '/api/mes/report/inspect', '127.0.0.1', '内网IP', '{\"reportId\":[\"32\"],\"qualityResult\":[\"PASS\"],\"inspector\":[\"z\"],\"qualityRemark\":[\"\"]}', '{\"msg\":\"操作成功\",\"code\":0}', 0, NULL, '2026-06-12 09:55:38', 65);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-05-29 10:04:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-05-29 10:04:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-05-29 10:04:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-05-29 10:04:57', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', '0', '0', 'admin', '2026-05-29 10:04:57', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', '0', '0', 'admin', '2026-05-29 10:04:57', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 2035);
INSERT INTO `sys_role_menu` VALUES (1, 2060);
INSERT INTO `sys_role_menu` VALUES (1, 2070);
INSERT INTO `sys_role_menu` VALUES (1, 2080);
INSERT INTO `sys_role_menu` VALUES (1, 2810);
INSERT INTO `sys_role_menu` VALUES (1, 2811);
INSERT INTO `sys_role_menu` VALUES (1, 2812);
INSERT INTO `sys_role_menu` VALUES (1, 2813);
INSERT INTO `sys_role_menu` VALUES (1, 26000);
INSERT INTO `sys_role_menu` VALUES (1, 26001);
INSERT INTO `sys_role_menu` VALUES (1, 26002);
INSERT INTO `sys_role_menu` VALUES (1, 26003);
INSERT INTO `sys_role_menu` VALUES (1, 27000);
INSERT INTO `sys_role_menu` VALUES (1, 27001);
INSERT INTO `sys_role_menu` VALUES (1, 27002);
INSERT INTO `sys_role_menu` VALUES (1, 27003);
INSERT INTO `sys_role_menu` VALUES (1, 28000);
INSERT INTO `sys_role_menu` VALUES (1, 28001);
INSERT INTO `sys_role_menu` VALUES (1, 28002);
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `login_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录账号',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户 01注册用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像路径',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '盐加密',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', 'zzz', '00', 'zzz@163.com', '15888888888', '1', '/profile/avatar/2026/06/02/d51ed4f4717c458a95bc8fc29b4c667b.png', '0cafd9ca5304eb434065f6afd87dd406', '69b77e', '0', '0', '127.0.0.1', '2026-06-12 11:54:01', '2026-05-29 14:37:49', 'admin', '2026-05-29 10:04:57', '', '2026-06-02 13:29:02', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '8e6d98b90472783cc73c17047ddccf36', '222222', '0', '0', '127.0.0.1', NULL, NULL, 'admin', '2026-05-29 10:04:57', '', NULL, '测试员');

-- ----------------------------
-- Table structure for sys_user_online
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_online`;
CREATE TABLE `sys_user_online`  (
  `sessionId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户会话id',
  `login_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录账号',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '在线状态on_line在线off_line离线',
  `start_timestamp` datetime NULL DEFAULT NULL COMMENT 'session创建时间',
  `last_access_time` datetime NULL DEFAULT NULL COMMENT 'session最后访问时间',
  `expire_time` int NULL DEFAULT 0 COMMENT '超时时间，单位为分钟',
  `session_data` blob NULL COMMENT '序列化的Session数据，用于服务重启后恢复会话',
  PRIMARY KEY (`sessionId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '在线用户记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_online
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

-- ----------------------------
-- Table structure for work_order
-- ----------------------------
DROP TABLE IF EXISTS `work_order`;
CREATE TABLE `work_order`  (
  `work_order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '工单ID',
  `work_order_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工单编号',
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单ID',
  `plan_id` bigint NULL DEFAULT NULL COMMENT '生产计划ID',
  `planned_qty` int NULL DEFAULT NULL COMMENT '计划数量',
  `completed_qty` int NULL DEFAULT 0 COMMENT '完成数量',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '工单状态',
  `planned_start` datetime NULL DEFAULT NULL COMMENT '计划开始时间',
  `planned_end` datetime NULL DEFAULT NULL COMMENT '计划结束时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `current_step` int NULL DEFAULT 1 COMMENT '当前工序序号',
  `total_steps` int NULL DEFAULT 7 COMMENT '总工序数',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开工时间',
  `finish_time` datetime NULL DEFAULT NULL COMMENT '完工时间',
  PRIMARY KEY (`work_order_id`) USING BTREE,
  UNIQUE INDEX `uk_work_order_no`(`work_order_no` ASC) USING BTREE,
  INDEX `idx_workorder_order`(`order_id` ASC) USING BTREE,
  INDEX `idx_plan_id`(`plan_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '工单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of work_order
-- ----------------------------
INSERT INTO `work_order` VALUES (1, 'WO20260501001', 1, NULL, 500, 500, 'FINISHED', '2026-05-02 00:00:00', '2026-05-12 00:00:00', 'admin', '2026-05-01 09:00:00', '', NULL, '', 7, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (2, 'WO20260502001', 2, NULL, 300, 300, 'FINISHED', '2026-05-03 00:00:00', '2026-05-15 00:00:00', 'admin', '2026-05-02 09:30:00', '', NULL, '', 7, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (3, 'WO20260503001', 3, NULL, 200, 200, 'FINISHED', '2026-05-04 00:00:00', '2026-05-20 00:00:00', 'admin', '2026-05-03 10:00:00', '', NULL, '', 7, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (4, 'WO20260504001', 4, NULL, 400, 400, 'FINISHED', '2026-05-05 00:00:00', '2026-05-22 00:00:00', 'admin', '2026-05-04 10:30:00', '', NULL, '', 7, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (5, 'WO20260505001', 5, NULL, 180, 100, 'RUNNING', '2026-05-20 00:00:00', '2026-06-02 00:00:00', 'admin', '2026-05-18 08:00:00', '', NULL, '', 4, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (6, 'WO20260506001', 6, NULL, 250, 120, 'RUNNING', '2026-05-22 00:00:00', '2026-06-05 00:00:00', 'admin', '2026-05-20 08:30:00', '', NULL, '', 5, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (7, 'WO20260507001', 7, NULL, 160, 0, 'READY', '2026-06-01 00:00:00', '2026-06-15 00:00:00', 'admin', '2026-05-22 09:00:00', '', NULL, '', 0, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (8, 'WO20260508001', 8, NULL, 120, 0, 'WAITING', '2026-06-05 00:00:00', '2026-06-20 00:00:00', 'admin', '2026-05-24 09:30:00', '', NULL, '', 0, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (9, 'WO20260509001', 9, NULL, 220, 0, 'WAITING', '2026-06-10 00:00:00', '2026-06-25 00:00:00', 'admin', '2026-05-24 10:00:00', '', NULL, '', 0, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (10, 'WO20260524001', 1, NULL, 100, 100, 'FINISHED', '2026-05-22 00:00:00', '2026-05-24 00:00:00', 'admin', '2026-05-21 14:00:00', '', NULL, '补单', 7, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (11, 'WO20260524002', 10, NULL, 80, 0, 'WAITING', '2026-06-12 00:00:00', '2026-06-26 00:00:00', 'admin', '2026-05-24 10:00:00', '', NULL, '', 0, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (12, 'WO20260525001', 3, NULL, 50, 50, 'FINISHED', '2026-05-23 00:00:00', '2026-05-25 00:00:00', 'admin', '2026-05-22 15:00:00', '', NULL, '急单', 7, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (13, 'WO20260525002', 4, NULL, 60, 60, 'FINISHED', '2026-05-23 00:00:00', '2026-05-25 00:00:00', 'admin', '2026-05-22 16:00:00', '', NULL, '急单', 7, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (14, 'WO20260526001', 5, NULL, 40, 0, 'WAITING', '2026-05-27 00:00:00', '2026-06-08 00:00:00', 'admin', '2026-05-25 09:00:00', '', NULL, '', 0, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (15, 'WO20260526002', 6, NULL, 70, 0, 'WAITING', '2026-05-28 00:00:00', '2026-06-10 00:00:00', 'admin', '2026-05-25 09:30:00', '', NULL, '', 0, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (16, 'WO20260527001', 7, NULL, 100, 0, 'WAITING', '2026-05-29 00:00:00', '2026-06-12 00:00:00', 'admin', '2026-05-26 10:00:00', '', NULL, '', 0, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (17, 'WO20260527002', 8, NULL, 150, 150, 'FINISHED', '2026-05-25 00:00:00', '2026-05-27 00:00:00', 'admin', '2026-05-24 11:00:00', '', NULL, '', 7, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (18, 'WO20260528001', 9, NULL, 200, 0, 'WAITING', '2026-05-30 00:00:00', '2026-06-15 00:00:00', 'admin', '2026-05-27 08:00:00', '', NULL, '', 0, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (19, 'WO20260528002', 1, NULL, 50, 50, 'FINISHED', '2026-05-26 00:00:00', '2026-05-28 00:00:00', 'admin', '2026-05-25 13:00:00', '', NULL, '', 7, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (20, 'WO20260529001', 2, NULL, 80, 0, 'WAITING', '2026-05-30 00:00:00', '2026-06-16 00:00:00', 'admin', '2026-05-28 09:00:00', '', NULL, '', 0, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (28, 'WO20260609122444', 26, 6, 150, 14, 'FINISHED', NULL, NULL, 'admin', '2026-06-09 12:24:44', 'admin', '2026-06-09 12:24:47', NULL, 1, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (29, 'WO20260609124641', 27, 7, 150, 14, 'FINISHED', NULL, NULL, 'admin', '2026-06-09 12:46:41', 'admin', '2026-06-09 12:46:44', NULL, 1, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (30, 'WO20260609124900', 28, 8, 184, 184, 'FINISHED', NULL, NULL, 'admin', '2026-06-09 12:49:00', 'admin', '2026-06-09 12:50:08', NULL, 1, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (31, 'WO20260609125411', 29, 9, 62, 1, 'FINISHED', NULL, NULL, 'admin', '2026-06-09 12:54:11', 'admin', '2026-06-11 23:30:20', NULL, 1, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (32, 'WO20260609132603', 30, 10, 150, 14, 'FINISHED', NULL, NULL, 'admin', '2026-06-09 13:26:03', 'admin', '2026-06-09 13:26:05', NULL, 1, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (33, 'WO20260609132710', 31, 11, 150, 14, 'FINISHED', NULL, NULL, 'admin', '2026-06-09 13:27:10', 'admin', '2026-06-09 13:27:13', NULL, 1, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (34, 'WO20260610102841', 32, 12, 61, 61, 'FINISHED', NULL, NULL, 'admin', '2026-06-10 10:28:41', 'admin', '2026-06-10 10:30:17', NULL, 1, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (35, 'WO20260611214457', 33, 13, 61, 61, 'FINISHED', NULL, NULL, 'admin', '2026-06-11 21:44:57', 'admin', '2026-06-11 21:45:35', NULL, 1, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (36, 'WO20260611232720', 34, 14, 1050, 1000, 'FINISHED', NULL, NULL, 'admin', '2026-06-11 23:27:20', 'admin', '2026-06-11 23:29:52', NULL, 1, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (37, 'WO20260612084303', 35, 15, 82, 82, 'FINISHED', NULL, NULL, 'admin', '2026-06-12 08:43:03', 'admin', '2026-06-12 08:43:29', NULL, 1, 7, NULL, NULL);
INSERT INTO `work_order` VALUES (38, 'WO20260612085214', 36, 16, 73, 73, 'FINISHED', NULL, NULL, 'admin', '2026-06-12 08:52:14', 'admin', '2026-06-12 08:52:37', NULL, 1, 7, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
