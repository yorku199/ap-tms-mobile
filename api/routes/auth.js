const express = require('express');
const { authenticateToken } = require('../middleware/auth');
const authController = require('../controllers/authController');

const router = express.Router();

// POST /api/auth/login - เข้าสู่ระบบด้วยรหัสบัตรประชาชน
router.post('/login', authController.login);

// GET /api/auth/me - ดูข้อมูลผู้ใช้ปัจจุบัน
router.get('/me', authenticateToken, authController.getCurrentUser);

// POST /api/auth/logout - ออกจากระบบ
router.post('/logout', authenticateToken, authController.logout);

// POST /api/auth/verify - ตรวจสอบ Token
router.post('/verify', authenticateToken, authController.verifyToken);

module.exports = router;

