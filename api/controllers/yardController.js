const pool = require('../config/database');

// ดึงข้อมูล yard ทั้งหมดที่มีข้อมูลครบถ้วน
// ดึง yards ทั้งหมดที่มีข้อมูล title, lat, long, radius ครบถ้วน เพื่อให้ user สามารถเลือกเช็คอินที่บริษัทอื่นได้
const getUserYards = async (req, res) => {
  try {
    // ดึง yards ทั้งหมดที่มีข้อมูล title, lat, long, radius ครบถ้วน
    // เพื่อให้ user สามารถเลือกเช็คอินที่บริษัทอื่นได้
    const [yards] = await pool.execute(
      `SELECT id, name, title, address, lat, \`long\`, radius 
       FROM tb_user_yard 
       WHERE status = 1 
         AND title IS NOT NULL 
         AND title != '' 
         AND lat IS NOT NULL 
         AND \`long\` IS NOT NULL 
         AND radius IS NOT NULL
       ORDER BY name ASC`
    );

    const yardsData = yards.map((yard) => ({
      id: yard.id,
      name: yard.name,
      title: yard.title,
      address: yard.address,
      lat: yard.lat ? parseFloat(yard.lat) : null,
      long: yard.long ? parseFloat(yard.long) : null,
      radius: yard.radius,
    }));

    res.json({
      success: true,
      message: 'ดึงข้อมูล yard สำเร็จ',
      data: {
        yards: yardsData,
      },
    });
  } catch (error) {
    console.error('Get user yards error:', error);
    res.status(500).json({
      success: false,
      message: 'เกิดข้อผิดพลาดในการดึงข้อมูล yard',
      error: process.env.NODE_ENV === 'development' ? error.message : undefined,
    });
  }
};

module.exports = {
  getUserYards,
};

