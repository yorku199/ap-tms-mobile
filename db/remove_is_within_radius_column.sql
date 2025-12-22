-- ลบคอลัมน์ is_within_radius ออกจากตาราง tb_check_in
-- เพราะระบบจะไม่อนุญาตให้เช็คอินถ้าไม่อยู่ในรัศมีอยู่แล้ว
ALTER TABLE `tb_check_in` 
DROP COLUMN `is_within_radius`;

