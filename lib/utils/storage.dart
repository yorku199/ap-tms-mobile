import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  // บันทึก Token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // อ่าน Token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // ลบ Token
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // บันทึกข้อมูลผู้ใช้
  static Future<void> saveUser(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    // แปลง Map เป็น JSON string (ใช้วิธีง่ายๆ)
    await prefs.setString(_userKey, userData.toString());
  }

  // อ่านข้อมูลผู้ใช้
  static Future<Map<String, dynamic>?> getUser() async {
    // ในกรณีจริงควรใช้ JSON encoding/decoding
    return null; // ใช้ API แทน
  }

  // ลบข้อมูลผู้ใช้
  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // ลบข้อมูลทั้งหมด (สำหรับ logout)
  static Future<void> clearAll() async {
    await removeToken();
    await removeUser();
  }
}

