-- เพิ่มคอลัมน์ in_time และ out_time ในตาราง tb_user
-- เพื่อเก็บเวลาที่กำหนดให้แต่ละ user เข้างานและออกงานในแต่ละวัน
-- ใช้สำหรับคำนวณการเช็คอิน/เช็คเอาท์

ALTER TABLE `tb_user`
ADD COLUMN `in_time` TIME NULL COMMENT 'เวลาที่กำหนดให้เข้างาน (เช่น 08:00:00)' AFTER `last_login_date`,
ADD COLUMN `out_time` TIME NULL COMMENT 'เวลาที่กำหนดให้ออกงาน (เช่น 17:00:00)' AFTER `in_time`;

