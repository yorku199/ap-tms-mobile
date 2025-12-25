const pool = require('../config/database');

// ฟังก์ชันแปลง datetime จาก UTC เป็น UTC+7 (Thailand timezone)
// หมายเหตุ: ข้อมูลจาก MySQL เป็น Date object ที่มี timezone เป็น GMT+0700 อยู่แล้ว
// แต่เมื่อเรียก toISOString() มันจะแปลงเป็น UTC โดยอัตโนมัติ (ลบ 7 ชั่วโมง)
// ดังนั้นเราต้องเพิ่ม 7 ชั่วโมงกลับเข้าไปเพื่อให้ได้เวลา Thailand time
const convertToThailandTime = (date) => {
  if (!date) return null;
  
  let dateObj;
  
  // ถ้าเป็น Date object จาก MySQL
  if (date instanceof Date) {
    dateObj = date;
  } 
  // ถ้าเป็น string ให้แปลงเป็น Date object ก่อน
  else if (typeof date === 'string') {
    dateObj = new Date(date);
  } else {
    return null;
  }
  
  if (!(dateObj instanceof Date) || isNaN(dateObj.getTime())) return null;
  
  // ข้อมูลจาก MySQL เป็น Date object ที่มี timezone เป็น GMT+0700 อยู่แล้ว
  // แต่เมื่อเรียก toISOString() มันจะแปลงเป็น UTC โดยอัตโนมัติ (ลบ 7 ชั่วโมง)
  // ดังนั้นเราต้องเพิ่ม 7 ชั่วโมงกลับเข้าไปเพื่อให้ได้เวลา Thailand time
  // แต่ถ้าเป็น UTC string ที่ส่งมา (มี Z) เราก็ต้องเพิ่ม 7 ชั่วโมงเหมือนกัน
  const thailandTime = new Date(dateObj.getTime() + (7 * 60 * 60 * 1000));
  return thailandTime.toISOString();
};

// ฟังก์ชันคำนวณสถานะเข้างาน
const calculateCheckInStatus = (actualIn, planIn, actualIn2, planIn2) => {
  // ตรวจสอบ actual_in
  if (actualIn && planIn) {
    const actualInDate = new Date(actualIn);
    const planInDate = new Date(planIn);
    const diffMinutes = Math.floor((actualInDate - planInDate) / (1000 * 60));

    console.log(`[Status] Check-in calculation - actualIn: ${actualIn}, planIn: ${planIn}, diffMinutes: ${diffMinutes}`);

    if (diffMinutes < -10) {
      console.log(`[Status] Result: เข้าก่อนเวลา`);
      return 'เข้าก่อนเวลา';
    } else if (diffMinutes >= -10 && diffMinutes <= 10) {
      console.log(`[Status] Result: เข้าตามเวลา`);
      return 'เข้าตามเวลา';
    } else {
      // diffMinutes > 10 (มาช้า) - แสดง "เข้าสาย"
      console.log(`[Status] Result: เข้าสาย (late: ${diffMinutes} minutes)`);
      return 'เข้าสาย';
    }
  }

  // ตรวจสอบ actual_in2
  if (actualIn2 && planIn2) {
    const actualIn2Date = new Date(actualIn2);
    const planIn2Date = new Date(planIn2);
    const diffMinutes = Math.floor((actualIn2Date - planIn2Date) / (1000 * 60));

    console.log(`[Status] Check-in2 calculation - actualIn2: ${actualIn2}, planIn2: ${planIn2}, diffMinutes: ${diffMinutes}`);

    if (diffMinutes < -10) {
      console.log(`[Status] Result: เข้าก่อนเวลา`);
      return 'เข้าก่อนเวลา';
    } else if (diffMinutes >= -10 && diffMinutes <= 10) {
      console.log(`[Status] Result: เข้าตามเวลา`);
      return 'เข้าตามเวลา';
    } else {
      // diffMinutes > 10 (มาช้า) - แสดง "เข้าสาย"
      console.log(`[Status] Result: เข้าสาย (late: ${diffMinutes} minutes)`);
      return 'เข้าสาย';
    }
  }

  return null;
};

