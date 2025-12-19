import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/storage.dart';
import 'identity_verification_screen.dart';
import 'job_order_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    // รอสักครู่เพื่อแสดง splash screen
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    // ตรวจสอบว่ามี token หรือไม่
    final token = await Storage.getToken();
    
    if (token != null && token.isNotEmpty) {
      // มี token ให้ตรวจสอบว่า token ยังใช้ได้หรือไม่
      try {
        await authProvider.fetchCurrentUser();
        
        if (mounted) {
          if (authProvider.isAuthenticated) {
            // Token ใช้ได้ นำทางไปหน้า Job Order
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const JobOrderScreen(),
              ),
            );
          } else {
            // Token ไม่ใช้ได้หรือหมดอายุ ลบ token และไปหน้า Login
            await Storage.clearAll();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const IdentityVerificationScreen(),
              ),
            );
          }
        }
      } catch (e) {
        // เกิดข้อผิดพลาด ลบ token และไปหน้า Login
        await Storage.clearAll();
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const IdentityVerificationScreen(),
            ),
          );
        }
      }
    } else {
      // ไม่มี token ไปหน้า Login
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const IdentityVerificationScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_shipping,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'AP TMS',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

