import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/auth_provider.dart';
import 'profile_screen.dart';

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({super.key});

  @override
  State<IdentityVerificationScreen> createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState
    extends State<IdentityVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _idCardController = TextEditingController();
  final _birthDateController = TextEditingController();
  DateTime? _selectedBirthDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _idCardController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  // ฟังก์ชันสำหรับตรวจสอบรหัสบัตรประชาชน
  String? _validateIdCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณากรอกรหัสบัตรประชาชน';
    }
    if (value.length != 13) {
      return 'รหัสบัตรประชาชนต้องเป็นตัวเลข 13 หลัก';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'รหัสบัตรประชาชนต้องเป็นตัวเลขเท่านั้น';
    }
    return null;
  }

  // ฟังก์ชันสำหรับตรวจสอบวันเดือนปีเกิด
  String? _validateBirthDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'กรุณาเลือกวันเดือนปีเกิด';
    }
    return null;
  }

  // ฟังก์ชันสำหรับเลือกวันเดือนปีเกิด
  Future<void> _selectBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('th', 'TH'),
      helpText: 'เลือกวันเดือนปีเกิด',
      cancelText: 'ยกเลิก',
      confirmText: 'ยืนยัน',
    );
    if (picked != null && picked != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = picked;
        _birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // ฟังก์ชันสำหรับยืนยันตัวตน
  Future<void> _verifyIdentity() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedBirthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('กรุณาเลือกวันเดือนปีเกิด'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final birthDateStr = DateFormat('yyyy-MM-dd').format(_selectedBirthDate!);
    final success = await authProvider.login(
      _idCardController.text.trim(),
      birthDateStr,
    );

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (success) {
      // นำทางไปหน้า Profile
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
    } else {
      // แสดง error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authProvider.errorMessage ?? 'เกิดข้อผิดพลาดในการยืนยันตัวตน',
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ไอคอนหรือโลโก้
                  Icon(
                    Icons.verified_user,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 32),

                  // หัวข้อ
                  Text(
                    'ยืนยันตัวตน',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // ช่องกรอกรหัสบัตรประชาชน
                  TextFormField(
                    controller: _idCardController,
                    decoration: InputDecoration(
                      labelText: 'เลขบัตรประชาชน',
                      hintText: 'กรุณากรอกเลขบัตรประชาชน 13 หลัก',
                      prefixIcon: const Icon(Icons.credit_card),
                      suffixIcon: _idCardController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _idCardController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(13),
                    ],
                    validator: _validateIdCard,
                    onChanged: (_) => setState(() {}),
                    textInputAction: TextInputAction.next,
                    enabled: !_isLoading,
                  ),
                  const SizedBox(height: 24),

                  // ช่องเลือกวันเดือนปีเกิด
                  TextFormField(
                    controller: _birthDateController,
                    decoration: InputDecoration(
                      labelText: 'วันเดือนปีเกิด',
                      hintText: 'กรุณาเลือกวันเดือนปีเกิด',
                      prefixIcon: const Icon(Icons.calendar_today),
                      suffixIcon: _birthDateController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _birthDateController.clear();
                                setState(() {
                                  _selectedBirthDate = null;
                                });
                              },
                            )
                          : null,
                    ),
                    readOnly: true,
                    onTap: _selectBirthDate,
                    validator: _validateBirthDate,
                    enabled: !_isLoading,
                  ),
                  const SizedBox(height: 32),

                  // ปุ่มยืนยันตัวตน
                  ElevatedButton(
                    onPressed: _isLoading ? null : _verifyIdentity,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'ยืนยันตัวตน',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),

                  // ข้อความช่วยเหลือ
                  Text(
                    'กรุณากรอกรหัสบัตรประชาชน 13 หลักและเลือกวันเดือนปีเกิดเพื่อยืนยันตัวตน',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

