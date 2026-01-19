const express = require('express');
const cors = require('cors');
const path = require('path');
require('dotenv').config();

const authRoutes = require('./routes/auth');
const jobOrderRoutes = require('./routes/job_order');
const userRoutes = require('./routes/user');
const checkInRoutes = require('./routes/checkIn');
const yardRoutes = require('./routes/yard');
const checkInJobRoutes = require('./routes/checkInJob');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Serve static files (สำหรับรูปภาพที่อัพโหลด)
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({
    success: true,
    message: 'API is running',
    timestamp: new Date().toISOString()
  });
});

// API Routes
app.use('/api/auth', authRoutes);
app.use('/api/job-order', jobOrderRoutes);
app.use('/api/user', userRoutes);
app.use('/api/check-in', checkInRoutes);
app.use('/api/yard', yardRoutes);
app.use('/api/check-in-job', checkInJobRoutes);

// 404 Handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: 'ไม่พบ endpoint ที่ต้องการ'
  });
});

// Error Handler
app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(500).json({
    success: false,
    message: 'เกิดข้อผิดพลาดในระบบ',
    error: process.env.NODE_ENV === 'development' ? err.message : undefined
  });
});

// Start server
// Bind to 0.0.0.0 to accept connections from all network interfaces
// This allows Physical Devices on the same network to connect
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Server is running on port ${PORT}`);
  console.log(`📝 Environment: ${process.env.NODE_ENV || 'development'}`);
  console.log(`🔗 Health check: http://localhost:${PORT}/health`);
  console.log(`🔐 Auth endpoint: http://localhost:${PORT}/api/auth/login`);
  console.log(`🌐 Network access: http://<your-ip-address>:${PORT}`);
  console.log(`📱 For Physical Device: Make sure your device is on the same network`);
});

module.exports = app;

