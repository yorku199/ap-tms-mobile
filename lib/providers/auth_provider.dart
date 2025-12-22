import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  // เข้าสู่ระบบ
  Future<bool> login(String idCardNo, String birthDate) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _apiService.login(idCardNo, birthDate);

      if (result['success'] == true) {
        _user = User.fromJson(result['user']);
        _errorMessage = null;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'] ?? 'เกิดข้อผิดพลาดในการเข้าสู่ระบบ';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'เกิดข้อผิดพลาด: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ออกจากระบบ
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.logout();
      _user = null;
      _errorMessage = null;
    } catch (e) {
      // แม้จะเกิด error ก็ล้างข้อมูล
      _user = null;
      _errorMessage = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ดึงข้อมูลผู้ใช้ปัจจุบัน
  Future<void> fetchCurrentUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _apiService.getCurrentUser();

      if (result['success'] == true) {
        _user = User.fromJson(result['user']);
        _errorMessage = null;
      } else {
        _errorMessage = result['message'];
        _user = null;
      }
    } catch (e) {
      _errorMessage = 'เกิดข้อผิดพลาด: ${e.toString()}';
      _user = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ล้าง error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

