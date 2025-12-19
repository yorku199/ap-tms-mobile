const express = require('express');
const { authenticateToken } = require('../middleware/auth');
const jobOrderController = require('../controllers/jobOrderController');

const router = express.Router();

// GET /api/job-order - ดึง job orders ของ driver ณ วันนั้น
router.get('/', authenticateToken, jobOrderController.getJobOrders);

// POST /api/job-order/:jobId/accept - รับงาน
router.post('/:jobId/accept', authenticateToken, jobOrderController.acceptJob);

// POST /api/job-order/route/:routeId/check-in?isSecond=true - Check In (isSecond=true สำหรับ actual_in2)
router.post('/route/:routeId/check-in', authenticateToken, jobOrderController.checkIn);

// POST /api/job-order/route/:routeId/check-out?isSecond=true - Check Out (isSecond=true สำหรับ actual_out2)
router.post('/route/:routeId/check-out', authenticateToken, jobOrderController.checkOut);

module.exports = router;