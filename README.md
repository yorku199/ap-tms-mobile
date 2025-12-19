# TMS App

แอปพลิเคชัน TMS ที่ใช้การยืนยันตัวตนด้วยรหัสบัตรประชาชน

## โครงสร้างโปรเจค

```
tms-app/
├── api/                 # Backend API (Node.js)
│   ├── config/
│   ├── middleware/
│   ├── routes/
│   └── server.js
├── db/                  # ฐานข้อมูล
│   └── tms.sql
├── lib/                 # Flutter App
│   ├── config/
│   ├── models/
│   ├── providers/
│   ├── screens/
│   ├── services/
│   ├── utils/
│   └── main.dart
└── pubspec.yaml
```

## การติดตั้งและรัน

### Backend API

1. เข้าไปที่ folder `api`:
```bash
cd api
```

2. ติดตั้ง dependencies:
```bash
npm install
```

3. สร้างไฟล์ `.env` และตั้งค่า:
```
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=tms
DB_PORT=3306
JWT_SECRET=your-secret-key
JWT_EXPIRES_IN=24h
PORT=3000
```

4. รัน API server:
```bash
npm run dev
```

### Flutter App

1. ติดตั้ง dependencies:
```bash
flutter pub get
```

2. แก้ไข API URL ใน `lib/config/api_config.dart`:
   - Android Emulator: `http://10.0.2.2:3000`
   - iOS Simulator: `http://localhost:3000`
   - Physical Device: `http://<your-ip-address>:3000`

3. รันแอป:
```bash
flutter run
```

## ฟีเจอร์

- ✅ ยืนยันตัวตนด้วยรหัสบัตรประชาชน
- ✅ JWT Authentication
- ✅ หน้าจอแสดงข้อมูลผู้ใช้
- ✅ Logout functionality

## ข้อกำหนด

- Flutter SDK >= 3.0.0
- Node.js >= 14.0.0
- MySQL >= 5.7

