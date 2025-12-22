# วิธีตั้งค่า Location บน Android Emulator

## ปัญหาที่พบบ่อย
เมื่อรันแอปบน Android Emulator และไม่สามารถดึง location ได้

## วิธีแก้ไข

### 1. ตั้งค่า Location ใน Emulator

#### วิธีที่ 1: ใช้ Extended Controls (แนะนำ)
1. เปิด Android Emulator
2. คลิกที่ปุ่ม **...** (สามจุด) ที่ด้านข้าง emulator หรือกด `Ctrl + Shift + A` (Windows/Linux) หรือ `Cmd + Option + A` (Mac)
3. ไปที่แท็บ **Location**
4. ตั้งค่า Latitude และ Longitude:
   - **Latitude**: 13.7563 (ตัวอย่าง: กรุงเทพฯ)
   - **Longitude**: 100.5018 (ตัวอย่าง: กรุงเทพฯ)
5. คลิก **Send** เพื่อส่งตำแหน่งไปยัง emulator

#### วิธีที่ 2: ใช้ ADB Command
```bash
# ตั้งค่า location (ตัวอย่าง: กรุงเทพฯ)
adb emu geo fix 100.5018 13.7563

# หรือตั้งค่า location อื่นๆ
adb emu geo fix <longitude> <latitude>
```

### 2. เปิด Location Service ใน Emulator
1. เปิด **Settings** ใน emulator
2. ไปที่ **Location** หรือ **ตำแหน่ง**
3. เปิดสวิตช์ **Location** หรือ **Use location**

### 3. อนุญาต Location Permission ในแอป
1. เมื่อแอปขอ permission ให้คลิก **Allow** หรือ **อนุญาต**
2. หรือไปที่ **Settings** > **Apps** > **tms_app** > **Permissions** > **Location** > เลือก **Allow all the time** หรือ **While using the app**

### 4. ตรวจสอบว่า Emulator รองรับ Location
- ใช้ Android Emulator เวอร์ชันล่าสุด
- ตรวจสอบว่า emulator มี Google Play Services (สำหรับ location services)

## ตัวอย่าง Location Coordinates

### กรุงเทพฯ
- Latitude: 13.7563
- Longitude: 100.5018

### เชียงใหม่
- Latitude: 18.7883
- Longitude: 98.9853

### ภูเก็ต
- Latitude: 7.8804
- Longitude: 98.3923

## การทดสอบ
หลังจากตั้งค่าแล้ว:
1. รีสตาร์ทแอป
2. ไปที่หน้า Check In
3. ระบบควรดึง location ได้ทันที

## Troubleshooting

### ถ้ายังไม่สามารถดึง location ได้:
1. **รีสตาร์ท Emulator**: ปิดและเปิด emulator ใหม่
2. **ตรวจสอบ Permission**: ไปที่ Settings > Apps > tms_app > Permissions
3. **ตรวจสอบ Location Service**: เปิด Settings > Location
4. **ใช้ Physical Device**: ลองทดสอบบนเครื่องจริงแทน emulator
5. **ตรวจสอบ Log**: ดู error ใน Android Studio Logcat

### Error Messages ที่อาจพบ:
- "กรุณาเปิดใช้งาน Location Service" → เปิด Location Service ใน Settings
- "กรุณาอนุญาตให้เข้าถึงตำแหน่ง" → อนุญาต permission ในแอป
- "ไม่สามารถดึงตำแหน่งได้" → ตรวจสอบว่า emulator มี location ที่ตั้งค่าไว้

