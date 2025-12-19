# TMS API

API สำหรับระบบ TMS ที่ใช้การยืนยันตัวตนด้วยรหัสบัตรประชาชน

## การติดตั้ง

1. ติดตั้ง dependencies:
```bash
npm install
```

2. สร้างไฟล์ `.env` จาก `.env.example`:
```bash
cp .env.example .env
```

3. แก้ไขข้อมูลในไฟล์ `.env`:
```
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=tms
DB_PORT=3306
JWT_SECRET=your-secret-key-change-this-in-production
JWT_EXPIRES_IN=24h
PORT=3000
NODE_ENV=development
BASE_URL=http://localhost:3000
```

**หมายเหตุ:** `BASE_URL` ใช้สำหรับสร้าง full URL ของรูปภาพที่อัพโหลด ถ้าไม่ระบุจะใช้ค่าจาก request อัตโนมัติ

## การรัน

### Development mode (with nodemon):
```bash
npm run dev
```

### Production mode:
```bash
npm start
```

## API Endpoints

### Authentication

#### POST `/api/auth/login`
เข้าสู่ระบบด้วยรหัสบัตรประชาชน

**Request Body:**
```json
{
  "id_card_no": "1234567890123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "เข้าสู่ระบบสำเร็จ",
  "data": {
    "token": "jwt_token_here",
    "user": {
      "id": 1,
      "username": "user001",
      "name": "ชื่อ",
      "lastname": "นามสกุล",
      "id_card_no": "1234567890123",
      "role": 1,
      ...
    }
  }
}
```

#### GET `/api/auth/me`
ดูข้อมูลผู้ใช้ปัจจุบัน (ต้องมี Token)

**Headers:**
```
Authorization: Bearer <token>
```

#### POST `/api/auth/verify`
ตรวจสอบ Token (ต้องมี Token)

**Headers:**
```
Authorization: Bearer <token>
```

#### POST `/api/auth/logout`
ออกจากระบบ (ต้องมี Token)

**Headers:**
```
Authorization: Bearer <token>
```

### User Profile

#### POST `/api/user/upload-profile-image`
อัพโหลดรูป profile (ต้องมี Token)

**Headers:**
```
Authorization: Bearer <token>
Content-Type: multipart/form-data
```

**Request Body:**
- `profile_image`: ไฟล์รูปภาพ (jpeg, jpg, png, gif, webp)
- ขนาดไฟล์สูงสุด: 5MB

**Response:**
```json
{
  "success": true,
  "message": "อัพโหลดรูป profile สำเร็จ",
  "data": {
    "profile_image_url": "http://localhost:3000/uploads/profile_images/user_1_1234567890.jpg"
  }
}
```

**หมายเหตุ:** ระบบจะเก็บ full URL (path เต็ม) ในฐานข้อมูล

### Health Check

#### GET `/health`
ตรวจสอบสถานะ API

## การใช้งาน Token

หลังจาก login สำเร็จ จะได้รับ JWT Token กลับมา ต้องส่ง Token นี้ใน Header ทุกครั้งที่เรียก API ที่ต้องการ authentication:

```
Authorization: Bearer <your_token_here>
```

## ข้อกำหนด

- Node.js >= 14.0.0
- MySQL >= 5.7
- รหัสบัตรประชาชนต้องเป็นตัวเลข 13 หลัก

