ALTER TABLE shipment_record ADD COLUMN customer_name VARCHAR(100) DEFAULT NULL COMMENT '客户名称' AFTER order_id;
ALTER TABLE shipment_record ADD COLUMN product_name VARCHAR(100) DEFAULT NULL COMMENT '产品名称' AFTER customer_name;
ALTER TABLE shipment_record ADD COLUMN status VARCHAR(20) DEFAULT '已发货' COMMENT '发货状态' AFTER shipment_qty;
