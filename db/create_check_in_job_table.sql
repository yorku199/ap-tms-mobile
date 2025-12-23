-- สร้างตาราง tb_check_in_job สำหรับเก็บข้อมูลการเช็คอินเข้างานของพนักงานขับรถ
-- แต่ละแถว = 1 ครั้งของการเช็คอินเข้างาน
CREATE TABLE IF NOT EXISTS `tb_check_in_job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL COMMENT 'FK FROM tb_user.Id',
  `check_in_time` datetime DEFAULT NULL COMMENT 'เวลาที่เช็คอินเข้างาน',
  `user_lat` decimal(10,6) DEFAULT NULL COMMENT 'Latitude ของผู้ใช้',
  `user_long` decimal(10,6) DEFAULT NULL COMMENT 'Longitude ของผู้ใช้',
  `mileage` decimal(10,2) DEFAULT NULL COMMENT 'เลขไมล์',
  `status` int(11) DEFAULT 1 COMMENT '1 = active, 0 = inactive',
  `created_by` varchar(100) DEFAULT NULL,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` varchar(100) DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_check_in_time` (`check_in_time`),
  CONSTRAINT `FK_check_in_job_user` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='ตารางเก็บข้อมูลการเช็คอินเข้างานของพนักงานขับรถ (แต่ละแถว = 1 ครั้ง)';

