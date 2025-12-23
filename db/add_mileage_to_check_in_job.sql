-- เพิ่มคอลัมน์ mileage ในตาราง tb_check_in_job
ALTER TABLE `tb_check_in_job` 
ADD COLUMN `mileage` decimal(10,2) DEFAULT NULL COMMENT 'เลขไมล์' AFTER `user_long`;

