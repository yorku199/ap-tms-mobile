const jwt = require('jsonwebtoken');
const pool = require('../config/database');

// Middleware สำหรับตรวจสอบ JWT Token
const authenticateToken = async (req, res, next) => {
  try {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]; // Bearer TOKEN

    if (!token) {
      return res.status(401).json({
        success: false,
        message: 'ไม่พบ Token กรุณาเข้าสู่ระบบใหม่'
      });
    }

    // ตรวจสอบ Token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    
    // ตรวจสอบว่าผู้ใช้ยังมีอยู่ในระบบหรือไม่
    const [users] = await pool.execute(
      'SELECT Id, username, name, lastname, id_card_no, status FROM tb_user WHERE Id = ? AND status = 1',
      [decoded.userId]
    );

    if (users.length === 0) {
      return res.status(401).json({
        success: false,
        message: 'ผู้ใช้ไม่ถูกต้องหรือถูกปิดการใช้งาน'
      });
    }

    // เพิ่มข้อมูลผู้ใช้ใน request
    req.user = users[0];
    next();
  } catch (error) {
    if (error.name === 'JsonWebTokenError') {
      return res.status(401).json({
        success: false,
        message: 'Token ไม่ถูกต้อง'
      });
    }
    if (error.name === 'TokenExpiredError') {
      return res.status(401).json({
        success: false,
        message: 'Token หมดอายุแล้ว กรุณาเข้าสู่ระบบใหม่'
      });
    }
    return res.status(500).json({
      success: false,
      message: 'เกิดข้อผิดพลาดในการตรวจสอบ Token'
    });
  }
};

module.exports = {
  authenticateToken
};

