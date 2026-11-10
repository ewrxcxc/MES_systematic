-- 排程表
DROP TABLE IF EXISTS `schedule`;
CREATE TABLE `schedule` (
    `scheduler_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '排程ID',
    `schedule_no` varchar(64) NOT NULL COMMENT '排程编号',
    `work_order_id` bigint(20) DEFAULT NULL COMMENT '工单ID',
    `product_id` bigint(20) DEFAULT NULL COMMENT '产品ID',
    `planned_start` datetime DEFAULT NULL COMMENT '计划开始时间',
    `planned_end` datetime DEFAULT NULL COMMENT '计划结束时间',
    `priority` int(11) DEFAULT 3 COMMENT '优先级(1-5)',
    `status` varchar(32) DEFAULT 'PENDING' COMMENT '状态',
    `create_by` varchar(64) DEFAULT NULL,
    `create_time` datetime DEFAULT NULL,
    `update_by` varchar(64) DEFAULT NULL,
    `update_time` datetime DEFAULT NULL,
    `remark` varchar(500) DEFAULT NULL,
    PRIMARY KEY (`scheduler_id`),
    KEY `idx_work_order_id` (`work_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='工单排程表';

-- 测试数据（从已有工单关联）
INSERT INTO `schedule` (`schedule_no`, `work_order_id`, `product_id`, `planned_start`, `planned_end`, `priority`, `status`, `create_by`, `create_time`)
SELECT 'SCH-20260605-001', w.work_order_id, o.product_id, '2026-06-05 08:00:00', '2026-06-05 18:00:00', 1, 'FINISHED', 'admin', NOW()
FROM work_order w LEFT JOIN sales_order o ON o.order_id = w.order_id
WHERE w.work_order_no = 'WO202606050001' LIMIT 1;

INSERT INTO `schedule` (`schedule_no`, `work_order_id`, `product_id`, `planned_start`, `planned_end`, `priority`, `status`, `create_by`, `create_time`)
SELECT 'SCH-20260606-001', w.work_order_id, o.product_id, '2026-06-06 08:00:00', '2026-06-06 18:00:00', 2, 'RUNNING', 'admin', NOW()
FROM work_order w LEFT JOIN sales_order o ON o.order_id = w.order_id
WHERE w.work_order_no = 'WO202606050002' LIMIT 1;

INSERT INTO `schedule` (`schedule_no`, `work_order_id`, `product_id`, `planned_start`, `planned_end`, `priority`, `status`, `create_by`, `create_time`)
SELECT 'SCH-20260607-001', w.work_order_id, o.product_id, '2026-06-07 08:00:00', '2026-06-07 18:00:00', 3, 'PENDING', 'admin', NOW()
FROM work_order w LEFT JOIN sales_order o ON o.order_id = w.order_id
WHERE w.work_order_no = 'WO202606050003' LIMIT 1;
