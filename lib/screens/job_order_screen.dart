import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../providers/auth_provider.dart';
import '../models/job_order_model.dart';
import '../services/job_order_service.dart';
import '../services/user_service.dart';
import 'identity_verification_screen.dart';
import 'job_detail_screen.dart';

class JobOrderScreen extends StatefulWidget {
  const JobOrderScreen({super.key});

  @override
  State<JobOrderScreen> createState() => _JobOrderScreenState();
}

class _JobOrderScreenState extends State<JobOrderScreen> {
  final JobOrderService _jobOrderService = JobOrderService();
  final UserService _userService = UserService();
  final ImagePicker _imagePicker = ImagePicker();
  JobOrderSummary? _summary;
  List<JobOrder> _jobs = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadJobOrders();
  }

  Future<void> _loadJobOrders() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await _jobOrderService.getJobOrders();

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (result['success'] == true) {
          _summary = result['summary'] as JobOrderSummary;
          _jobs = result['jobs'] as List<JobOrder>;
        } else {
          _errorMessage = result['message'] as String?;
        }
      });
    }
  }

  Future<void> _acceptJob(int jobId) async {
    // แสดง confirmation dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ยืนยันการรับงาน'),
        content: const Text('คุณต้องการรับงานนี้หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('รับงาน'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // แสดง loading
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final result = await _jobOrderService.acceptJob(jobId);

    if (mounted) {
      Navigator.of(context).pop(); // ปิด loading dialog

      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] as String? ?? 'รับงานสำเร็จ'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        // Reload job orders
        _loadJobOrders();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] as String? ?? 'ไม่สามารถรับงานได้'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _pickAndUploadImage() async {
    try {
      // เลือกรูปภาพ
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image == null) return;

      // แสดง loading
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      // อัพโหลดรูป
      final result = await _userService.uploadProfileImage(File(image.path));

      if (mounted) {
        Navigator.of(context).pop(); // ปิด loading dialog

        if (result['success'] == true) {
          // อัพเดทข้อมูลผู้ใช้
          final authProvider = Provider.of<AuthProvider>(context, listen: false);
          await authProvider.fetchCurrentUser();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] as String? ?? 'อัพโหลดรูป profile สำเร็จ'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] as String? ?? 'ไม่สามารถอัพโหลดรูป profile ได้'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // ปิด loading dialog ถ้ายังเปิดอยู่
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เกิดข้อผิดพลาด: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ยืนยันการออกจากระบบ'),
        content: const Text('คุณต้องการออกจากระบบหรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('ออกจากระบบ'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await authProvider.logout();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const IdentityVerificationScreen(),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('AP TMS'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.lock_open),
            onPressed: _logout,
            tooltip: 'ออกจากระบบ',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[300],
            height: 1,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 64, color: Colors.red[300]),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red[700]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadJobOrders,
                        child: const Text('ลองใหม่'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadJobOrders,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Section
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 40, 16, 32),
                          child: Column(
                            children: [
                              // Profile Picture with Edit Button
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 48,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      backgroundImage: user?.profileImageUrl != null
                                          ? NetworkImage(user!.profileImageUrl!)
                                          : null,
                                      child: user?.profileImageUrl == null
                                          ? Text(
                                              user?.name?.substring(0, 1).toUpperCase() ??
                                                  'U',
                                              style: const TextStyle(
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            )
                                          : null,
                                    ),
                                  ),
                                  // Edit Button
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: _pickAndUploadImage,
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[600],
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // User Name
                              Text(
                                '${user?.name ?? ''} ${user?.lastname ?? ''}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),

                              // Employee Code / Username
                              Text(
                                user?.employeeCode != null
                                    ? '@${user!.employeeCode}'
                                    : user?.username != null
                                        ? '@${user!.username}'
                                        : '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),

                              // Statistics Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildStatItem(
                                    '${_summary?.total ?? 0}',
                                    'ทั้งหมด',
                                  ),
                                  _buildStatItem(
                                    '${_summary?.completed ?? 0}',
                                    'จบงาน',
                                  ),
                                  _buildStatItem(
                                    '${_summary?.accepted ?? 0}',
                                    'รับงาน',
                                  ),
                                  _buildStatItem(
                                    '${_summary?.pending ?? 0}',
                                    'รอรับงาน',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Job List
                        if (_jobs.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(32.0),
                            child: Center(
                              child: Text(
                                'ไม่มีงานในวันนี้',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _jobs.length,
                            itemBuilder: (context, index) {
                              final job = _jobs[index];
                              return _buildJobCard(job);
                            },
                          ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildJobCard(JobOrder job) {
    final cardContent = Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job ID and Accept Button / Check In Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                job.jobNo,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (job.isPending)
                ElevatedButton(
                  onPressed: () => _acceptJob(job.jobId),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                  ),
                  child: const Text('กดเพื่อรับงาน'),
                )
              else if (job.isAccepted)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetailScreen(job: job),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                  ),
                  child: const Text('เช็คอิน'),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Truck No
          _buildInfoRow('ทะเบียน:', job.truckNo, Icons.local_shipping),

          // Route
          _buildInfoRow('Route:', job.route, Icons.route),

          // Time
          _buildInfoRow('เวลา:', job.formattedTime, Icons.access_time),

          // Status
          if (job.status.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.refresh, size: 16, color: Colors.blue[300]),
                const SizedBox(width: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    job.status,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );

    // ถ้ารับงานแล้ว ให้การ์ดสามารถกดได้
    if (job.isAccepted) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailScreen(job: job),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: cardContent,
      );
    }

    return cardContent;
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey[800], fontSize: 14),
                children: [
                  TextSpan(
                    text: label,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  TextSpan(text: ' $value'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

