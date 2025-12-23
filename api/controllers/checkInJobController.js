const pool = require('../config/database');

// เช็คอินเข้างาน
const checkInJob = async (req, res) => {
  try {
    const userId = req.user.Id;
    const { user_lat, user_long, mileage } = req.body;

    // ตรวจสอบข้อมูลที่จำเป็น
    if (user_lat === undefined || user_long === undefined) {
      return res.status(400).json({
        success: false,
        message: 'กรุณากรอกข้อมูล latitude และ longitude',
      });
    }

    // ตรวจสอบว่า mileage ต้องมีค่า
    if (mileage === undefined || mileage === null) {
      return res.status(400).json({
        success: false,
        message: 'กรุณากรอกเลขไมล์',
      });
    }

    // ตรวจสอบว่ามี check in วันนี้หรือไม่
    const [existingCheckIn] = await pool.execute(
      `SELECT id FROM tb_check_in_job 
       WHERE user_id = ? 
       AND DATE(check_in_time) = DATE(NOW())
       AND status = 1
       ORDER BY check_in_time DESC 
       LIMIT 1`,
      [userId]
    );

    if (existingCheckIn.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'คุณได้เช็คอินเข้างานวันนี้แล้ว',
      });
    }

    // บันทึกการเช็คอินเข้างาน
    const checkInTime = new Date();
    const [result] = await pool.execute(
      `INSERT INTO tb_check_in_job 
       (user_id, check_in_time, user_lat, user_long, mileage, created_by, created_date)
       VALUES (?, ?, ?, ?, ?, ?, NOW())`,
      [
        userId,
        checkInTime,
        user_lat,
        user_long,
        mileage,
        req.user.username || userId.toString(),
      ]
    );

    // ตรวจสอบและอัปเดต job routes ที่มี plan_in หลังเวลาเช็คอิน
    // หา job routes ที่ driver_id = userId และ plan_in <= check_in_time
    const [routes] = await pool.execute(
      `SELECT jr.id, jr.job_id, jr.plan_in, jr.plan_out, jr.actual_in, jr.actual_out, jr.actual_in2, jr.actual_out2
       FROM tb_job_route jr
       INNER JOIN tb_job_master jm ON jr.job_id = jm.job_id
       WHERE jm.driver_id = ?
         AND jr.plan_in IS NOT NULL
         AND jr.plan_in <= ?
         AND (jr.actual_in IS NULL OR jr.actual_out IS NULL OR jr.actual_in2 IS NULL OR jr.actual_out2 IS NULL)
       ORDER BY jr.plan_in ASC`,
      [userId, checkInTime]
    );

    const updatedRoutes = [];
    
    for (const route of routes) {
      // ตรวจสอบ actual_in
      if (route.actual_in === null && route.plan_in <= checkInTime) {
        await pool.execute(
          `UPDATE tb_job_route 
           SET actual_in = ?, updated_by = ?, updated_date = NOW() 
           WHERE id = ?`,
          [checkInTime, req.user.username || userId.toString(), route.id]
        );
        updatedRoutes.push({ routeId: route.id, field: 'actual_in' });
      }

      // ตรวจสอบ actual_in2
      if (route.actual_in2 === null && route.plan_in <= checkInTime) {
        await pool.execute(
          `UPDATE tb_job_route 
           SET actual_in2 = ?, updated_by = ?, updated_date = NOW() 
           WHERE id = ?`,
          [checkInTime, req.user.username || userId.toString(), route.id]
        );
        updatedRoutes.push({ routeId: route.id, field: 'actual_in2' });
      }

      // ตรวจสอบ actual_out (ต้องมี actual_in ก่อน)
      if (route.plan_out !== null && 
          route.plan_out <= checkInTime && 
          route.actual_out === null && 
          (route.actual_in !== null || route.actual_in2 !== null)) {
        await pool.execute(
          `UPDATE tb_job_route 
           SET actual_out = ?, updated_by = ?, updated_date = NOW() 
           WHERE id = ?`,
          [checkInTime, req.user.username || userId.toString(), route.id]
        );
        updatedRoutes.push({ routeId: route.id, field: 'actual_out' });
      }

      // ตรวจสอบ actual_out2 (ต้องมี actual_in2 ก่อน)
      if (route.plan_out !== null && 
          route.plan_out <= checkInTime && 
          route.actual_out2 === null && 
          route.actual_in2 !== null) {
        await pool.execute(
          `UPDATE tb_job_route 
           SET actual_out2 = ?, updated_by = ?, updated_date = NOW() 
           WHERE id = ?`,
          [checkInTime, req.user.username || userId.toString(), route.id]
        );
        updatedRoutes.push({ routeId: route.id, field: 'actual_out2' });
      }
    }

    res.json({
      success: true,
      message: 'เช็คอินเข้างานสำเร็จ',
      data: {
        id: result.insertId,
        check_in_time: checkInTime,
        user_lat: user_lat,
        user_long: user_long,
        mileage: mileage,
        updatedRoutes: updatedRoutes,
      },
    });
  } catch (error) {
    console.error('Check in job error:', error);
    res.status(500).json({
      success: false,
      message: 'เกิดข้อผิดพลาดในการเช็คอินเข้างาน',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined,
    });
  }
};

// ดึงข้อมูลเช็คอินเข้างานล่าสุด
const getLatestCheckInJob = async (req, res) => {
  try {
    const userId = req.user.Id;

    const [checkIns] = await pool.execute(
      `SELECT id, user_id, check_in_time, user_lat, user_long, mileage, created_date
       FROM tb_check_in_job 
       WHERE user_id = ? 
       AND status = 1
       ORDER BY check_in_time DESC 
       LIMIT 1`,
      [userId]
    );

    if (checkIns.length === 0) {
      return res.json({
        success: true,
        message: 'ไม่พบข้อมูลการเช็คอินเข้างาน',
        data: null,
      });
    }

    const checkIn = checkIns[0];

    res.json({
      success: true,
      message: 'ดึงข้อมูลเช็คอินเข้างานล่าสุดสำเร็จ',
      data: {
        id: checkIn.id,
        userId: checkIn.user_id,
        checkInTime: checkIn.check_in_time,
        userLat: checkIn.user_lat ? parseFloat(checkIn.user_lat) : null,
        userLong: checkIn.user_long ? parseFloat(checkIn.user_long) : null,
        mileage: checkIn.mileage ? parseFloat(checkIn.mileage) : null,
        createdDate: checkIn.created_date,
      },
    });
  } catch (error) {
    console.error('Get latest check in job error:', error);
    res.status(500).json({
      success: false,
      message: 'เกิดข้อผิดพลาดในการดึงข้อมูลเช็คอินเข้างาน',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined,
    });
  }
};

module.exports = {
  checkInJob,
  getLatestCheckInJob,
};

