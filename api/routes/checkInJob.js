const express = require('express');
const { authenticateToken } = require('../middleware/auth');
const checkInJobController = require('../controllers/checkInJobController');

const router = express.Router();

// POST /api/check-in-job/check-in - เช็คอินเข้างาน
router.post('/check-in', authenticateToken, (req, res, next) => {
  console.log('🟢 [CheckInJob Route] POST /api/check-in-job/check-in - Request received');
  console.log('🟢 [CheckInJob Route] Request body:', JSON.stringify(req.body));
  console.log('🟢 [CheckInJob Route] User:', req.user);
  next();
}, checkInJobController.checkInJob);

// GET /api/check-in-job/latest - ดึงข้อมูลเช็คอินเข้างานล่าสุด
router.get('/latest', authenticateToken, checkInJobController.getLatestCheckInJob);

// GET /api/check-in-job/by-date?date=YYYY-MM-DD - ดึงข้อมูลเช็คอินเข้างานตามวันที่
router.get('/by-date', authenticateToken, checkInJobController.getCheckInJobsByDate);

module.exports = router;

