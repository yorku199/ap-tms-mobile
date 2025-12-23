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

// ฟังก์ชันคำนวณระยะทางระหว่าง 2 จุด (Haversine formula)
// คืนค่าเป็นเมตร
function calculateDistance(lat1, lon1, lat2, lon2) {
  const R = 6371000; // รัศมีโลกในหน่วยเมตร
  const dLat = toRad(lat2 - lat1);
  const dLon = toRad(lon2 - lon1);
  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(toRad(lat1)) *
      Math.cos(toRad(lat2)) *
      Math.sin(dLon / 2) *
      Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  const distance = R * c;
  return distance;
}

function toRad(degrees) {
  return (degrees * Math.PI) / 180;
}

// เช็คอิน
const checkIn = async (req, res) => {
  try {
    const userId = req.user.Id;
    const { yard_id, user_lat, user_long, yard_lat, yard_long, distance, is_within_radius } = req.body;

    // ตรวจสอบข้อมูลที่จำเป็น
    if (!yard_id || user_lat === undefined || user_long === undefined) {
      return res.status(400).json({
        success: false,
        message: 'กรุณากรอกข้อมูลให้ครบถ้วน',
      });
    }

    // ตรวจสอบว่ามี check in วันนี้หรือไม่ (เช็คเฉพาะ type = 'check_in')
    const [existingCheckIn] = await pool.execute(
      `SELECT id FROM tb_check_in 
       WHERE user_id = ? 
       AND DATE(check_in_time) = DATE(NOW())
       AND type = 'check_in'
       ORDER BY check_in_time DESC 
       LIMIT 1`,
      [userId]
    );

    if (existingCheckIn.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'คุณได้เช็คอินวันนี้แล้ว กรุณาเช็คเอาท์ก่อนเช็คอินใหม่',
      });
    }

    // ดึงข้อมูล in_time และ out_time ของ user
    const [users] = await pool.execute(
      'SELECT in_time, out_time FROM tb_user WHERE Id = ?',
      [userId]
    );

    const userInTime = users.length > 0 ? users[0].in_time : null;
    const userOutTime = users.length > 0 ? users[0].out_time : null;
    const currentTime = new Date();
    
    // คำนวณว่ามาสายหรือไม่ (ถ้ามี in_time)
    let isLate = false;
    let lateMinutes = 0;
    if (userInTime) {
      // แปลง in_time เป็น Date object สำหรับวันนี้
      const inTimeStr = userInTime.toString().substring(0, 8); // HH:MM:SS
      const [inHours, inMinutes, inSeconds] = inTimeStr.split(':').map(Number);
      
      const todayInTime = new Date();
      todayInTime.setHours(inHours, inMinutes, inSeconds || 0, 0);
      
      // เปรียบเทียบเวลาปัจจุบันกับเวลาที่กำหนด
      if (currentTime > todayInTime) {
        isLate = true;
        // คำนวณนาทีที่มาสาย
        lateMinutes = Math.floor((currentTime - todayInTime) / (1000 * 60));
      }
    }

    // ดึงข้อมูล yard
    const [yards] = await pool.execute(
      'SELECT lat, `long`, radius FROM tb_user_yard WHERE id = ?',
      [yard_id]
    );

    if (yards.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'ไม่พบสถานที่บริษัทที่ระบุ',
      });
    }

    const yard = yards[0];
    const finalYardLat = yard_lat !== undefined ? parseFloat(yard_lat) : (yard.lat ? parseFloat(yard.lat) : null);
    const finalYardLong = yard_long !== undefined ? parseFloat(yard_long) : (yard.long ? parseFloat(yard.long) : null);
    
    // คำนวณระยะทางถ้ายังไม่มี
    let finalDistance = distance !== undefined ? parseFloat(distance) : null;
    if (finalDistance === null && finalYardLat !== null && finalYardLong !== null) {
      finalDistance = calculateDistance(
        parseFloat(user_lat),
        parseFloat(user_long),
        finalYardLat,
        finalYardLong
      );
    }

    // ตรวจสอบว่าอยู่ในรัศมีหรือไม่
    if (yard.radius !== null && finalDistance !== null) {
      if (finalDistance > yard.radius) {
        return res.status(400).json({
          success: false,
          message: `คุณอยู่นอกรัศมีที่กำหนด (${finalDistance.toFixed(2)} เมตร) กรุณาเข้าใกล้สถานที่บริษัทก่อนเช็คอิน`,
          data: {
            distance: finalDistance,
            radius: yard.radius,
          },
        });
      }
    }

    // บันทึกข้อมูล check in (ทุก record ที่บันทึกได้จะอยู่ในรัศมีอยู่แล้ว)
    // บันทึก in_time และ out_time ของ user ณ เวลาที่เช็คอินเพื่อป้องกันปัญหาการคำนวณผิดในอนาคต
    const [result] = await pool.execute(
      `INSERT INTO tb_check_in 
       (user_id, yard_id, check_in_time, type, in_time, out_time, user_lat, user_long, yard_lat, yard_long, distance, created_by, created_date)
       VALUES (?, ?, NOW(), 'check_in', ?, ?, ?, ?, ?, ?, ?, ?, NOW())`,
      [
        userId,
        yard_id,
        userInTime, // บันทึก in_time ของ user ณ เวลาที่เช็คอิน
        userOutTime, // บันทึก out_time ของ user ณ เวลาที่เช็คอิน
        user_lat,
        user_long,
        finalYardLat,
        finalYardLong,
        finalDistance,
        req.user.username || userId.toString(),
      ]
    );

    res.json({
      success: true,
      message: isLate 
        ? `เช็คอินสำเร็จ (มาสาย ${lateMinutes} นาที)` 
        : 'เช็คอินสำเร็จ',
      data: {
        check_in_id: result.insertId,
        distance: finalDistance,
        is_late: isLate,
        late_minutes: lateMinutes,
        check_in_time: convertToThailandTime(currentTime),
        expected_in_time: userInTime ? userInTime.toString() : null,
      },
    });
  } catch (error) {
    console.error('Check in error:', error);
    res.status(500).json({
      success: false,
      message: 'เกิดข้อผิดพลาดในการเช็คอิน',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined,
    });
  }
};

