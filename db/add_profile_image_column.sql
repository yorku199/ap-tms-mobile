-- เพิ่มคอลัมน์ profile_image_url ใน tb_user
ALTER TABLE `tb_user` 
ADD COLUMN `profile_image_url` VARCHAR(500) NULL COMMENT 'URL ของรูป profile' AFTER `monthly_employee_flag`;

