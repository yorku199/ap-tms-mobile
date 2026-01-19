-- เพิ่มคอลัมน์ image_url ในตาราง tb_check_in_job
ALTER TABLE `tb_check_in_job` 
ADD COLUMN `image_url` varchar(500) DEFAULT NULL COMMENT 'ที่อยู่รูปภาพที่แนบมา' AFTER `mileage`;

