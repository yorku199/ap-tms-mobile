import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../utils/storage.dart';

class UserService {
  // อัพโหลดรูป profile
  Future<Map<String, dynamic>> uploadProfileImage(File imageFile) async {
    try {
      final token = await Storage.getToken();
      if (token == null) {
        return {
          'success': false,
          'message': 'กรุณาเข้าสู่ระบบใหม่',
        };
      }

      final uri = Uri.parse('${ApiConfig.baseUrl}/api/user/upload-profile-image');
      final request = http.MultipartRequest('POST', uri);
      
      // เพิ่ม headers
      request.headers['Authorization'] = 'Bearer $token';
      
      // เพิ่มไฟล์
      final file = await http.MultipartFile.fromPath(
        'profile_image',
        imageFile.path,
      );
      request.files.add(file);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'อัพโหลดรูป profile สำเร็จ',
          'profile_image_url': data['data']['profile_image_url'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'ไม่สามารถอัพโหลดรูป profile ได้',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'เกิดข้อผิดพลาดในการเชื่อมต่อ: ${e.toString()}',
      };
    }
  }
}