// ฟังก์ชันคำนวณสถานะออกงาน
const calculateCheckOutStatus = (actualOut, planOut, actualOut2, planOut2) => {
  // ตรวจสอบ actual_out
  if (actualOut && planOut) {
    const actualOutDate = new Date(actualOut);
    const planOutDate = new Date(planOut);
    const diffMinutes = Math.floor((actualOutDate - planOutDate) / (1000 * 60));

    console.log(`[Status] Check-out calculation - actualOut: ${actualOut}, planOut: ${planOut}, diffMinutes: ${diffMinutes}`);

    if (diffMinutes < -10) {
      console.log(`[Status] Result: ออกก่อนเวลา`);
      return 'ออกก่อนเวลา';
    } else if (diffMinutes >= -10 && diffMinutes <= 10) {
      console.log(`[Status] Result: ออกตามเวลา`);
      return 'ออกตามเวลา';
    } else {
      // diffMinutes > 10 (ออกช้า) - แสดง "ออกก่อนเวลา" ตามที่ผู้ใช้ต้องการ
      console.log(`[Status] Result: ออกก่อนเวลา (late: ${diffMinutes} minutes)`);
      return 'ออกก่อนเวลา';
    }
  }

  // ตรวจสอบ actual_out2
  if (actualOut2 && planOut2) {
    const actualOut2Date = new Date(actualOut2);
    const planOut2Date = new Date(planOut2);
    const diffMinutes = Math.floor((actualOut2Date - planOut2Date) / (1000 * 60));

    console.log(`[Status] Check-out2 calculation - actualOut2: ${actualOut2}, planOut2: ${planOut2}, diffMinutes: ${diffMinutes}`);

    if (diffMinutes < -10) {
      console.log(`[Status] Result: ออกก่อนเวลา`);
      return 'ออกก่อนเวลา';
    } else if (diffMinutes >= -10 && diffMinutes <= 10) {
      console.log(`[Status] Result: ออกตามเวลา`);
      return 'ออกตามเวลา';
    } else {
      // diffMinutes > 10 (ออกช้า) - แสดง "ออกก่อนเวลา" ตามที่ผู้ใช้ต้องการ
      console.log(`[Status] Result: ออกก่อนเวลา (late: ${diffMinutes} minutes)`);
      return 'ออกก่อนเวลา';
    }
  }

  return null;
};

