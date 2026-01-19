const pool = require('../config/database');
const multer = require('multer');
const path = require('path');
const fs = require('fs').promises;
const fsSync = require('fs');

// ตั้งค่า multer สำหรับอัพโหลดไฟล์รูปภาพ
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const uploadDir = path.join(__dirname, '..', 'uploads', 'check_in_images');
    // สร้าง folder ถ้ายังไม่มี
    if (!fsSync.existsSync(uploadDir)) {
      fsSync.mkdirSync(uploadDir, { recursive: true });
    }
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    // ตั้งชื่อไฟล์: checkin_{userId}_{timestamp}.{extension}
    const userId = req.user?.Id || 'unknown';
    const timestamp = Date.now();
    const ext = path.extname(file.originalname);
    cb(null, `checkin_${userId}_${timestamp}${ext}`);
  }
});

// ตรวจสอบประเภทไฟล์
const fileFilter = (req, file, cb) => {
  const allowedTypes = /jpeg|jpg|png|gif|webp/;
  const extname = allowedTypes.test(path.extname(file.originalname).toLowerCase());
  const mimetype = allowedTypes.test(file.mimetype);

  if (mimetype && extname) {
    return cb(null, true);
  } else {
    cb(new Error('กรุณาอัพโหลดไฟล์รูปภาพเท่านั้น (jpeg, jpg, png, gif, webp)'));
  }
};

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 5 * 1024 * 1024 // 5MB
  },
  fileFilter: fileFilter
});

// Middleware สำหรับอัพโหลดไฟล์ (optional - ไม่บังคับ)
const uploadMiddleware = upload.single('image');

// ฟังก์ชันแปลง datetime จาก UTC เป็น UTC+7 (Thailand timezone)
const convertToThailandTime = (date) => {
  if (!date) return null;
  // ถ้าเป็น string ให้แปลงเป็น Date object ก่อน
  const dateObj = typeof date === 'string' ? new Date(date) : date;
  if (!(dateObj instanceof Date) || isNaN(dateObj.getTime())) return null;
  
  // เพิ่ม 7 ชั่วโมง (UTC+7)
  const thailandTime = new Date(dateObj.getTime() + (7 * 60 * 60 * 1000));
  return thailandTime;
};

