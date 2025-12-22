-- เพิ่มคอลัมน์ lat, long, radius ใน tb_user_yard สำหรับการคำนวณ geofencing check in/out
ALTER TABLE `tb_user_yard` 
ADD COLUMN `lat` DECIMAL(10,6) NULL COMMENT 'Latitude for geofencing check in/out' AFTER `status`,
ADD COLUMN `long` DECIMAL(10,6) NULL COMMENT 'Longitude for geofencing check in/out' AFTER `lat`,
ADD COLUMN `radius` INT(10) NULL COMMENT 'Radius in meters for geofencing check in/out' AFTER `long`;