// ดึง job orders ของ driver ณ วันนั้น
const getJobOrders = async (req, res) => {
  try {
    const driverId = req.user.Id;
    
    // ตรวจสอบว่ามี query parameter date หรือไม่
    let targetDate;
    let useExactDate = false;
    
    if (req.query.date) {
      // ใช้วันที่ที่ส่งมาจาก client
      const dateStr = req.query.date; // format: YYYY-MM-DD
      const [year, month, day] = dateStr.split('-').map(Number);
      targetDate = new Date(year, month - 1, day);
      targetDate.setHours(0, 0, 0, 0);
      useExactDate = true; // ใช้เฉพาะวันที่ที่ส่งมา ไม่ต้อง ±1 วัน
      console.log(`[JobOrder] Using provided date: ${dateStr}`);
    } else {
      // ดึงวันที่ปัจจุบันใน timezone ประเทศไทย (UTC+7)
      const now = new Date();
      const thailandOffset = 7 * 60; // UTC+7 ในหน่วยนาที
      const utcTime = now.getTime() + (now.getTimezoneOffset() * 60000);
      const thailandTime = new Date(utcTime + (thailandOffset * 60000));
      
      // ตั้งเวลาเป็น 00:00:00 ของวันนี้ใน timezone ประเทศไทย
      targetDate = new Date(thailandTime);
      targetDate.setHours(0, 0, 0, 0);
      useExactDate = false; // ใช้ ±1 วันสำหรับวันที่ปัจจุบัน
      console.log(`[JobOrder] Using current date (Thailand timezone)`);
    }
    
    // คำนวณวันที่เริ่มต้นและสิ้นสุด
    let startDate, endDate;
    if (useExactDate) {
      // ใช้เฉพาะวันที่ที่ส่งมา (ไม่ต้อง ±1 วัน)
      startDate = new Date(targetDate);
      endDate = new Date(targetDate);
    } else {
      // คำนวณวันที่เริ่มต้น (วันนี้ - 1 วัน) และวันที่สิ้นสุด (วันนี้ + 1 วัน)
      startDate = new Date(targetDate);
      startDate.setDate(targetDate.getDate() - 1);
      endDate = new Date(targetDate);
      endDate.setDate(targetDate.getDate() + 1);
    }
    
    // แปลงเป็น string format YYYY-MM-DD
    const formatDate = (date) => {
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, '0');
      const day = String(date.getDate()).padStart(2, '0');
      return `${year}-${month}-${day}`;
    };
    
    const startDateStr = formatDate(startDate);
    const endDateStr = formatDate(endDate);
    const targetDateStr = formatDate(targetDate);

    console.log(`[JobOrder] Target date: ${targetDateStr}`);
    if (useExactDate) {
      console.log(`[JobOrder] Fetching job orders for driver_id: ${driverId}, exact date: ${targetDateStr}`);
    } else {
      console.log(`[JobOrder] Fetching job orders for driver_id: ${driverId}, date range: ${startDateStr} to ${endDateStr}`);
    }

    // ดึง job orders ของ driver
    // ถ้า job_class = 0 ให้ค้นหาที่ tb_job_master.driver_id
    // ถ้า job_class = 1 ให้ค้นหาที่ tb_job_route.driver_id
    // กรองวันที่จาก tb_job_route.plan_in และ plan_in2
    let queryString, queryParams;
    
    if (useExactDate) {
      // ใช้ = เมื่อเป็นวันที่เดียวกัน (แม่นยำกว่า)
      queryString = `SELECT DISTINCT
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
          (jr.plan_in IS NOT NULL AND DATE(jr.plan_in) = ?) OR
          (jr.plan_in2 IS NOT NULL AND DATE(jr.plan_in2) = ?)
        )
        AND jm.status != 0
      ORDER BY COALESCE(jr.plan_in, jr.plan_in2) DESC, jm.job_id DESC`;
      
      queryParams = [driverId, driverId, targetDateStr, targetDateStr];
    } else {
      // ใช้ BETWEEN เมื่อเป็นช่วงวันที่
      queryString = `SELECT DISTINCT
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
      
      queryParams = [driverId, driverId, startDateStr, endDateStr, startDateStr, endDateStr];
    }
    
    console.log(`[JobOrder] Query: ${queryString}`);
    console.log(`[JobOrder] Parameters:`, queryParams);

    const [jobs] = await pool.execute(queryString, queryParams);

    console.log(`[JobOrder] Found ${jobs.length} job(s) for driver_id: ${driverId}`);
    if (jobs.length > 0) {
      console.log(`[JobOrder] First job sample:`, JSON.stringify(jobs[0], null, 2));
    } else {
      console.log(`[JobOrder] No jobs found. Checking if there are any jobs for this driver...`);
      // Debug query: ตรวจสอบว่ามี jobs สำหรับ driver นี้หรือไม่
      const [debugJobs] = await pool.execute(
        `SELECT COUNT(*) as count FROM tb_job_master WHERE driver_id = ? AND status != 0`,
        [driverId]
      );
      console.log(`[JobOrder] Total jobs for driver ${driverId}: ${debugJobs[0]?.count || 0}`);
      
      // Debug query: ตรวจสอบว่ามี routes ในวันที่ที่เลือกหรือไม่
      const [debugRoutes] = await pool.execute(
        `SELECT COUNT(*) as count FROM tb_job_route jr
         INNER JOIN tb_job_master jm ON jr.job_id = jm.job_id
         WHERE (
           (jm.job_class = 0 AND jm.driver_id = ?) OR
           (jm.job_class = 1 AND jr.driver_id = ?)
         )
         AND (
           (jr.plan_in IS NOT NULL AND DATE(jr.plan_in) = ?) OR
           (jr.plan_in2 IS NOT NULL AND DATE(jr.plan_in2) = ?)
         )
         AND jm.status != 0`,
        [driverId, driverId, targetDateStr, targetDateStr]
      );
      console.log(`[JobOrder] Routes matching date ${targetDateStr}: ${debugRoutes[0]?.count || 0}`);
    }

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

        // แปลง datetime fields จาก UTC เป็น UTC+7 สำหรับทุก route และคำนวณสถานะ
        const routesWithThailandTime = routes.map(route => {
          // สำหรับการคำนวณสถานะ ใช้ค่า UTC โดยตรง (ไม่แปลงเป็น Thailand time)
          // เพราะการคำนวณ diffMinutes ต้องใช้ timezone เดียวกัน
          const planInUTC = route.plan_in ? (route.plan_in instanceof Date ? route.plan_in.toISOString() : new Date(route.plan_in).toISOString()) : null;
          const planOutUTC = route.plan_out ? (route.plan_out instanceof Date ? route.plan_out.toISOString() : new Date(route.plan_out).toISOString()) : null;
          const planIn2UTC = route.plan_in2 ? (route.plan_in2 instanceof Date ? route.plan_in2.toISOString() : new Date(route.plan_in2).toISOString()) : null;
          const planOut2UTC = route.plan_out2 ? (route.plan_out2 instanceof Date ? route.plan_out2.toISOString() : new Date(route.plan_out2).toISOString()) : null;
          const actualInUTC = route.actual_in ? (route.actual_in instanceof Date ? route.actual_in.toISOString() : new Date(route.actual_in).toISOString()) : null;
          const actualOutUTC = route.actual_out ? (route.actual_out instanceof Date ? route.actual_out.toISOString() : new Date(route.actual_out).toISOString()) : null;
          const actualIn2UTC = route.actual_in2 ? (route.actual_in2 instanceof Date ? route.actual_in2.toISOString() : new Date(route.actual_in2).toISOString()) : null;
          const actualOut2UTC = route.actual_out2 ? (route.actual_out2 instanceof Date ? route.actual_out2.toISOString() : new Date(route.actual_out2).toISOString()) : null;

          // แปลงเป็น Thailand time สำหรับแสดงผล
          const planIn = convertToThailandTime(route.plan_in);
          const planOut = convertToThailandTime(route.plan_out);
          const planIn2 = convertToThailandTime(route.plan_in2);
          const planOut2 = convertToThailandTime(route.plan_out2);
          const actualIn = convertToThailandTime(route.actual_in);
          const actualOut = convertToThailandTime(route.actual_out);
          const actualIn2 = convertToThailandTime(route.actual_in2);
          const actualOut2 = convertToThailandTime(route.actual_out2);

          console.log(`[Status] Route ${route.id} - Converting times:`);
          console.log(`[Status]   plan_in: ${route.plan_in} -> ${planIn} (UTC: ${planInUTC})`);
          console.log(`[Status]   actual_in: ${route.actual_in} -> ${actualIn} (UTC: ${actualInUTC})`);
          console.log(`[Status]   plan_out: ${route.plan_out} -> ${planOut} (UTC: ${planOutUTC})`);
          console.log(`[Status]   actual_out: ${route.actual_out} -> ${actualOut} (UTC: ${actualOutUTC})`);

          // คำนวณสถานะโดยใช้ค่า UTC (เพื่อความถูกต้อง)
          console.log(`[Status] Route ${route.id} - Calculating status...`);
          const checkInStatus = calculateCheckInStatus(actualInUTC, planInUTC, actualIn2UTC, planIn2UTC);
          const checkOutStatus = calculateCheckOutStatus(actualOutUTC, planOutUTC, actualOut2UTC, planOut2UTC);
          console.log(`[Status] Route ${route.id} - Result: checkInStatus=${checkInStatus}, checkOutStatus=${checkOutStatus}`);

          return {
            ...route,
            plan_in: planIn,
            plan_out: planOut,
            plan_in2: planIn2,
            plan_out2: planOut2,
            actual_in: actualIn,
            actual_out: actualOut,
            actual_in2: actualIn2,
            actual_out2: actualOut2,
            check_in_status: checkInStatus,
            check_out_status: checkOutStatus,
          };
        });

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

