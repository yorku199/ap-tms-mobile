-- ลบคอลัมน์ check_out_time ออกจากตาราง tb_check_in
-- และเพิ่มคอลัมน์ type เพื่อระบุประเภท (check_in หรือ check_out)

ALTER TABLE `tb_check_in`
DROP COLUMN `check_out_time`,
ADD COLUMN `type` varchar(20) DEFAULT 'check_in' COMMENT 'ประเภท: check_in หรือ check_out' AFTER `check_in_time`;

