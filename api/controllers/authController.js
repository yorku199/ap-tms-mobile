const jwt = require('jsonwebtoken');
const pool = require('../config/database');

// ฟังก์ชันสำหรับสร้าง JWT Token
const generateToken = (userId) => {
  return jwt.sign(
    { userId },
    process.env.JWT_SECRET,
    { expiresIn: process.env.JWT_EXPIRES_IN || '24h' }
  );
};

// เข้าสู่ระบบด้วยรหัสบัตรประชาชน
const login = async (req, res) => {
  try {
    const { id_card_no } = req.body;

    // ตรวจสอบว่ามีรหัสบัตรประชาชนหรือไม่
    if (!id_card_no) {
      return res.status(400).json({
        success: false,
        message: 'กรุณากรอกรหัสบัตรประชาชน'
      });
    }

    // ตรวจสอบรูปแบบรหัสบัตรประชาชน (13 หลัก)
    if (!/^\d{13}$/.test(id_card_no)) {
      return res.status(400).json({
        success: false,
        message: 'รหัสบัตรประชาชนต้องเป็นตัวเลข 13 หลัก'
      });
    }

    // ค้นหาผู้ใช้จากรหัสบัตรประชาชน
    const [users] = await pool.execute(
      `SELECT Id, username, name, lastname, id_card_no, role, status, 
       email, contactnumber, employee_code, department_id, position_id, profile_image_url 
       FROM tb_user 
       WHERE id_card_no = ? AND status = 1 AND status_id = 4`,
      [id_card_no]
    );

    if (users.length === 0) {
      return res.status(401).json({
        success: false,
        message: 'ไม่พบผู้ใช้หรือบัญชีถูกปิดการใช้งาน'
      });
    }

    const user = users[0];

    // อัพเดท last_login_date
    await pool.execute(
      'UPDATE tb_user SET last_login_date = NOW() WHERE Id = ?',
      [user.Id]
    );

    // สร้าง JWT Token
    const token = generateToken(user.Id);

    // ส่งข้อมูลกลับไป
    res.json({
      success: true,
      message: 'เข้าสู่ระบบสำเร็จ',
      data: {
        token,
        user: {
          id: user.Id,
          username: user.username,
          name: user.name,
          lastname: user.lastname,
          id_card_no: user.id_card_no,
          role: user.role,
          email: user.email,
          contactnumber: user.contactnumber,
          employee_code: user.employee_code,
          department_id: user.department_id,
          position_id: user.position_id,
          profile_image_url: user.profile_image_url
        }
      }
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({
      success: false,
      message: 'เกิดข้อผิดพลาดในการเข้าสู่ระบบ',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
};

// ดูข้อมูลผู้ใช้ปัจจุบัน
const getCurrentUser = async (req, res) => {
  try {
    const [users] = await pool.execute(
      `SELECT Id, username, name, lastname, id_card_no, role, status, 
       email, contactnumber, employee_code, department_id, position_id,
       last_login_date, created_date, profile_image_url
       FROM tb_user 
       WHERE Id = ?`,
      [req.user.Id]
    );

    if (users.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'ไม่พบข้อมูลผู้ใช้'
      });
    }

    res.json({
      success: true,
      data: {
        user: users[0]
      }
    });
  } catch (error) {
    console.error('Get user error:', error);
    res.status(500).json({
      success: false,
      message: 'เกิดข้อผิดพลาดในการดึงข้อมูลผู้ใช้',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
};

// ออกจากระบบ
const logout = (req, res) => {
  res.json({
    success: true,
    message: 'ออกจากระบบสำเร็จ'
  });
};

// ตรวจสอบ Token
const verifyToken = (req, res) => {
  res.json({
    success: true,
    message: 'Token ถูกต้อง',
    data: {
      user: req.user
    }
  });
};

module.exports = {
  login,
  getCurrentUser,
  logout,
  verifyToken
};

