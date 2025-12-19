const pool = require('../config/database');

// ฟังก์ชันแปลง datetime จาก UTC เป็น UTC+7 (Thailand timezone)
const convertToThailandTime = (date) => {
  if (!date) return null;
  // ถ้าเป็น string ให้แปลงเป็น Date object ก่อน
  const dateObj = typeof date === 'string' ? new Date(date) : date;
  if (!(dateObj instanceof Date) || isNaN(dateObj.getTime())) return null;
  
  // เพิ่ม 7 ชั่วโมง (UTC+7)
  const thailandTime = new Date(dateObj.getTime() + (7 * 60 * 60 * 1000));
  return thailandTime.toISOString();
};

// ดึง job orders ของ driver ณ วันนั้น
const getJobOrders = async (req, res) => {
  try {
    const driverId = req.user.Id;
    
    // ดึงวันที่ปัจจุบันใน timezone ประเทศไทย (UTC+7)
    const now = new Date();
    const thailandOffset = 7 * 60; // UTC+7 ในหน่วยนาที
    const utcTime = now.getTime() + (now.getTimezoneOffset() * 60000);
    const thailandTime = new Date(utcTime + (thailandOffset * 60000));
    
    // ตั้งเวลาเป็น 00:00:00 ของวันนี้ใน timezone ประเทศไทย
    const today = new Date(thailandTime);
    today.setHours(0, 0, 0, 0);
    
    // คำนวณวันที่เริ่มต้น (วันนี้ - 1 วัน) และวันที่สิ้นสุด (วันนี้ + 1 วัน)
    const startDate = new Date(today);
    startDate.setDate(today.getDate() - 1);
    const endDate = new Date(today);
    endDate.setDate(today.getDate() + 1);
    
    // แปลงเป็น string format YYYY-MM-DD
    const formatDate = (date) => {
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const day = String(date.getDate()).padStart(2, '0');
      return `${year}-${month}-${day}`;
    };
    
    const startDateStr = formatDate(startDate);
    const endDateStr = formatDate(endDate);
    const todayStr = formatDate(today);

    console.log(`[JobOrder] Today (Thailand): ${todayStr}`);
    console.log(`[JobOrder] Fetching job orders for driver_id: ${driverId}, date range: ${startDateStr} to ${endDateStr}`);

    // ดึง job orders ของ driver ในช่วง ±1 วันจากวันปัจจุบัน
    // ถ้า job_class = 0 ให้ค้นหาที่ tb_job_master.driver_id
    // ถ้า job_class = 1 ให้ค้นหาที่ tb_job_route.driver_id
    // กรองวันที่จาก tb_job_route.plan_in และ plan_in2
    const queryString = `SELECT DISTINCT
        jm.job_id,
        jm.job_no,
        jm.status,
        jm.job_status,
        jm.status_receive,
        jm.driver_id,
        jm.job_class,
        jm.truck_tractor_id,
        jm.truck_trailer_id,
        jm.route_id,
        jm.stamp_date,
        tp.TRUCK_NUMBER AS truck_tractor_no,
        tp2.TRUCK_NUMBER AS truck_trailer_no,
        rm.route_name,
        rm.route_no
      FROM tb_job_master jm
      LEFT JOIN tb_truck_profile tp ON jm.truck_tractor_id = tp.Id
      LEFT JOIN tb_truck_profile tp2 ON jm.truck_trailer_id = tp2.Id
      LEFT JOIN tb_route_master rm ON jm.route_id = rm.id
      INNER JOIN tb_job_route jr ON jm.job_id = jr.job_id
      WHERE (
        (jm.job_class = 0 AND jm.driver_id = ?) OR
        (jm.job_class = 1 AND jr.driver_id = ?)
      )
        AND (
          (jr.plan_in IS NOT NULL AND DATE(jr.plan_in) BETWEEN ? AND ?) OR
          (jr.plan_in2 IS NOT NULL AND DATE(jr.plan_in2) BETWEEN ? AND ?)
        )
        AND jm.status != 0
      ORDER BY COALESCE(jr.plan_in, jr.plan_in2) DESC, jm.job_id DESC`;
    
    const queryParams = [driverId, driverId, startDateStr, endDateStr, startDateStr, endDateStr];
    
    console.log(`[JobOrder] Query: ${queryString}`);
    console.log(`[JobOrder] Parameters:`, queryParams);

    const [jobs] = await pool.execute(queryString, queryParams);

    console.log(`[JobOrder] Found ${jobs.length} job(s) for driver_id: ${driverId}`);

    // ดึง job routes สำหรับแต่ละ job
    const jobsWithRoutes = await Promise.all(
      jobs.map(async (job) => {
        // สำหรับ job_class = 0: แสดงทุก route โดยไม่กรองตาม driver_id
        // สำหรับ job_class = 1: กรองตาม driver_id
        // driver_name ให้ดึงเฉพาะเมื่อ driver_id ตรงกับ user ที่ login
        // กรองตาม plan_in และ plan_in2 อยู่ในช่วงวันที่ปัจจุบัน ±1 วัน
        
        let routeQueryString;
        let routeQueryParams;
        
        if (job.job_class === 0) {
          // job_class = 0: แสดงทุก route โดยไม่กรองตาม driver_id
          routeQueryParams = [driverId, job.job_id, startDateStr, endDateStr, startDateStr, endDateStr];
          routeQueryString = `SELECT 
              jr.id,
              jr.job_id,
              jr.route_detail_id,
              jr.plan_in,
              jr.plan_out,
              jr.plan_in2,
              jr.plan_out2,
              jr.actual_in,
              jr.actual_out,
              jr.actual_in2,
              jr.actual_out2,
              jr.status,
              jr.track_status,
              jr.service_type,
              jr.driver_id,
              CASE 
                WHEN jr.driver_id = ? THEN CONCAT(COALESCE(driver.name, ''), ' ', COALESCE(driver.lastname, ''))
                ELSE NULL
              END AS driver_name,
              rd.gsdb_id,
              rd.service_type AS route_service_type,
              gsdb.GSDB_NAME AS location_name,
              gsdb.GSDB_CODE AS location_code,
              jr.gsdb_id2,
              gsdb2.GSDB_NAME AS location_name2,
              gsdb2.GSDB_CODE AS location_code2
            FROM tb_job_route jr
            LEFT JOIN tb_route_detail rd ON jr.route_detail_id = rd.id
            LEFT JOIN tb_gsdb_code gsdb ON rd.gsdb_id = gsdb.Id
            LEFT JOIN tb_gsdb_code gsdb2 ON jr.gsdb_id2 = gsdb2.Id
            LEFT JOIN tb_user driver ON jr.driver_id = driver.Id
            WHERE jr.job_id = ? 
              AND (
                (jr.plan_in IS NOT NULL AND DATE(jr.plan_in) BETWEEN ? AND ?) OR
                (jr.plan_in2 IS NOT NULL AND DATE(jr.plan_in2) BETWEEN ? AND ?)
              )
            ORDER BY jr.id ASC`;
        } else {
          // job_class = 1: กรองตาม driver_id
          routeQueryParams = [driverId, job.job_id, driverId, startDateStr, endDateStr, startDateStr, endDateStr];
          routeQueryString = `SELECT 
              jr.id,
              jr.job_id,
              jr.route_detail_id,
              jr.plan_in,
              jr.plan_out,
              jr.plan_in2,
              jr.plan_out2,
              jr.actual_in,
              jr.actual_out,
              jr.actual_in2,
              jr.actual_out2,
              jr.status,
              jr.track_status,
              jr.service_type,
              jr.driver_id,
              CASE 
                WHEN jr.driver_id = ? THEN CONCAT(COALESCE(driver.name, ''), ' ', COALESCE(driver.lastname, ''))
                ELSE NULL
              END AS driver_name,
              rd.gsdb_id,
              rd.service_type AS route_service_type,
              gsdb.GSDB_NAME AS location_name,
              gsdb.GSDB_CODE AS location_code,
              jr.gsdb_id2,
              gsdb2.GSDB_NAME AS location_name2,
              gsdb2.GSDB_CODE AS location_code2
            FROM tb_job_route jr
            LEFT JOIN tb_route_detail rd ON jr.route_detail_id = rd.id
            LEFT JOIN tb_gsdb_code gsdb ON rd.gsdb_id = gsdb.Id
            LEFT JOIN tb_gsdb_code gsdb2 ON jr.gsdb_id2 = gsdb2.Id
            LEFT JOIN tb_user driver ON jr.driver_id = driver.Id
            WHERE jr.job_id = ? 
              AND jr.driver_id = ?
              AND (
                (jr.plan_in IS NOT NULL AND DATE(jr.plan_in) BETWEEN ? AND ?) OR
                (jr.plan_in2 IS NOT NULL AND DATE(jr.plan_in2) BETWEEN ? AND ?)
              )
            ORDER BY jr.id ASC`;
        }
        
        console.log(`[JobOrder] Route Query for job_id ${job.job_id} (job_class: ${job.job_class}): ${routeQueryString}`);
        console.log(`[JobOrder] Route Query Parameters:`, routeQueryParams);

        const [routes] = await pool.execute(routeQueryString, routeQueryParams);
        
        console.log(`[JobOrder] Job ${job.job_no} (ID: ${job.job_id}) has ${routes.length} route(s)`);

        // แปลง datetime fields จาก UTC เป็น UTC+7 สำหรับทุก route
        const routesWithThailandTime = routes.map(route => ({
          ...route,
          plan_in: convertToThailandTime(route.plan_in),
          plan_out: convertToThailandTime(route.plan_out),
          plan_in2: convertToThailandTime(route.plan_in2),
          plan_out2: convertToThailandTime(route.plan_out2),
          actual_in: convertToThailandTime(route.actual_in),
          actual_out: convertToThailandTime(route.actual_out),
          actual_in2: convertToThailandTime(route.actual_in2),
          actual_out2: convertToThailandTime(route.actual_out2),
        }));

        // สร้าง route description จาก GSDB_NAME หรือใช้ route_name
        const routeDescriptions = routesWithThailandTime.map(r => r.location_name).filter(Boolean);
        const routeText = routeDescriptions.length > 0 
          ? routeDescriptions.join(' - ') 
          : job.route_name || job.route_no || 'ไม่ระบุ';

        // หา plan_in และ plan_out จาก route แรกและสุดท้าย
        const firstRoute = routesWithThailandTime[0];
        const lastRoute = routesWithThailandTime[routesWithThailandTime.length - 1];
        const planIn = firstRoute?.plan_in || null;
        const planOut = lastRoute?.plan_out || null;

        // กำหนด status text
        let statusText = 'Draft';
        if (job.status_receive === 1) {
          statusText = 'Accepted';
        } else if (job.status_receive === 2) {
          statusText = 'Completed';
        } else if (job.job_status) {
          statusText = job.job_status;
        }
        console.log(`[routes] ${JSON.stringify(routesWithThailandTime)}`);
        return {
          job_id: job.job_id,
          job_no: job.job_no,
          truck_no: job.truck_tractor_no || job.truck_trailer_no || 'ไม่ระบุ',
          route: routeText,
          plan_in: planIn,
          plan_out: planOut,
          stamp_date: convertToThailandTime(job.stamp_date),
          job_class: job.job_class || 0,
          status: statusText,
          status_receive: job.status_receive || 0,
          routes: routesWithThailandTime
        };
      })
    );

    console.log(`[JobOrder] Processed ${jobsWithRoutes.length} job(s) with routes`);

    // นับจำนวนงานตาม status
    const totalJobs = jobsWithRoutes.length;
    const completedJobs = jobsWithRoutes.filter(j => j.status_receive === 2).length;
    const acceptedJobs = jobsWithRoutes.filter(j => j.status_receive === 1).length;
    const pendingJobs = jobsWithRoutes.filter(j => j.status_receive === 0 || !j.status_receive).length;

    console.log(`[JobOrder] Summary - Total: ${totalJobs}, Completed: ${completedJobs}, Accepted: ${acceptedJobs}, Pending: ${pendingJobs}`);

    res.json({
      success: true,
      data: {
        summary: {
          total: totalJobs,
          completed: completedJobs,
          accepted: acceptedJobs,
          pending: pendingJobs
        },
        jobs: jobsWithRoutes
      }
    });
  } catch (error) {
    console.error('Get job orders error:', error);
    res.status(500).json({
      success: false,
      message: 'เกิดข้อผิดพลาดในการดึงข้อมูล job orders',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
};

// รับงาน
const acceptJob = async (req, res) => {
  try {
    const driverId = req.user.Id;
    const jobId = req.params.jobId;

    console.log(`[JobOrder] Accepting job - job_id: ${jobId}, driver_id: ${driverId}`);

    // ตรวจสอบว่า job นี้เป็นของ driver นี้หรือไม่
    // ถ้า job_class = 0 ให้ตรวจสอบที่ tb_job_master.driver_id
    // ถ้า job_class = 1 ให้ตรวจสอบที่ tb_job_route.driver_id
    const checkQuery = `SELECT DISTINCT
        jm.job_id, 
        jm.driver_id, 
        jm.job_class,
        jm.status_receive 
      FROM tb_job_master jm
      LEFT JOIN tb_job_route jr ON jm.job_id = jr.job_id
      WHERE jm.job_id = ? 
        AND (
          (jm.job_class = 0 AND jm.driver_id = ?) OR
          (jm.job_class = 1 AND jr.driver_id = ?)
        )`;
    const checkParams = [jobId, driverId, driverId];
    
    console.log(`[JobOrder] Check Query: ${checkQuery}`);
    console.log(`[JobOrder] Check Parameters:`, checkParams);

    const [jobs] = await pool.execute(checkQuery, checkParams);

    if (jobs.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'ไม่พบงานนี้หรือคุณไม่มีสิทธิ์รับงานนี้'
      });
    }

    const job = jobs[0];

    // ตรวจสอบว่าได้รับงานแล้วหรือยัง
    if (job.status_receive === 1) {
      return res.status(400).json({
        success: false,
        message: 'คุณได้รับงานนี้แล้ว'
      });
    }

    // อัพเดท status_receive เป็น 1 (รับงานแล้ว)
    const updateQuery = 'UPDATE tb_job_master SET status_receive = 1, updated_by = ?, updated_date = NOW() WHERE job_id = ?';
    const updateParams = [req.user.username || req.user.Id.toString(), jobId];
    
    console.log(`[JobOrder] Update Query: ${updateQuery}`);
    console.log(`[JobOrder] Update Parameters:`, updateParams);

    await pool.execute(updateQuery, updateParams);
    
    console.log(`[JobOrder] Job ${jobId} accepted successfully by driver ${driverId}`);

    res.json({
      success: true,
      message: 'รับงานสำเร็จ'
    });
  } catch (error) {
    console.error('Accept job error:', error);
    res.status(500).json({
      success: false,
      message: 'เกิดข้อผิดพลาดในการรับงาน',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
};

// Check In - อัพเดท actual_in หรือ actual_in2
const checkIn = async (req, res) => {
  try {
    const driverId = req.user.Id;
    const routeId = req.params.routeId;
    const isSecond = req.query.isSecond === 'true'; // ตรวจสอบว่าเป็นการ์ดที่ 2 หรือไม่

    console.log(`[JobOrder] Check In - route_id: ${routeId}, driver_id: ${driverId}, isSecond: ${isSecond}`);

    // ตรวจสอบว่า route นี้อยู่ใน job ที่ driver นี้มีสิทธิ์
    // ให้ทุกคน check in/out ได้ทุก route ใน job ที่เป็น driver
    const fieldName = isSecond ? 'actual_in2' : 'actual_in';
    const checkQuery = `SELECT jr.id, jr.job_id, jr.driver_id, jr.actual_in, jr.actual_in2, jm.job_class
      FROM tb_job_route jr
      INNER JOIN tb_job_master jm ON jr.job_id = jm.job_id
      WHERE jr.id = ? 
        AND jm.driver_id = ?`;
    const checkParams = [routeId, driverId];
    
    console.log(`[JobOrder] Check Query: ${checkQuery}`);
    console.log(`[JobOrder] Check Parameters:`, checkParams);

    const [routes] = await pool.execute(checkQuery, checkParams);

    if (routes.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'ไม่พบ route นี้หรือคุณไม่มีสิทธิ์เข้าถึง'
      });
    }

    const route = routes[0];

    // ตรวจสอบว่ามี actual_in หรือ actual_in2 แล้วหรือยัง
    const currentValue = isSecond ? route.actual_in2 : route.actual_in;
    if (currentValue) {
      return res.status(400).json({
        success: false,
        message: 'คุณได้เช็คอินแล้ว'
      });
    }

    // อัพเดท actual_in หรือ actual_in2
    const updateQuery = `UPDATE tb_job_route SET ${fieldName} = NOW(), updated_by = ?, updated_date = NOW() WHERE id = ?`;
    const updateParams = [req.user.username || req.user.Id.toString(), routeId];
    
    console.log(`[JobOrder] Update Query: ${updateQuery}`);
    console.log(`[JobOrder] Update Parameters:`, updateParams);

    await pool.execute(updateQuery, updateParams);
    
    console.log(`[JobOrder] Route ${routeId} checked in successfully by driver ${driverId} (${fieldName})`);

    res.json({
      success: true,
      message: 'เช็คอินสำเร็จ'
    });
  } catch (error) {
    console.error('Check In error:', error);
    res.status(500).json({
      success: false,
      message: 'เกิดข้อผิดพลาดในการเช็คอิน',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
};

// Check Out - อัพเดท actual_out หรือ actual_out2
const checkOut = async (req, res) => {
  try {
    const driverId = req.user.Id;
    const routeId = req.params.routeId;
    const isSecond = req.query.isSecond === 'true'; // ตรวจสอบว่าเป็นการ์ดที่ 2 หรือไม่

    console.log(`[JobOrder] Check Out - route_id: ${routeId}, driver_id: ${driverId}, isSecond: ${isSecond}`);

    // ตรวจสอบว่า route นี้อยู่ใน job ที่ driver นี้มีสิทธิ์
    // ให้ทุกคน check in/out ได้ทุก route ใน job ที่เป็น driver
    const fieldName = isSecond ? 'actual_out2' : 'actual_out';
    const inFieldName = isSecond ? 'actual_in2' : 'actual_in';
    const checkQuery = `SELECT jr.id, jr.job_id, jr.driver_id, jr.actual_in, jr.actual_in2, jr.actual_out, jr.actual_out2, jm.job_class
      FROM tb_job_route jr
      INNER JOIN tb_job_master jm ON jr.job_id = jm.job_id
      WHERE jr.id = ? 
        AND jm.driver_id = ?`;
    const checkParams = [routeId, driverId];
    
    console.log(`[JobOrder] Check Query: ${checkQuery}`);
    console.log(`[JobOrder] Check Parameters:`, checkParams);

    const [routes] = await pool.execute(checkQuery, checkParams);

    if (routes.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'ไม่พบ route นี้หรือคุณไม่มีสิทธิ์เข้าถึง'
      });
    }

    const route = routes[0];

    // ตรวจสอบว่ามี actual_in หรือ actual_in2 แล้วหรือยัง
    const currentInValue = isSecond ? route.actual_in2 : route.actual_in;
    if (!currentInValue) {
      return res.status(400).json({
        success: false,
        message: 'กรุณาเช็คอินก่อน'
      });
    }

    // ตรวจสอบว่ามี actual_out หรือ actual_out2 แล้วหรือยัง
    const currentOutValue = isSecond ? route.actual_out2 : route.actual_out;
    if (currentOutValue) {
      return res.status(400).json({
        success: false,
        message: 'คุณได้เช็คเอาท์แล้ว'
      });
    }

    // อัพเดท actual_out หรือ actual_out2
    const updateQuery = `UPDATE tb_job_route SET ${fieldName} = NOW(), updated_by = ?, updated_date = NOW() WHERE id = ?`;
    const updateParams = [req.user.username || req.user.Id.toString(), routeId];
    
    console.log(`[JobOrder] Update Query: ${updateQuery}`);
    console.log(`[JobOrder] Update Parameters:`, updateParams);

    await pool.execute(updateQuery, updateParams);
    
    console.log(`[JobOrder] Route ${routeId} checked out successfully by driver ${driverId} (${fieldName})`);

    res.json({
      success: true,
      message: 'เช็คเอาท์สำเร็จ'
    });
  } catch (error) {
    console.error('Check Out error:', error);
    res.status(500).json({
      success: false,
      message: 'เกิดข้อผิดพลาดในการเช็คเอาท์',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
};

module.exports = {
  getJobOrders,
  acceptJob,
  checkIn,
  checkOut
};

