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

// เข้าสู่ระบบด้วยรหัสบัตรประชาชนและวันเดือนปีเกิด
const login = async (req, res) => {
  try {
    const { id_card_no, birth_date } = req.body;

    // ตรวจสอบว่ามีรหัสบัตรประชาชนหรือไม่
    if (!id_card_no) {
      return res.status(400).json({
        success: false,
        message: 'กรุณากรอกรหัสบัตรประชาชน'
      });
    }

    // ตรวจสอบว่ามีวันเดือนปีเกิดหรือไม่
    if (!birth_date) {
      return res.status(400).json({
        success: false,
        message: 'กรุณากรอกวันเดือนปีเกิด'
      });
    }

    // ตรวจสอบรูปแบบรหัสบัตรประชาชน (13 หลัก)
    if (!/^\d{13}$/.test(id_card_no)) {
      return res.status(400).json({
        success: false,
        message: 'รหัสบัตรประชาชนต้องเป็นตัวเลข 13 หลัก'
      });
    }

    // ตรวจสอบรูปแบบวันเดือนปีเกิด (YYYY-MM-DD)
    const dateRegex = /^\d{4}-\d{2}-\d{2}$/;
    if (!dateRegex.test(birth_date)) {
      return res.status(400).json({
        success: false,
        message: 'รูปแบบวันเดือนปีเกิดไม่ถูกต้อง (ต้องเป็น YYYY-MM-DD)'
      });
    }

    // ค้นหาผู้ใช้จากรหัสบัตรประชาชน
    const [users] = await pool.execute(
      `SELECT Id, username, name, lastname, id_card_no, role, status, 
       email, contactnumber, employee_code, department_id, position_id, profile_image_url, birth_date,
       in_time, out_time
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

    // ตรวจสอบวันเดือนปีเกิด
    if (!user.birth_date) {
      return res.status(401).json({
        success: false,
        message: 'ไม่พบข้อมูลวันเดือนปีเกิดในระบบ กรุณาติดต่อผู้ดูแลระบบ'
      });
    }

    // แปลง birth_date จากฐานข้อมูลเป็น YYYY-MM-DD format
    // birth_date อาจเป็น Date object หรือ string
    let dbBirthDate;
    if (user.birth_date instanceof Date) {
      // ถ้าเป็น Date object ให้แปลงเป็น YYYY-MM-DD โดยไม่สน timezone
      const year = user.birth_date.getFullYear();
      const month = String(user.birth_date.getMonth() + 1).padStart(2, '0');
      const day = String(user.birth_date.getDate()).padStart(2, '0');
      dbBirthDate = `${year}-${month}-${day}`;
    } else if (typeof user.birth_date === 'string') {
      // ถ้าเป็น string ให้ตัดส่วนเวลาออก (ถ้ามี)
      dbBirthDate = user.birth_date.split('T')[0].split(' ')[0];
    } else {
      // ถ้าเป็น type อื่น ให้แปลงเป็น Date ก่อน
      const dateObj = new Date(user.birth_date);
      const year = dateObj.getFullYear();
      const month = String(dateObj.getMonth() + 1).padStart(2, '0');
      const day = String(dateObj.getDate()).padStart(2, '0');
      dbBirthDate = `${year}-${month}-${day}`;
    }

    // เปรียบเทียบวันเดือนปีเกิด
    if (dbBirthDate !== birth_date) {
      return res.status(401).json({
        success: false,
        message: 'วันเดือนปีเกิดไม่ถูกต้อง'
      });
    }

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
          profile_image_url: user.profile_image_url,
          in_time: user.in_time ? user.in_time.toString() : null,
          out_time: user.out_time ? user.out_time.toString() : null
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
       last_login_date, created_date, profile_image_url, in_time, out_time
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

