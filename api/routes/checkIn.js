const express = require('express');
const { authenticateToken } = require('../middleware/auth');
const checkInController = require('../controllers/checkInController');

const router = express.Router();

// GET /api/check-in/yards - ดึงข้อมูล yard ของ user
router.get('/yards', authenticateToken, checkInController.getUserYards);

// POST /api/check-in/check-in - เช็คอิน
router.post('/check-in', authenticateToken, checkInController.checkIn);

// POST /api/check-in/check-out - เช็คเอาท์
router.post('/check-out', authenticateToken, checkInController.checkOut);

// GET /api/check-in/latest - ดึงข้อมูล check in ล่าสุด
router.get('/latest', authenticateToken, checkInController.getLatestCheckIn);

module.exports = router;

