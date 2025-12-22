-- เพิ่มคอลัมน์ address และ title ใน tb_user_yard
ALTER TABLE `tb_user_yard` 
ADD COLUMN `title` VARCHAR(255) NULL COMMENT 'หัวข้อ/ชื่อย่อ yard' AFTER `name`,
ADD COLUMN `address` TEXT NULL COMMENT 'ที่อยู่ yard' AFTER `title`;

