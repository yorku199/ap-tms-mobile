import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../utils/storage.dart';

class ApiService {
  // ฟังก์ชันสำหรับเรียก API พร้อม Token
  Future<Map<String, String>> _getHeaders({bool needAuth = false}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (needAuth) {
      final token = await Storage.getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  // เข้าสู่ระบบด้วยรหัสบัตรประชาชนและวันเดือนปีเกิด
  Future<Map<String, dynamic>> login(String idCardNo, String birthDate) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.loginUrl),
        headers: await _getHeaders(),
        body: jsonEncode({
          'id_card_no': idCardNo,
          'birth_date': birthDate,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        // บันทึก Token
        if (data['data']['token'] != null) {
          await Storage.saveToken(data['data']['token']);
        }
        return {
          'success': true,
          'message': data['message'] ?? 'เข้าสู่ระบบสำเร็จ',
          'user': data['data']['user'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'เกิดข้อผิดพลาดในการเข้าสู่ระบบ',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'เกิดข้อผิดพลาดในการเชื่อมต่อ: ${e.toString()}',
      };
    }
  }

  // ดึงข้อมูลผู้ใช้ปัจจุบัน
  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.meUrl),
        headers: await _getHeaders(needAuth: true),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {
          'success': true,
          'user': data['data']['user'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'ไม่สามารถดึงข้อมูลผู้ใช้ได้',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'เกิดข้อผิดพลาดในการเชื่อมต่อ: ${e.toString()}',
      };
    }
  }

  // ตรวจสอบ Token
  Future<Map<String, dynamic>> verifyToken() async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.verifyUrl),
        headers: await _getHeaders(needAuth: true),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'Token ถูกต้อง',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Token ไม่ถูกต้อง',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'เกิดข้อผิดพลาดในการเชื่อมต่อ: ${e.toString()}',
      };
    }
  }

  // ออกจากระบบ
  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.logoutUrl),
        headers: await _getHeaders(needAuth: true),
      );

      // ลบ Token จาก storage
      await Storage.clearAll();

      final data = jsonDecode(response.body);

      return {
        'success': true,
        'message': data['message'] ?? 'ออกจากระบบสำเร็จ',
      };
    } catch (e) {
      // แม้จะเกิด error ก็ลบ token
      await Storage.clearAll();
      return {
        'success': true,
        'message': 'ออกจากระบบสำเร็จ',
      };
    }
  }
}