// เช็คเอาท์
const checkOut = async (req, res) => {
  try {
    const userId = req.user.Id;
    const { user_lat, user_long } = req.body;

    // ตรวจสอบข้อมูลที่จำเป็น
    if (user_lat === undefined || user_long === undefined) {
      return res.status(400).json({
        success: false,
        message: 'กรุณากรอกข้อมูลให้ครบถ้วน',
      });
    }

    // ตรวจสอบว่ามี check in วันนี้หรือไม่ (ต้องมี check in ก่อนเช็คเอาท์)
    const [checkIns] = await pool.execute(
      `SELECT id, yard_id, yard_lat, yard_long FROM tb_check_in 
       WHERE user_id = ? 
       AND DATE(check_in_time) = DATE(NOW()) 
       AND type = 'check_in'
       ORDER BY check_in_time DESC 
       LIMIT 1`,
      [userId]
    );

    if (checkIns.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'ไม่พบข้อมูล check in ของวันนี้ กรุณาเช็คอินก่อน',
      });
    }

    const checkInId = checkIns[0].id;
    const yardId = checkIns[0].yard_id;
    const yardLat = checkIns[0].yard_lat;
    const yardLong = checkIns[0].yard_long;

    // ดึงข้อมูล yard เพื่อตรวจสอบ radius
    const [yards] = await pool.execute(
      'SELECT radius FROM tb_user_yard WHERE id = ?',
      [yardId]
    );

    if (yards.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'ไม่พบสถานที่บริษัทที่ระบุ',
      });
    }

    const yard = yards[0];

    // คำนวณระยะทาง
    let finalDistance = null;
    if (yardLat !== null && yardLong !== null) {
      finalDistance = calculateDistance(
        parseFloat(user_lat),
        parseFloat(user_long),
        parseFloat(yardLat),
        parseFloat(yardLong)
      );
    }

    // ตรวจสอบว่าอยู่ในรัศมีหรือไม่
    if (yard.radius !== null && finalDistance !== null) {
      if (finalDistance > yard.radius) {
        return res.status(400).json({
          success: false,
          message: `คุณอยู่นอกรัศมีที่กำหนด (${finalDistance.toFixed(2)} เมตร) กรุณาเข้าใกล้สถานที่บริษัทก่อนเช็คเอาท์`,
          data: {
            distance: finalDistance,
            radius: yard.radius,
          },
        });
      }
    }

    // ดึงข้อมูล in_time และ out_time ของ user
    const [users] = await pool.execute(
      'SELECT in_time, out_time FROM tb_user WHERE Id = ?',
      [userId]
    );

    const userInTime = users.length > 0 ? users[0].in_time : null;
    const userOutTime = users.length > 0 ? users[0].out_time : null;

    // สร้างแถวใหม่สำหรับ check out (แทนการอัพเดท check_out_time)
    // บันทึก in_time และ out_time ของ user ณ เวลาที่เช็คเอาท์เพื่อป้องกันปัญหาการคำนวณผิดในอนาคต
    const [result] = await pool.execute(
      `INSERT INTO tb_check_in 
       (user_id, yard_id, check_in_time, type, in_time, out_time, user_lat, user_long, yard_lat, yard_long, distance, created_by, created_date)
       VALUES (?, ?, NOW(), 'check_out', ?, ?, ?, ?, ?, ?, ?, ?, NOW())`,
      [
        userId,
        yardId,
        userInTime, // บันทึก in_time ของ user ณ เวลาที่เช็คเอาท์
        userOutTime, // บันทึก out_time ของ user ณ เวลาที่เช็คเอาท์
        user_lat,
        user_long,
        yardLat,
        yardLong,
        finalDistance,
        req.user.username || userId.toString(),
      ]
    );
    const currentTime = new Date();

    // คำนวณว่าออกก่อนเวลาหรือไม่ (ถ้ามี out_time)
    let isEarly = false;
    let earlyMinutes = 0;
    if (userOutTime) {
      // แปลง out_time เป็น Date object สำหรับวันนี้
      const outTimeStr = userOutTime.toString().substring(0, 8); // HH:MM:SS
      const [outHours, outMinutes, outSeconds] = outTimeStr.split(':').map(Number);
      
      const todayOutTime = new Date();
      todayOutTime.setHours(outHours, outMinutes, outSeconds || 0, 0);
      
      // เปรียบเทียบเวลาปัจจุบันกับเวลาที่กำหนด
      if (currentTime < todayOutTime) {
        isEarly = true;
        // คำนวณนาทีที่ออกก่อนเวลา
        earlyMinutes = Math.floor((todayOutTime - currentTime) / (1000 * 60));
      }
    }

    res.json({
      success: true,
      message: isEarly 
        ? `เช็คเอาท์สำเร็จ (ออกก่อนเวลา ${earlyMinutes} นาที)` 
        : 'เช็คเอาท์สำเร็จ',
      data: {
        check_out_id: result.insertId,
        check_in_id: checkInId,
        is_early: isEarly,
        early_minutes: earlyMinutes,
        check_out_time: convertToThailandTime(currentTime),
        expected_out_time: userOutTime ? userOutTime.toString() : null,
        distance: finalDistance,
      },
    });
  } catch (error) {
    console.error('Check out error:', error);
    res.status(500).json({
      success: false,
      message: 'เกิดข้อผิดพลาดในการเช็คเอาท์',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined,
    });
  }
};