// เช็คอินเข้างาน
const checkInJob = async (req, res) => {
  uploadMiddleware(req, res, async (err) => {
    if (err) {
      return res.status(400).json({
        success: false,
        message: err.message || 'เกิดข้อผิดพลาดในการอัพโหลดไฟล์'
      });
    }

    console.log('🔵 [CheckInJob] ========================================');
    console.log('🔵 [CheckInJob] API called: POST /api/check-in-job/check-in');
    console.log('🔵 [CheckInJob] Request body:', JSON.stringify(req.body));
    console.log('🔵 [CheckInJob] User ID:', req.user?.Id);
    console.log('🔵 [CheckInJob] File uploaded:', req.file ? req.file.filename : 'No file');
    
    try {
      const userId = req.user.Id;
      const { user_lat, user_long, mileage } = req.body;
      
      // ตรวจสอบว่ามีรูปภาพหรือไม่ และสร้าง URL
      let imageUrl = null;
      if (req.file) {
        const filePath = `/uploads/check_in_images/${req.file.filename}`;
        const baseUrl = process.env.BASE_URL || `${req.protocol}://${req.get('host')}`;
        imageUrl = `${baseUrl}${filePath}`;
        console.log('🔵 [CheckInJob] Image URL:', imageUrl);
      }
      
      console.log('🔵 [CheckInJob] Parsed data - userId:', userId, 'user_lat:', user_lat, 'user_long:', user_long, 'mileage:', mileage, 'imageUrl:', imageUrl);

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

    // ตรวจสอบและอัปเดต job routes ที่มี plan_in, plan_in2, plan_out, plan_out2
    // ทำก่อนการตรวจสอบ existing check-in เพื่อให้ตรวจสอบทุกครั้งที่มีการเช็คอิน
    // แปลงเวลาเป็นเวลาไทย (UTC+7)
    const now = new Date();
    const checkInTime = convertToThailandTime(now);
    
    // คำนวณวันที่จากเวลาไทย (ใช้ UTC date โดยตรงจาก now เพื่อความถูกต้อง)
    const checkInDateUTC = new Date(now);
    checkInDateUTC.setUTCHours(0, 0, 0, 0);
    const checkInDateStr = checkInDateUTC.toISOString().split('T')[0]; // YYYY-MM-DD
    
    // คำนวณวันที่จากเวลาไทยสำหรับแสดงผล
    const checkInDateTh = new Date(checkInTime);
    checkInDateTh.setHours(0, 0, 0, 0);
    
    console.log(`🔵 [CheckInJob] Checking routes for actual_in/actual_out updates...`);
    console.log(`[CheckIn] UTC time: ${now.toISOString()}`);
    console.log(`[CheckIn] Thailand time: ${checkInTime.toISOString()}`);
    console.log(`[CheckIn] Thailand date: ${checkInDateTh.toISOString().split('T')[0]}`);
    console.log(`[CheckIn] UTC date for query: ${checkInDateStr}`);
    console.log(`[CheckIn] Searching routes for driver_id: ${userId}, date: ${checkInDateStr} (UTC)`);
    console.log(`[CheckIn] Check-in time (Thailand): ${checkInTime.toISOString()}`);
    
    // Query routes ทั้งหมดของวันนั้น (ไม่ filter actual_in/actual_out เพื่อให้สามารถอัปเดตได้ทุกครั้ง)
    const [routes] = await pool.execute(
      `SELECT jr.id, jr.job_id, jr.plan_in, jr.plan_out, jr.plan_in2, jr.plan_out2, 
              jr.actual_in, jr.actual_out, jr.actual_in2, jr.actual_out2
       FROM tb_job_route jr
       INNER JOIN tb_job_master jm ON jr.job_id = jm.job_id
       WHERE jm.driver_id = ?
         AND (
           (jr.plan_in IS NOT NULL AND DATE(jr.plan_in) = ?) OR
           (jr.plan_in2 IS NOT NULL AND DATE(jr.plan_in2) = ?) OR
           (jr.plan_out IS NOT NULL AND DATE(jr.plan_out) = ?) OR
           (jr.plan_out2 IS NOT NULL AND DATE(jr.plan_out2) = ?)
         )
       ORDER BY COALESCE(jr.plan_in, jr.plan_in2) ASC`,
      [userId, checkInDateStr, checkInDateStr, checkInDateStr, checkInDateStr]
    );

    console.log(`[CheckIn] Found ${routes.length} route(s) to check for date ${checkInDateStr} (UTC)`);
    if (routes.length === 0) {
      console.log(`[CheckIn] ⚠️ No routes found for driver ${userId} on date ${checkInDateStr}`);
      // Debug: ตรวจสอบว่ามี routes สำหรับ driver นี้หรือไม่
      const [allRoutes] = await pool.execute(
        `SELECT jr.id, jr.job_id, DATE(jr.plan_in) as plan_in_date, DATE(jr.plan_out) as plan_out_date
         FROM tb_job_route jr
         INNER JOIN tb_job_master jm ON jr.job_id = jm.job_id
         WHERE jm.driver_id = ?
         ORDER BY jr.plan_in DESC
         LIMIT 5`,
        [userId]
      );
      console.log(`[CheckIn] Debug: Found ${allRoutes.length} total route(s) for driver ${userId}`);
      if (allRoutes.length > 0) {
        console.log(`[CheckIn] Debug: Recent routes:`, allRoutes.map(r => ({
          id: r.id,
          job_id: r.job_id,
          plan_in_date: r.plan_in_date,
          plan_out_date: r.plan_out_date
        })));
      }
    }
    
    const updatedRoutes = [];
    
    // ตรวจสอบและอัปเดต actual_in/actual_out ก่อน
    for (const route of routes) {
      console.log(`[CheckIn] ========================================`);
      console.log(`[CheckIn] Route ID: ${route.id}, Job ID: ${route.job_id}`);
      if (route.plan_in) {
        const planInTh = convertToThailandTime(route.plan_in);
        console.log(`[CheckIn] Plan_in: ${new Date(route.plan_in).toISOString()} (UTC) / ${planInTh.toISOString()} (Thailand)`);
      } else {
        console.log(`[CheckIn] Plan_in: null`);
      }
      if (route.plan_out) {
        const planOutTh = convertToThailandTime(route.plan_out);
        console.log(`[CheckIn] Plan_out: ${new Date(route.plan_out).toISOString()} (UTC) / ${planOutTh.toISOString()} (Thailand)`);
      } else {
        console.log(`[CheckIn] Plan_out: null`);
      }
      if (route.plan_in2) {
        const planIn2Th = convertToThailandTime(route.plan_in2);
        console.log(`[CheckIn] Plan_in2: ${new Date(route.plan_in2).toISOString()} (UTC) / ${planIn2Th.toISOString()} (Thailand)`);
      } else {
        console.log(`[CheckIn] Plan_in2: null`);
      }
      if (route.plan_out2) {
        const planOut2Th = convertToThailandTime(route.plan_out2);
        console.log(`[CheckIn] Plan_out2: ${new Date(route.plan_out2).toISOString()} (UTC) / ${planOut2Th.toISOString()} (Thailand)`);
      } else {
        console.log(`[CheckIn] Plan_out2: null`);
      }
      if (route.actual_in) {
        const actualInTh = convertToThailandTime(route.actual_in);
        console.log(`[CheckIn] Actual_in: ${new Date(route.actual_in).toISOString()} (UTC) / ${actualInTh.toISOString()} (Thailand)`);
      } else {
        console.log(`[CheckIn] Actual_in: null`);
      }
      if (route.actual_out) {
        const actualOutTh = convertToThailandTime(route.actual_out);
        console.log(`[CheckIn] Actual_out: ${new Date(route.actual_out).toISOString()} (UTC) / ${actualOutTh.toISOString()} (Thailand)`);
      } else {
        console.log(`[CheckIn] Actual_out: null`);
      }
      if (route.actual_in2) {
        const actualIn2Th = convertToThailandTime(route.actual_in2);
        console.log(`[CheckIn] Actual_in2: ${new Date(route.actual_in2).toISOString()} (UTC) / ${actualIn2Th.toISOString()} (Thailand)`);
      } else {
        console.log(`[CheckIn] Actual_in2: null`);
      }
      if (route.actual_out2) {
        const actualOut2Th = convertToThailandTime(route.actual_out2);
        console.log(`[CheckIn] Actual_out2: ${new Date(route.actual_out2).toISOString()} (UTC) / ${actualOut2Th.toISOString()} (Thailand)`);
      } else {
        console.log(`[CheckIn] Actual_out2: null`);
      }
      console.log(`[CheckIn] Check-in time (Thailand): ${checkInTime.toISOString()}`);
      
      // ตรวจสอบ actual_in: ถ้าเวลาเช็คอินมากกว่า plan_in ให้ใส่เวลาเช็คอินที่ actual_in
      let actualInUpdated = false;
      if (route.actual_in === null && 
          route.plan_in !== null) {
        const planInTimeUTC = new Date(route.plan_in);
        const planInTime = convertToThailandTime(planInTimeUTC);
        console.log(`[CheckIn] Checking actual_in - Plan_in (UTC): ${planInTimeUTC.toISOString()}, Plan_in (Thailand): ${planInTime.toISOString()}, Check-in (Thailand): ${checkInTime.toISOString()}, Is greater: ${checkInTime > planInTime}`);
        if (checkInTime > planInTime) {
          // แปลงกลับเป็น UTC สำหรับบันทึกลง database
          const checkInTimeUTC = new Date(checkInTime.getTime() - (7 * 60 * 60 * 1000));
          await pool.execute(
            `UPDATE tb_job_route 
             SET actual_in = ?, updated_by = ?, updated_date = NOW() 
             WHERE id = ?`,
            [checkInTimeUTC, req.user.username || userId.toString(), route.id]
          );
          console.log(`[CheckIn] ✅ Updated actual_in for route ${route.id}`);
          updatedRoutes.push({ routeId: route.id, field: 'actual_in' });
          // อัปเดต route.actual_in เพื่อให้สามารถตรวจสอบ actual_out ได้ในรอบเดียวกัน
          route.actual_in = checkInTimeUTC;
          actualInUpdated = true;
        } else {
          console.log(`[CheckIn] ❌ Skipped actual_in - Check-in time is not greater than plan_in`);
        }
      } else {
        if (route.actual_in !== null) {
          console.log(`[CheckIn] ⚠️ Skipped actual_in - already has value: ${new Date(route.actual_in).toISOString()}`);
        } else if (route.plan_in === null) {
          console.log(`[CheckIn] ⚠️ Skipped actual_in - plan_in is null`);
        }
      }

      // ตรวจสอบ actual_in2: ถ้าเวลาเช็คอินมากกว่า plan_in2 ให้ใส่เวลาเช็คอินที่ actual_in2
      let actualIn2Updated = false;
      if (route.actual_in2 === null && 
          route.plan_in2 !== null) {
        const planIn2TimeUTC = new Date(route.plan_in2);
        const planIn2Time = convertToThailandTime(planIn2TimeUTC);
        console.log(`[CheckIn] Checking actual_in2 - Plan_in2 (UTC): ${planIn2TimeUTC.toISOString()}, Plan_in2 (Thailand): ${planIn2Time.toISOString()}, Check-in (Thailand): ${checkInTime.toISOString()}, Is greater: ${checkInTime > planIn2Time}`);
        if (checkInTime > planIn2Time) {
          // แปลงกลับเป็น UTC สำหรับบันทึกลง database
          const checkInTimeUTC = new Date(checkInTime.getTime() - (7 * 60 * 60 * 1000));
          await pool.execute(
            `UPDATE tb_job_route 
             SET actual_in2 = ?, updated_by = ?, updated_date = NOW() 
             WHERE id = ?`,
            [checkInTimeUTC, req.user.username || userId.toString(), route.id]
          );
          console.log(`[CheckIn] ✅ Updated actual_in2 for route ${route.id}`);
          updatedRoutes.push({ routeId: route.id, field: 'actual_in2' });
          // อัปเดต route.actual_in2 เพื่อให้สามารถตรวจสอบ actual_out2 ได้ในรอบเดียวกัน
          route.actual_in2 = checkInTimeUTC;
          actualIn2Updated = true;
        } else {
          console.log(`[CheckIn] ❌ Skipped actual_in2 - Check-in time is not greater than plan_in2`);
        }
      } else {
        if (route.actual_in2 !== null) {
          console.log(`[CheckIn] ⚠️ Skipped actual_in2 - already has value: ${new Date(route.actual_in2).toISOString()}`);
        } else if (route.plan_in2 === null) {
          console.log(`[CheckIn] ⚠️ Skipped actual_in2 - plan_in2 is null`);
        }
      }

      // ตรวจสอบ actual_out: ถ้าเวลาเช็คอินมากกว่า plan_out และมี actual_in แล้ว ให้ใส่เวลาเช็คอินที่ actual_out
      console.log(`[CheckIn] ========== Checking actual_out ==========`);
      console.log(`[CheckIn] Route ID: ${route.id}`);
      console.log(`[CheckIn] actual_out is null: ${route.actual_out === null}`);
      console.log(`[CheckIn] plan_out is not null: ${route.plan_out !== null}`);
      console.log(`[CheckIn] actual_in is not null: ${route.actual_in !== null}`);
      console.log(`[CheckIn] actual_in was just updated: ${actualInUpdated}`);
      
      if (route.actual_out === null && 
          route.plan_out !== null && 
          (route.actual_in !== null || actualInUpdated)) {
        const planOutTimeUTC = new Date(route.plan_out);
        const planOutTime = convertToThailandTime(planOutTimeUTC);
        console.log(`[CheckIn] Plan_out (UTC): ${planOutTimeUTC.toISOString()}`);
        console.log(`[CheckIn] Plan_out (Thailand): ${planOutTime.toISOString()}`);
        console.log(`[CheckIn] Check-in (Thailand): ${checkInTime.toISOString()}`);
        console.log(`[CheckIn] Check-in time > Plan_out time: ${checkInTime > planOutTime}`);
        console.log(`[CheckIn] Time difference (ms): ${checkInTime.getTime() - planOutTime.getTime()}`);
        console.log(`[CheckIn] Time difference (minutes): ${(checkInTime.getTime() - planOutTime.getTime()) / (1000 * 60)}`);
        
        if (checkInTime > planOutTime) {
          // แปลงกลับเป็น UTC สำหรับบันทึกลง database
          const checkInTimeUTC = new Date(checkInTime.getTime() - (7 * 60 * 60 * 1000));
          console.log(`[CheckIn] Updating actual_out with UTC time: ${checkInTimeUTC.toISOString()}`);
          await pool.execute(
            `UPDATE tb_job_route 
             SET actual_out = ?, updated_by = ?, updated_date = NOW() 
             WHERE id = ?`,
            [checkInTimeUTC, req.user.username || userId.toString(), route.id]
          );
          console.log(`[CheckIn] ✅ Updated actual_out for route ${route.id}`);
          updatedRoutes.push({ routeId: route.id, field: 'actual_out' });
        } else {
          console.log(`[CheckIn] ❌ Skipped actual_out - Check-in time is not greater than plan_out`);
        }
      } else {
        if (route.actual_out !== null) {
          console.log(`[CheckIn] ⚠️ Skipped actual_out - already has value: ${route.actual_out}`);
        } else if (route.plan_out === null) {
          console.log(`[CheckIn] ⚠️ Skipped actual_out - plan_out is null`);
        } else if (route.actual_in === null) {
          console.log(`[CheckIn] ⚠️ Skipped actual_out - actual_in is null (must have actual_in first)`);
        }
      }

      // ตรวจสอบ actual_out2: ถ้าเวลาเช็คอินมากกว่า plan_out2 และมี actual_in2 แล้ว ให้ใส่เวลาเช็คอินที่ actual_out2
      if (route.actual_out2 === null && 
          route.plan_out2 !== null && 
          (route.actual_in2 !== null || actualIn2Updated)) {
        const planOut2TimeUTC = new Date(route.plan_out2);
        const planOut2Time = convertToThailandTime(planOut2TimeUTC);
        console.log(`[CheckIn] Checking actual_out2 - Plan_out2 (UTC): ${planOut2TimeUTC.toISOString()}, Plan_out2 (Thailand): ${planOut2Time.toISOString()}, Check-in (Thailand): ${checkInTime.toISOString()}, Is greater: ${checkInTime > planOut2Time}`);
        if (checkInTime > planOut2Time) {
          // แปลงกลับเป็น UTC สำหรับบันทึกลง database
          const checkInTimeUTC = new Date(checkInTime.getTime() - (7 * 60 * 60 * 1000));
          await pool.execute(
            `UPDATE tb_job_route 
             SET actual_out2 = ?, updated_by = ?, updated_date = NOW() 
             WHERE id = ?`,
            [checkInTimeUTC, req.user.username || userId.toString(), route.id]
          );
          console.log(`[CheckIn] ✅ Updated actual_out2 for route ${route.id}`);
          updatedRoutes.push({ routeId: route.id, field: 'actual_out2' });
        } else {
          console.log(`[CheckIn] ❌ Skipped actual_out2 - Check-in time is not greater than plan_out2`);
        }
      } else if (route.actual_out2 === null && route.plan_out2 !== null) {
        console.log(`[CheckIn] ⚠️ Skipped actual_out2 - actual_in2 is null`);
      }
    }

    console.log(`🔵 [CheckInJob] Finished checking routes. Updated ${updatedRoutes.length} route(s)`);

    // ถ้าไม่มีการอัพเดตอะไรเลย ให้ตรวจสอบเงื่อนไขสำรอง
    // หา route ที่ actual_in = null และ actual_out = null และ plan_in <> null และ plan_out <> null
    // order by plan_in, plan_out asc และนำแถวที่น้อยที่สุดมาอัพเดต
    if (updatedRoutes.length === 0) {
      console.log(`[CheckIn] 🔄 No routes updated, checking fallback condition...`);
      console.log(`[CheckIn] Looking for routes with: actual_in = null, actual_out = null, plan_in IS NOT NULL, plan_out IS NOT NULL`);
      
      const [fallbackRoutes] = await pool.execute(
        `SELECT jr.id, jr.job_id, jr.plan_in, jr.plan_out
         FROM tb_job_route jr
         INNER JOIN tb_job_master jm ON jr.job_id = jm.job_id
         WHERE jm.driver_id = ?
           AND jr.actual_in IS NULL
           AND jr.actual_out IS NULL
           AND jr.plan_in IS NOT NULL
           AND jr.plan_out IS NOT NULL
           AND (
             (jr.plan_in IS NOT NULL AND DATE(jr.plan_in) = ?) OR
             (jr.plan_out IS NOT NULL AND DATE(jr.plan_out) = ?)
           )
         ORDER BY jr.plan_in ASC, jr.plan_out ASC
         LIMIT 1`,
        [userId, checkInDateStr, checkInDateStr]
      );

      if (fallbackRoutes.length > 0) {
        const fallbackRoute = fallbackRoutes[0];
        console.log(`[CheckIn] ✅ Found fallback route ID: ${fallbackRoute.id}, Job ID: ${fallbackRoute.job_id}`);
        console.log(`[CheckIn] Plan_in: ${new Date(fallbackRoute.plan_in).toISOString()}, Plan_out: ${new Date(fallbackRoute.plan_out).toISOString()}`);
        
        // อัพเดต actual_in และ actual_out ด้วยเวลาเช็คอิน
        const checkInTimeUTC = new Date(checkInTime.getTime() - (7 * 60 * 60 * 1000));
        
        await pool.execute(
          `UPDATE tb_job_route 
           SET actual_in = ?, actual_out = ?, updated_by = ?, updated_date = NOW() 
           WHERE id = ?`,
          [checkInTimeUTC, checkInTimeUTC, req.user.username || userId.toString(), fallbackRoute.id]
        );
        
        console.log(`[CheckIn] ✅ Updated fallback route ${fallbackRoute.id} - actual_in and actual_out set to check-in time`);
        updatedRoutes.push({ routeId: fallbackRoute.id, field: 'actual_in and actual_out (fallback)' });
      } else {
        console.log(`[CheckIn] ⚠️ No fallback route found matching the criteria`);
      }
    }

    // บันทึกการเช็คอินเข้างาน (insert ทุกครั้ง ไม่มีการตรวจสอบ existing check-in)
    // แปลงกลับเป็น UTC สำหรับบันทึกลง database
    const checkInTimeUTC = new Date(checkInTime.getTime() - (7 * 60 * 60 * 1000));
    console.log('🔵 [CheckInJob] Inserting check-in record...');
    console.log(`🔵 [CheckInJob] Check-in time (Thailand): ${checkInTime.toISOString()}`);
    console.log(`🔵 [CheckInJob] Check-in time (UTC for DB): ${checkInTimeUTC.toISOString()}`);
      const [result] = await pool.execute(
        `INSERT INTO tb_check_in_job 
         (user_id, check_in_time, user_lat, user_long, mileage, image_url, created_by, created_date)
         VALUES (?, ?, ?, ?, ?, ?, ?, NOW())`,
        [
          userId,
          checkInTimeUTC,
          user_lat,
          user_long,
          mileage,
          imageUrl,
          req.user.username || userId.toString(),
        ]
      );
    console.log(`🔵 [CheckInJob] ✅ Check-in record inserted with ID: ${result.insertId}`);

      res.json({
        success: true,
        message: 'เช็คอินเข้างานสำเร็จ',
        data: {
          id: result.insertId,
          check_in_time: checkInTime, // ส่งกลับเป็นเวลาไทย
          user_lat: user_lat,
          user_long: user_long,
          mileage: mileage,
          image_url: imageUrl,
          updatedRoutes: updatedRoutes,
        },
      });
    } catch (error) {
      console.error('🔴 [CheckInJob] ERROR:', error);
      console.error('🔴 [CheckInJob] Error stack:', error.stack);
      // ลบไฟล์ที่อัพโหลดแล้วถ้าเกิด error
      if (req.file && fsSync.existsSync(req.file.path)) {
        fsSync.unlinkSync(req.file.path);
      }
      res.status(500).json({
        success: false,
        message: 'เกิดข้อผิดพลาดในการเช็คอินเข้างาน',
        error: process.env.NODE_ENV === 'development' ? error.message : undefined,
      });
    }
  });
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

// ดึงข้อมูลเช็คอินเข้างานตามวันที่
const getCheckInJobsByDate = async (req, res) => {
  try {
    const userId = req.user.Id;
    const { date } = req.query; // YYYY-MM-DD format

    console.log('📅 [CheckInJob] getCheckInJobsByDate - Request received');
    console.log('📅 [CheckInJob] User ID:', userId);
    console.log('📅 [CheckInJob] Date query:', date);

    if (!date) {
      return res.status(400).json({
        success: false,
        message: 'กรุณาระบุวันที่',
      });
    }

    // แปลงวันที่เป็น UTC สำหรับ query
    const dateObj = new Date(date + 'T00:00:00');

    console.log('📅 [CheckInJob] Original date:', date);

    const [checkIns] = await pool.execute(
      `SELECT id, user_id, check_in_time, user_lat, user_long, mileage, created_date
       FROM tb_check_in_job 
       WHERE user_id = ? 
       AND DATE(check_in_time) = ?
       AND status = 1
       ORDER BY check_in_time ASC`,
      [userId, date]
    );

    console.log(`📅 [CheckInJob] Found ${checkIns.length} check-in(s) in database`);

    // แปลงเวลาเป็น UTC+7 (Thailand time)
    const checkInsWithThailandTime = checkIns.map((checkIn) => {
      const checkInTimeUTC = new Date(checkIn.check_in_time);
      const checkInTimeTh = new Date(checkInTimeUTC.getTime() + (7 * 60 * 60 * 1000));
      console.log('📅 [CheckInJob] Check-in ID:', checkIn.id, 'UTC:', checkInTimeUTC.toISOString(), 'Thailand:', checkInTimeTh.toISOString());
      return {
        id: checkIn.id,
        userId: checkIn.user_id,
        checkInTime: checkInTimeTh.toISOString(),
        userLat: checkIn.user_lat ? parseFloat(checkIn.user_lat) : null,
        userLong: checkIn.user_long ? parseFloat(checkIn.user_long) : null,
        mileage: checkIn.mileage ? parseFloat(checkIn.mileage) : null,
        createdDate: checkIn.created_date,
      };
    });

    console.log(`📅 [CheckInJob] Returning ${checkInsWithThailandTime.length} check-in(s)`);

    res.json({
      success: true,
      message: 'ดึงข้อมูลเช็คอินเข้างานสำเร็จ',
      data: checkInsWithThailandTime,
    });
  } catch (error) {
    console.error('❌ [CheckInJob] Get check in jobs by date error:', error);
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
  getCheckInJobsByDate,
};

