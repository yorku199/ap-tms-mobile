class ApiConfig {
  // เปลี่ยน URL ตาม environment ของคุณ
  // สำหรับ Android Emulator ใช้: http://10.0.2.2:3000
  // สำหรับ iOS Simulator ใช้: http://localhost:3000
  // สำหรับ Physical Device ใช้: http://<your-ip-address>:3000
  // วิธีหา IP address: เปิด Command Prompt/Terminal แล้วพิมพ์ ipconfig (Windows) หรือ ifconfig (Mac/Linux)
  // ดูที่ IPv4 Address ของ network adapter ที่คุณใช้
  static const String baseUrl =
      'http://111.112.113.107:3000'; // Physical Device - ใช้ IP address ของคอมพิวเตอร์ที่รัน API server

  static const String loginEndpoint = '/api/auth/login';
  static const String meEndpoint = '/api/auth/me';
  static const String verifyEndpoint = '/api/auth/verify';
  static const String logoutEndpoint = '/api/auth/logout';
  static const String jobOrderEndpoint = '/api/job-order';

  static String get loginUrl => '$baseUrl$loginEndpoint';
  static String get meUrl => '$baseUrl$meEndpoint';
  static String get verifyUrl => '$baseUrl$verifyEndpoint';
  static String get logoutUrl => '$baseUrl$logoutEndpoint';
}
