import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../utils/storage.dart';
import '../models/check_in_model.dart';

class CheckInService {
  static const String baseUrl = ApiConfig.baseUrl;

  // ดึง headers พร้อม token
  Future<Map<String, String>> _getHeaders() async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final token = await Storage.getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  // ดึงข้อมูล yard ของ user
  Future<List<Yard>> getUserYards() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/yard/yards'),
        headers: await _getHeaders(),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        final List<dynamic> yardsJson = data['data']['yards'] ?? [];
        return yardsJson.map((json) => Yard.fromJson(json)).toList();
      } else {
        throw Exception(data['message'] ?? 'ไม่สามารถดึงข้อมูล yard ได้');
      }
    } catch (e) {
      throw Exception('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }

  // เช็คอิน
  Future<Map<String, dynamic>> checkIn({
    required int yardId,
    required double userLat,
    required double userLong,
    required double yardLat,
    required double yardLong,
    required double distance,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/check-in/check-in'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'yard_id': yardId,
          'user_lat': userLat,
          'user_long': userLong,
          'yard_lat': yardLat,
          'yard_long': yardLong,
          'distance': distance,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'เช็คอินสำเร็จ',
          'data': data['data'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'ไม่สามารถเช็คอินได้',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'เกิดข้อผิดพลาด: ${e.toString()}',
      };
    }
  }

  // เช็คเอาท์
  Future<Map<String, dynamic>> checkOut({
    required double userLat,
    required double userLong,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/check-in/check-out'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'user_lat': userLat,
          'user_long': userLong,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'เช็คเอาท์สำเร็จ',
          'data': data['data'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'ไม่สามารถเช็คเอาท์ได้',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'เกิดข้อผิดพลาด: ${e.toString()}',
      };
    }
  }

  // ดึงข้อมูล check in ล่าสุดของ user
  Future<CheckIn?> getLatestCheckIn() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/check-in/latest'),
        headers: await _getHeaders(),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        if (data['data']['check_in'] != null) {
          return CheckIn.fromJson(data['data']['check_in']);
        }
        return null;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // เช็คอินเข้างาน
  Future<Map<String, dynamic>> checkInJob({
    required double userLat,
    required double userLong,
    required double mileage,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/check-in-job/check-in'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'user_lat': userLat,
          'user_long': userLong,
          'mileage': mileage,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'เช็คอินเข้างานสำเร็จ',
          'data': data['data'],
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'ไม่สามารถเช็คอินเข้างานได้',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'เกิดข้อผิดพลาด: ${e.toString()}',
      };
    }
  }

  // ดึงข้อมูลเช็คอินเข้างานล่าสุด
  Future<CheckInJob?> getLatestCheckInJob() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/check-in-job/latest'),
        headers: await _getHeaders(),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        if (data['data'] == null) {
          return null;
        }
        return CheckInJob.fromJson(data['data']);
      } else {
        throw Exception(data['message'] ?? 'ไม่สามารถดึงข้อมูลเช็คอินเข้างานได้');
      }
    } catch (e) {
      throw Exception('เกิดข้อผิดพลาด: ${e.toString()}');
    }
  }
}

