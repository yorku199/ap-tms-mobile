import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/job_order_model.dart';
import '../utils/storage.dart';

class JobOrderService {
  // ฟังก์ชันสำหรับเรียก API พร้อม Token
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

  // ดึง job orders ของ driver ณ วันนั้น
  Future<Map<String, dynamic>> getJobOrders({DateTime? date}) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/job-order');
      final uriWithParams = date != null
          ? uri.replace(queryParameters: {
              'date': '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
            })
          : uri;
      
      print('📋 [JobOrderService] Requesting job orders from: $uriWithParams');
      final response = await http.get(
        uriWithParams,
        headers: await _getHeaders(),
      );

      print('📋 [JobOrderService] Response status: ${response.statusCode}');
      print('📋 [JobOrderService] Response body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        final summary = JobOrderSummary.fromJson(data['data']['summary']);
        final jobs = (data['data']['jobs'] as List<dynamic>)
            .map((j) => JobOrder.fromJson(j as Map<String, dynamic>))
            .toList();

        print('📋 [JobOrderService] Success! Jobs count: ${jobs.length}');
        if (jobs.length > 0) {
          print('📋 [JobOrderService] First job: ${jobs[0].jobNo}, routes: ${jobs[0].routes.length}');
        }

        return {
          'success': true,
          'summary': summary,
          'jobs': jobs,
        };
      } else {
        print('📋 [JobOrderService] Failed: ${data['message'] ?? 'Unknown error'}');
        return {
          'success': false,
          'message': data['message'] ?? 'ไม่สามารถดึงข้อมูล job orders ได้',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'เกิดข้อผิดพลาดในการเชื่อมต่อ: ${e.toString()}',
      };
    }
  }

  // รับงาน
  Future<Map<String, dynamic>> acceptJob(int jobId) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/api/job-order/$jobId/accept'),
        headers: await _getHeaders(),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'รับงานสำเร็จ',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'ไม่สามารถรับงานได้',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'เกิดข้อผิดพลาดในการเชื่อมต่อ: ${e.toString()}',
      };
    }
  }

  // Check In
  Future<Map<String, dynamic>> checkIn(int routeId, {bool isSecond = false}) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/job-order/route/$routeId/check-in')
          .replace(queryParameters: isSecond ? {'isSecond': 'true'} : {});
      final response = await http.post(
        uri,
        headers: await _getHeaders(),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'Check In สำเร็จ',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'ไม่สามารถ Check In ได้',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'เกิดข้อผิดพลาดในการเชื่อมต่อ: ${e.toString()}',
      };
    }
  }

  // Check Out
  Future<Map<String, dynamic>> checkOut(int routeId, {bool isSecond = false}) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/job-order/route/$routeId/check-out')
          .replace(queryParameters: isSecond ? {'isSecond': 'true'} : {});
      final response = await http.post(
        uri,
        headers: await _getHeaders(),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'Check Out สำเร็จ',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'ไม่สามารถ Check Out ได้',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'เกิดข้อผิดพลาดในการเชื่อมต่อ: ${e.toString()}',
      };
    }
  }

  // ดึง job order detail (สำหรับ refresh ข้อมูล)
  Future<Map<String, dynamic>> getJobOrderDetail(int jobId) async {
    try {
      // ใช้ getJobOrders แล้ว filter ตาม jobId
      final result = await getJobOrders();
      if (result['success'] == true) {
        final jobs = result['jobs'] as List<JobOrder>;
        final job = jobs.firstWhere(
          (j) => j.jobId == jobId,
          orElse: () => throw Exception('ไม่พบ job order'),
        );
        return {
          'success': true,
          'job': job,
        };
      } else {
        return result;
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'เกิดข้อผิดพลาด: ${e.toString()}',
      };
    }
  }
}

