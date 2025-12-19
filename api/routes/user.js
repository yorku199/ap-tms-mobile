const express = require('express');
const { authenticateToken } = require('../middleware/auth');
const userController = require('../controllers/userController');

const router = express.Router();

// POST /api/user/upload-profile-image - อัพโหลดรูป profile
router.post('/upload-profile-image', authenticateToken, userController.uploadProfileImage);

module.exports = router;

