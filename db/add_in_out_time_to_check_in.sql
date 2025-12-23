-- เพิ่มคอลัมน์ in_time และ out_time ในตาราง tb_check_in
-- เพื่อเก็บเวลาที่กำหนดเข้าออกงานของ user ณ เวลาที่ทำการเช็คอิน/เช็คเอาท์
-- เพื่อป้องกันปัญหาการคำนวณผิดในอนาคตถ้า user เปลี่ยนเวลาเข้าออกงาน

ALTER TABLE `tb_check_in`
ADD COLUMN `in_time` TIME NULL COMMENT 'เวลาที่กำหนดให้เข้างาน ณ เวลาที่เช็คอิน (เช่น 08:00:00)' AFTER `type`,
ADD COLUMN `out_time` TIME NULL COMMENT 'เวลาที่กำหนดให้ออกงาน ณ เวลาที่เช็คเอาท์ (เช่น 17:00:00)' AFTER `in_time`;

