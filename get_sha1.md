# วิธีหา SHA-1 Fingerprint สำหรับ Google Maps API

## สำหรับ Windows (PowerShell)

### 1. หา SHA-1 สำหรับ Debug Keystore (สำหรับการพัฒนา)

รันคำสั่งนี้ใน PowerShell:

```powershell
cd $env:USERPROFILE\.android
keytool -list -v -keystore debug.keystore -alias androiddebugkey -storepass android -keypass android
```

หรือถ้าใช้ Java 11+:

```powershell
cd $env:USERPROFILE\.android
keytool -list -v -keystore debug.keystore -alias androiddebugkey -storepass android -keypass android | Select-String "SHA1"
```

### 2. หา SHA-1 จาก Gradle (วิธีที่ง่ายกว่า)

รันคำสั่งนี้ใน terminal ที่ root ของโปรเจค:

```bash
cd android
./gradlew signingReport
```

หรือสำหรับ Windows:

```powershell
cd android
.\gradlew signingReport
```

จากนั้นดูที่ส่วน "Variant: debug" จะเห็น SHA1 fingerprint

### 3. หา SHA-1 จาก Keystore ที่มีอยู่แล้ว

ถ้าคุณมี keystore file สำหรับ release:

```powershell
keytool -list -v -keystore <path-to-your-keystore> -alias <your-key-alias>
```

## เพิ่ม SHA-1 ใน Google Cloud Console

1. ไปที่ [Google Cloud Console](https://console.cloud.google.com/)
2. เลือกโปรเจคของคุณ
3. ไปที่ **APIs & Services** > **Credentials**
4. คลิกที่ API key ของคุณ
5. ในส่วน **Application restrictions** เลือก **Android apps**
6. คลิก **+ Add an item**
7. ใส่:
   - **Package name**: `com.example.tms_app` (จาก `android/app/build.gradle.kts`)
   - **SHA-1 certificate fingerprint**: วาง SHA-1 ที่ได้จากขั้นตอนด้านบน
8. คลิก **Save**

## หมายเหตุ

- **Debug SHA-1**: ใช้สำหรับทดสอบในระหว่างพัฒนา
- **Release SHA-1**: ใช้สำหรับแอปที่ build สำหรับ production
- คุณสามารถเพิ่ม SHA-1 หลายตัวได้ (debug และ release)
- หลังจากเพิ่ม SHA-1 แล้ว อาจต้องรอ 5-10 นาทีเพื่อให้ API key ทำงาน


