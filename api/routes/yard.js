const express = require('express');
const { authenticateToken } = require('../middleware/auth');
const yardController = require('../controllers/yardController');

const router = express.Router();

// GET /api/yard/yards - ดึงข้อมูล yard ทั้งหมดที่มีข้อมูลครบถ้วน
router.get('/yards', authenticateToken, yardController.getUserYards);

module.exports = router;

