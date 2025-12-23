-- สร้างตาราง tb_check_in สำหรับเก็บข้อมูลการเช็คอิน/เช็คเอาท์
-- แต่ละแถว = 1 ครั้งของการเช็คอินหรือเช็คเอาท์
-- ระบบจะคำนวณ check out time จากแถวสุดท้ายของวันนั้น
-- in_time และ out_time เก็บเวลาที่กำหนดเข้าออกงานของ user ณ เวลาที่ทำการเช็คอิน/เช็คเอาท์
-- เพื่อป้องกันปัญหาการคำนวณผิดในอนาคตถ้า user เปลี่ยนเวลาเข้าออกงาน
CREATE TABLE IF NOT EXISTS `tb_check_in` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT 'FK FROM tb_user.Id',
  `yard_id` bigint(20) NOT NULL COMMENT 'FK FROM tb_user_yard.id',
  `check_in_time` datetime DEFAULT NULL COMMENT 'เวลาที่เช็คอิน/เช็คเอาท์',
  `type` varchar(20) DEFAULT 'check_in' COMMENT 'ประเภท: check_in หรือ check_out',
  `in_time` TIME NULL COMMENT 'เวลาที่กำหนดให้เข้างาน ณ เวลาที่เช็คอิน/เช็คเอาท์ (เช่น 08:00:00)',
  `out_time` TIME NULL COMMENT 'เวลาที่กำหนดให้ออกงาน ณ เวลาที่เช็คอิน/เช็คเอาท์ (เช่น 17:00:00)',
  `user_lat` decimal(10,6) DEFAULT NULL COMMENT 'Latitude ของผู้ใช้',
  `user_long` decimal(10,6) DEFAULT NULL COMMENT 'Longitude ของผู้ใช้',
  `yard_lat` decimal(10,6) DEFAULT NULL COMMENT 'Latitude ของ yard',
  `yard_long` decimal(10,6) DEFAULT NULL COMMENT 'Longitude ของ yard',
  `distance` decimal(10,2) DEFAULT NULL COMMENT 'ระยะทางระหว่าง user กับ yard (เมตร)',
  `status` int(11) DEFAULT 1 COMMENT '1 = active, 0 = inactive',
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_yard_id` (`yard_id`),
  KEY `idx_check_in_time` (`check_in_time`),
  KEY `idx_type` (`type`),
  CONSTRAINT `FK_check_in_user` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_check_in_yard` FOREIGN KEY (`yard_id`) REFERENCES `tb_user_yard` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='ตารางเก็บข้อมูลการเช็คอิน/เช็คเอาท์ของพนักงาน (แต่ละแถว = 1 ครั้ง)';

