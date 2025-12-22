# แก้ไขปัญหา Google Maps ไม่แสดง (จอดำ)

## สาเหตุที่เป็นไปได้

1. **Google Maps API Key ไม่ถูกต้องหรือไม่ได้ Enable**
2. **SHA-1 Fingerprint ไม่ถูกต้อง**
3. **App ยังไม่ได้ rebuild หลังจากเปลี่ยน AndroidManifest.xml**

## วิธีแก้ไข

### 1. ตรวจสอบ Google Maps API Key

1. ไปที่ [Google Cloud Console](https://console.cloud.google.com/)
2. เลือก Project ของคุณ
3. ไปที่ **APIs & Services** > **Credentials**
4. ตรวจสอบว่า API Key `AIzaSyA4HMfVowBwSs-KqZxBKgdBfyq0EGT-ios` มีอยู่และถูกต้อง
5. ตรวจสอบว่า **Maps SDK for Android** ถูก Enable แล้ว:
   - ไปที่ **APIs & Services** > **Library**
   - ค้นหา "Maps SDK for Android"
   - ตรวจสอบว่า Status เป็น **Enabled**

### 2. ตรวจสอบ SHA-1 Fingerprint

1. เปิด Terminal/Command Prompt
2. ไปที่โฟลเดอร์ `android`
3. รันคำสั่ง:
   ```bash
   cd android
   .\gradlew signingReport
   ```
4. ค้นหา SHA-1 fingerprint ใน output (สำหรับ debug key)
5. ไปที่ [Google Cloud Console](https://console.cloud.google.com/)
6. ไปที่ **APIs & Services** > **Credentials**
7. คลิกที่ API Key ของคุณ
8. ในส่วน **Application restrictions** > **Android apps**
9. เพิ่ม Package name: `com.example.tms_app`
10. เพิ่ม SHA-1 fingerprint ที่ได้จากขั้นตอนที่ 4
11. บันทึกการเปลี่ยนแปลง

### 3. Rebuild App

หลังจากแก้ไข AndroidManifest.xml หรือ API Key:

```bash
# ลบ build cache
flutter clean

# Rebuild app
flutter run
```

หรือใน Android Studio:
- **Build** > **Clean Project**
- **Build** > **Rebuild Project**

### 4. ตรวจสอบ Logcat

เปิด Logcat ใน Android Studio และค้นหาข้อความ error:
- `Google Maps API key not found`
- `Authentication failed`
- `API key not valid`

### 5. ตรวจสอบ AndroidManifest.xml

ตรวจสอบว่า API Key ถูกตั้งค่าไว้ใน `android/app/src/main/AndroidManifest.xml`:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_API_KEY_HERE" />
```

### 6. ตรวจสอบ Internet Permission

ตรวจสอบว่า Internet permission ถูกเพิ่มไว้ใน AndroidManifest.xml:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

## การแก้ไขที่ทำแล้ว

1. ✅ เพิ่ม `GoogleMapController` เพื่อจัดการ map
2. ✅ ใช้ `SizedBox.expand` เพื่อให้ map ขยายเต็มพื้นที่
3. ✅ เพิ่ม `zoomControlsEnabled: false` และ `compassEnabled: true`
4. ✅ เพิ่ม `dispose()` method เพื่อ dispose controller

## ขั้นตอนถัดไป

1. ตรวจสอบ Google Maps API Key และ SHA-1 fingerprint
2. Rebuild app (`flutter clean` แล้ว `flutter run`)
3. ตรวจสอบ Logcat สำหรับ error messages
4. ทดสอบบน device จริง (ไม่ใช่ emulator) ถ้าเป็นไปได้

## หมายเหตุ

- Google Maps บน Android Emulator อาจทำงานช้าหรือไม่แสดงผล
- แนะนำให้ทดสอบบน device จริง
- ตรวจสอบว่า emulator มี Google Play Services ติดตั้งอยู่