// ดึงข้อมูล check in ล่าสุด
const getLatestCheckIn = async (req, res) => {
  try {
    const userId = req.user.Id;

    // ดึงข้อมูล check in ล่าสุด (type = 'check_in')
    const [checkIns] = await pool.execute(
      `SELECT id, user_id, yard_id, check_in_time, type, in_time, out_time,
              user_lat, user_long, yard_lat, yard_long, distance
       FROM tb_check_in 
       WHERE user_id = ? AND type = 'check_in'
       ORDER BY check_in_time DESC 
       LIMIT 1`,
      [userId]
    );

    if (checkIns.length === 0) {
      return res.json({
        success: true,
        message: 'ไม่พบข้อมูล check in',
        data: {
          check_in: null,
        },
      });
    }

    const checkIn = checkIns[0];
    
    // ดึงข้อมูล check out ล่าสุดของวันเดียวกัน (ถ้ามี)
    // หาวันที่ของ check in
    const checkInDate = new Date(checkIn.check_in_time);
    const checkInDateStart = new Date(checkInDate.getFullYear(), checkInDate.getMonth(), checkInDate.getDate());
    const checkInDateEnd = new Date(checkInDateStart);
    checkInDateEnd.setDate(checkInDateEnd.getDate() + 1);

    const [checkOuts] = await pool.execute(
      `SELECT id, check_in_time as check_out_time
       FROM tb_check_in 
       WHERE user_id = ? 
         AND yard_id = ?
         AND type = 'check_out'
         AND check_in_time >= ? 
         AND check_in_time < ?
       ORDER BY check_in_time DESC 
       LIMIT 1`,
      [userId, checkIn.yard_id, checkInDateStart, checkInDateEnd]
    );

    let checkOutTime = null;
    let checkOutInTime = null;
    let checkOutOutTime = null;
    if (checkOuts.length > 0) {
      checkOutTime = checkOuts[0].check_out_time;
      // ดึงข้อมูล in_time และ out_time จาก check out record
      const [checkOutDetails] = await pool.execute(
        `SELECT in_time, out_time FROM tb_check_in WHERE id = ?`,
        [checkOuts[0].id]
      );
      if (checkOutDetails.length > 0) {
        checkOutInTime = checkOutDetails[0].in_time;
        checkOutOutTime = checkOutDetails[0].out_time;
      }
    }

    res.json({
      success: true,
      message: 'ดึงข้อมูล check in สำเร็จ',
      data: {
        check_in: {
          id: checkIn.id,
          user_id: checkIn.user_id,
          yard_id: checkIn.yard_id,
          check_in_time: convertToThailandTime(checkIn.check_in_time),
          check_out_time: convertToThailandTime(checkOutTime),
          in_time: checkIn.in_time ? checkIn.in_time.toString() : null, // in_time จาก check_in record
          out_time: checkOutOutTime ? checkOutOutTime.toString() : null, // out_time จาก check_out record
          user_lat: checkIn.user_lat ? parseFloat(checkIn.user_lat) : null,
          user_long: checkIn.user_long ? parseFloat(checkIn.user_long) : null,
          yard_lat: checkIn.yard_lat ? parseFloat(checkIn.yard_lat) : null,
          yard_long: checkIn.yard_long ? parseFloat(checkIn.yard_long) : null,
          distance: checkIn.distance ? parseFloat(checkIn.distance) : null,
        },
      },
    });
  } catch (error) {
    console.error('Get latest check in error:', error);
    res.status(500).json({
      success: false,
      message: 'เกิดข้อผิดพลาดในการดึงข้อมูล check in',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined,
    });
  }
};

module.exports = {
  checkIn,
  checkOut,
  getLatestCheckIn,
  calculateDistance,
};

