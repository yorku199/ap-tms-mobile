# วิธีเปลี่ยน App Icon

## ขั้นตอนการเปลี่ยน App Icon

### 1. เตรียมไฟล์ Icon

สร้างไฟล์ icon ขนาด **1024x1024 pixels** ในรูปแบบ PNG และบันทึกไว้ที่:
```
assets/icon/app_icon.png
```

**ข้อกำหนด:**
- ขนาด: 1024x1024 pixels (แนะนำ)
- รูปแบบ: PNG
- พื้นหลัง: ควรเป็นสี่เหลี่ยมจัตุรัส
- สำหรับ Android adaptive icon: ควรมี padding รอบๆ (แนะนำ 20% ของขนาด)

### 2. สร้าง folder และวางไฟล์

```bash
mkdir -p assets/icon
# วางไฟล์ app_icon.png ไว้ใน folder นี้
```

### 3. รันคำสั่งสร้าง Icons

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

### 4. Build และทดสอบ

```bash
# สำหรับ Android
flutter build apk

# สำหรับ iOS
flutter build ios
```

## หมายเหตุ

- หลังจากรันคำสั่ง `flutter_launcher_icons` ระบบจะสร้าง icons ทุกขนาดให้อัตโนมัติ
- ถ้าต้องการเปลี่ยน icon อีกครั้ง แค่เปลี่ยนไฟล์ `assets/icon/app_icon.png` แล้วรันคำสั่งใหม่
- สำหรับ Android adaptive icon: ถ้าต้องการพื้นหลังสีอื่น แก้ไข `adaptive_icon_background` ใน `pubspec.yaml`

## ตัวอย่างการตั้งค่าเพิ่มเติม

ถ้าต้องการตั้งค่าเฉพาะ platform:

```yaml
flutter_launcher_icons:
  android: true
  ios: true
  web: true
  windows: true
  macos: true
  image_path: "assets/icon/app_icon.png"
  adaptive_icon_background: "#FFFFFF"
  adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"
  remove_alpha_ios: true
```

## เครื่องมือแนะนำสำหรับสร้าง Icon

1. **Online Tools:**
   - [App Icon Generator](https://www.appicon.co/)
   - [Icon Kitchen](https://icon.kitchen/)

2. **Design Tools:**
   - Figma
   - Adobe Illustrator
   - Canva

