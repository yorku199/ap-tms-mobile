const pool = require('../config/database');
const multer = require('multer');
const path = require('path');
const fs = require('fs').promises;
const fsSync = require('fs');

// ตั้งค่า multer สำหรับอัพโหลดไฟล์
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const uploadDir = path.join(__dirname, '..', 'uploads', 'profile_images');
    // สร้าง folder ถ้ายังไม่มี
    if (!fsSync.existsSync(uploadDir)) {
      fsSync.mkdirSync(uploadDir, { recursive: true });
    }
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    // ตั้งชื่อไฟล์: user_{userId}_{timestamp}.{extension}
    const userId = req.user.Id;
    const timestamp = Date.now();
    const ext = path.extname(file.originalname);
    cb(null, `user_${userId}_${timestamp}${ext}`);
  }
});

// ตรวจสอบประเภทไฟล์
const fileFilter = (req, file, cb) => {
  const allowedTypes = /jpeg|jpg|png|gif|webp/;
  const extname = allowedTypes.test(path.extname(file.originalname).toLowerCase());
  const mimetype = allowedTypes.test(file.mimetype);

  if (mimetype && extname) {
    return cb(null, true);
  } else {
    cb(new Error('กรุณาอัพโหลดไฟล์รูปภาพเท่านั้น (jpeg, jpg, png, gif, webp)'));
  }
};

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 5 * 1024 * 1024 // 5MB
  },
  fileFilter: fileFilter
});

// Middleware สำหรับอัพโหลดไฟล์
const uploadMiddleware = upload.single('profile_image');

// อัพโหลดรูป profile
const uploadProfileImage = async (req, res) => {
  uploadMiddleware(req, res, async (err) => {
    if (err) {
      return res.status(400).json({
        success: false,
        message: err.message || 'เกิดข้อผิดพลาดในการอัพโหลดไฟล์'
      });
    }

    if (!req.file) {
      return res.status(400).json({
        success: false,
        message: 'กรุณาเลือกไฟล์รูปภาพ'
      });
    }

    try {
      const userId = req.user.Id;
      const filePath = `/uploads/profile_images/${req.file.filename}`;
      
      // สร้าง full URL (path เต็ม) - ใช้ BASE_URL จาก env หรือสร้างจาก request
      const baseUrl = process.env.BASE_URL || `${req.protocol}://${req.get('host')}`;
      const fullUrl = `${baseUrl}${filePath}`;

      // ลบรูปเก่า (ถ้ามี)
      const [users] = await pool.execute(
        'SELECT profile_image_url FROM tb_user WHERE Id = ?',
        [userId]
      );

      if (users.length > 0 && users[0].profile_image_url) {
        // แปลง full URL เป็น local path สำหรับลบไฟล์
        const oldUrl = users[0].profile_image_url;
        // ลบ base URL ออกเพื่อได้ path
        const oldBaseUrl = process.env.BASE_URL || `${req.protocol}://${req.get('host')}`;
        let oldFilePath = oldUrl.replace(oldBaseUrl, '');
        
        // ถ้ายังมี protocol อยู่ แสดงว่าไม่ตรงกับ baseUrl ให้ลองวิธีอื่น
        if (oldFilePath.startsWith('http://') || oldFilePath.startsWith('https://')) {
          // แยก path จาก URL
          try {
            const urlObj = new URL(oldUrl);
            oldFilePath = urlObj.pathname;
          } catch (e) {
            // ถ้า parse ไม่ได้ ให้ใช้วิธีเดิม
            oldFilePath = oldUrl.replace(/^https?:\/\/[^\/]+/, '');
          }
        }
        
        // ลบไฟล์ถ้ามี
        if (oldFilePath && fsSync.existsSync(oldFilePath.startsWith('/') ? oldFilePath.substring(1) : oldFilePath)) {
          fsSync.unlinkSync(oldFilePath.startsWith('/') ? oldFilePath.substring(1) : oldFilePath);
        }
      }

      // อัพเดท profile_image_url ในฐานข้อมูล
      await pool.execute(
        'UPDATE tb_user SET profile_image_url = ?, updated_by = ?, updated_date = NOW() WHERE Id = ?',
        [fullUrl, req.user.username || req.user.Id.toString(), userId]
      );

      res.json({
        success: true,
        message: 'อัพโหลดรูป profile สำเร็จ',
        data: {
          profile_image_url: fullUrl
        }
      });
    } catch (error) {
      console.error('Upload profile image error:', error);
      // ลบไฟล์ที่อัพโหลดแล้วถ้าเกิด error
      if (req.file && fsSync.existsSync(req.file.path)) {
        fsSync.unlinkSync(req.file.path);
      }
      res.status(500).json({
        success: false,
        message: 'เกิดข้อผิดพลาดในการอัพโหลดรูป profile',
        error: process.env.NODE_ENV === 'development' ? error.message : undefined
      });
    }
  });
};

module.exports = {
  uploadProfileImage
};

