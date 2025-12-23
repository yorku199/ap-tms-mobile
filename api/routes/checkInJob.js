const express = require('express');
const { authenticateToken } = require('../middleware/auth');
const checkInJobController = require('../controllers/checkInJobController');

const router = express.Router();

// POST /api/check-in-job/check-in - เช็คอินเข้างาน
router.post('/check-in', authenticateToken, checkInJobController.checkInJob);

// GET /api/check-in-job/latest - ดึงข้อมูลเช็คอินเข้างานล่าสุด
router.get('/latest', authenticateToken, checkInJobController.getLatestCheckInJob);

module.exports = router;

