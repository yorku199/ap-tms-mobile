import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/job_order_model.dart';
import '../services/job_order_service.dart';
import '../providers/auth_provider.dart';

class JobDetailScreen extends StatefulWidget {
  final JobOrder job;

  const JobDetailScreen({
    super.key,
    required this.job,
  });

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  final JobOrderService _jobOrderService = JobOrderService();
  late JobOrder _job;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _job = widget.job;
  }

  Future<void> _refreshJobData() async {
    setState(() {
      _isLoading = true;
    });

    final result = await _jobOrderService.getJobOrderDetail(_job.jobId);

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (result['success'] == true) {
          _job = result['job'] as JobOrder;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final currentUserId = authProvider.user?.id;
    
    // แสดง routes ทั้งหมด (ไม่กรองตาม driver_id)
    List<JobRoute> filteredRoutes = _job.routes;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('รายละเอียดงาน'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshJobData,
              child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Info Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _job.jobNo,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _job.isAccepted
                                ? Colors.green[100]
                                : _job.isCompleted
                                    ? Colors.blue[100]
                                    : Colors.orange[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _job.status,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _job.isAccepted
                                  ? Colors.green[700]
                                  : _job.isCompleted
                                      ? Colors.blue[700]
                                      : Colors.orange[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'ทะเบียนรถ',
                      _job.truckNo,
                      Icons.local_shipping,
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      'Route',
                      _job.route,
                      Icons.route,
                    ),
                    if (_job.bookingNo != null && _job.bookingNo!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _buildDetailRow(
                        'Booking No',
                        _job.bookingNo!,
                        Icons.book,
                      ),
                    ],
                    if (_job.referenceNo != null && _job.referenceNo!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _buildDetailRow(
                        'Reference No',
                        _job.referenceNo!,
                        Icons.receipt,
                      ),
                    ],
                    const SizedBox(height: 12),
                    if (_job.stampDate != null)
                      _buildDetailRow(
                        'วันที่งาน',
                        '${_job.stampDate!.year}-${_job.stampDate!.month.toString().padLeft(2, '0')}-${_job.stampDate!.day.toString().padLeft(2, '0')} ${_job.stampDate!.hour.toString().padLeft(2, '0')}:${_job.stampDate!.minute.toString().padLeft(2, '0')}',
                        Icons.calendar_today,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Routes List
            const Text(
              'รายละเอียด Route',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (filteredRoutes.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      'ไม่มีข้อมูล Route',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              )
            else
              // ถ้า job_class = 1 แต่ละ route ให้แสดง 2 การ์ด
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredRoutes.length,
                itemBuilder: (context, index) {
                  final route = filteredRoutes[index];
                  // ถ้า job_class = 1 ให้แสดง 2 การ์ดสำหรับแต่ละ route
                  if (_job.jobClass == 1) {
                    // คำนวณ cardNumber ให้ต่อเนื่องกัน (route 0 = 1,2, route 1 = 3,4, ...)
                    final startCardNumber = (index * 2) + 1;
                    return _buildDualRouteCards(route, startCardNumber, currentUserId);
                  } else {
                    return _buildRouteCard(route, index);
                  }
                },
              ),
          ],
        ),
              ),
            ),
    );
  }

  // สร้าง 2 การ์ดสำหรับ job_class = 1
  Widget _buildDualRouteCards(JobRoute route, int startCardNumber, int? currentUserId) {
    return Column(
      children: [
        // การ์ดแรก: gsdb_id, plan_in, plan_out, actual_in, actual_out
        _buildRouteCard2(
          route: route,
          locationName: route.locationName,
          planIn: route.planIn,
          planOut: route.planOut,
          actualIn: route.actualIn,
          actualOut: route.actualOut,
          cardNumber: startCardNumber,
          showBottomMargin: false, // ไม่แสดง margin bottom เพราะมีการ์ดถัดไป
          currentUserId: currentUserId,
          isSecond: false, // การ์ดแรก
        ),
        const SizedBox(height: 12),
        // การ์ดที่ 2: gsdb_id2, plan_in2, plan_out2, actual_in2, actual_out2
        _buildRouteCard2(
          route: route,
          locationName: route.locationName2,
          planIn: route.planIn2,
          planOut: route.planOut2,
          actualIn: route.actualIn2,
          actualOut: route.actualOut2,
          cardNumber: startCardNumber + 1,
          showBottomMargin: true, // แสดง margin bottom เพราะเป็นการ์ดสุดท้าย
          currentUserId: currentUserId,
          isSecond: true, // การ์ดที่ 2
        ),
      ],
    );
  }

  // สร้างการ์ด route แบบปกติ
  Widget _buildRouteCard(JobRoute route, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildRouteCardContent(route, index),
      ),
    );
  }

  // สร้างการ์ด route สำหรับ dual cards (job_class = 1)
  Widget _buildRouteCard2({
    required JobRoute route,
    String? locationName,
    DateTime? planIn,
    DateTime? planOut,
    DateTime? actualIn,
    DateTime? actualOut,
    required int cardNumber,
    bool showBottomMargin = true,
    int? currentUserId,
    bool isSecond = false, // ระบุว่าเป็นการ์ดที่ 2 หรือไม่
  }) {
    return Card(
      margin: showBottomMargin 
          ? const EdgeInsets.only(bottom: 12)
          : EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$cardNumber',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        locationName ?? 'ไม่ระบุสถานที่',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // แสดงชื่อพนักงานขับรถเมื่อ job_class = 1 และ driver_id ตรงกับ user ที่ login
                      if (_job.jobClass == 1 && 
                          route.driverId != null && 
                          currentUserId != null &&
                          route.driverId == currentUserId &&
                          route.driverName != null && 
                          route.driverName!.trim().isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                route.driverName!.trim(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (planIn != null)
              _buildRouteTimeRow(
                'เวลาเข้า (Plan)',
                planIn,
                Icons.schedule,
              ),
            if (planIn != null && planOut != null) const SizedBox(height: 8),
            if (planOut != null)
              _buildRouteTimeRow(
                'เวลาออก (Plan)',
                planOut,
                Icons.schedule,
              ),
            if (actualIn != null) ...[
              if (planOut != null) const SizedBox(height: 8),
              _buildRouteTimeRow(
                'เวลาเข้า (Actual)',
                actualIn,
                Icons.check_circle,
                color: Colors.green,
              ),
            ],
            if (actualOut != null) ...[
              if (actualIn != null) const SizedBox(height: 8),
              _buildRouteTimeRow(
                'เวลาออก (Actual)',
                actualOut,
                Icons.check_circle,
                color: Colors.green,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // สร้างเนื้อหาการ์ด route
  Widget _buildRouteCardContent(JobRoute route, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    route.locationName ?? 'ไม่ระบุสถานที่',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // แสดงชื่อพนักงานขับรถเมื่อ job_class = 1
                  if (_job.jobClass == 1 && route.driverName != null && route.driverName!.trim().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            route.driverName!.trim(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (route.planIn != null)
          _buildRouteTimeRow(
            'เวลาเข้า (Plan)',
            route.planIn!,
            Icons.schedule,
          ),
        if (route.planIn != null) const SizedBox(height: 8),
        if (route.planOut != null)
          _buildRouteTimeRow(
            'เวลาออก (Plan)',
            route.planOut!,
            Icons.schedule,
          ),
        if (route.actualIn != null) ...[
          if (route.planOut != null) const SizedBox(height: 8),
          _buildRouteTimeRow(
            'เวลาเข้า (Actual)',
            route.actualIn!,
            Icons.check_circle,
            color: Colors.green,
          ),
        ],
        if (route.actualOut != null) ...[
          if (route.actualIn != null) const SizedBox(height: 8),
          _buildRouteTimeRow(
            'เวลาออก (Actual)',
            route.actualOut!,
            Icons.check_circle,
            color: Colors.green,
          ),
        ],
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRouteTimeRow(
    String label,
    DateTime time,
    IconData icon, {
    Color? color,
  }) {
    final timeStr =
        '${time.year}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    return Row(
      children: [
        Icon(icon, size: 16, color: color ?? Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            timeStr,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color ?? Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

