import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'job_order_screen.dart';

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
  bool _isLoading = false;

  @override
  void dispose() {
    _idCardController.dispose();
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

  // ฟังก์ชันสำหรับยืนยันตัวตน
  Future<void> _verifyIdentity() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.login(_idCardController.text.trim());

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (success) {
      // นำทางไปหน้า Job Order
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const JobOrderScreen(),
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
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _verifyIdentity(),
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
                    'กรุณากรอกรหัสบัตรประชาชน 13 หลักเพื่อยืนยันตัวตน',
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

