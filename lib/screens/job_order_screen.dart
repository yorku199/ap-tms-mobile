import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../providers/auth_provider.dart';
import '../models/job_order_model.dart';
import '../services/job_order_service.dart';
import '../services/check_in_service.dart';
import 'identity_verification_screen.dart';
import 'job_detail_screen.dart';

class TimelineItem {
  final DateTime time;
  final String title;
  final String subtitle;
  final String location;
  final bool isJob;
  final JobOrder job;
  final JobRoute? route;
  final bool isCompleted;
  final bool isActive;

  TimelineItem({
    required this.time,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.isJob,
    required this.job,
    this.route,
    required this.isCompleted,
    required this.isActive,
  });
}

class JobOrderScreen extends StatefulWidget {
  const JobOrderScreen({super.key});

  @override
  State<JobOrderScreen> createState() => _JobOrderScreenState();
}

class _JobOrderScreenState extends State<JobOrderScreen> {
  final JobOrderService _jobOrderService = JobOrderService();
  final CheckInService _checkInService = CheckInService();
  final ScrollController _scrollController = ScrollController();
  JobOrderSummary? _summary;
  List<JobOrder> _jobs = [];
  bool _isLoading = true;
  String? _errorMessage;
  DateTime _selectedDate = DateTime.now();
  List<DateTime> _checkInTimes = []; // เก็บเวลาเช็คอินจาก tb_check_in_job
  DateTime? _loadingDate; // เก็บวันที่ที่กำลังโหลดอยู่

  // GlobalKeys สำหรับหาตำแหน่งจริงของ hour markers
  final Map<int, GlobalKey> _hourMarkerKeys = {};
  final GlobalKey _timelineColumnKey = GlobalKey();
  final GlobalKey _timelineStackKey = GlobalKey();
  double? _actualCurrentTimePosition;

  @override
  void initState() {
    super.initState();
    _loadJobOrders(_selectedDate);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ฟังก์ชันสำหรับคำนวณตำแหน่งจริงของเส้นสีแดง
  void _calculateActualPosition(int currentHour, int currentMinute) {
    final currentHourKey = _hourMarkerKeys[currentHour];
    final nextHourKey = _hourMarkerKeys[currentHour + 1];

    if (currentHourKey?.currentContext != null &&
        _timelineStackKey.currentContext != null) {
      final renderBox =
          currentHourKey!.currentContext!.findRenderObject() as RenderBox?;
      final stackRenderBox =
          _timelineStackKey.currentContext!.findRenderObject() as RenderBox?;

      if (renderBox != null && stackRenderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        final stackPosition = stackRenderBox.localToGlobal(Offset.zero);
        // ลบด้วย padding top (8.0) ของ Padding ที่หุ้ม Stack
        final relativeY = position.dy - stackPosition.dy - 8.0;

        // หาความสูงของ hour marker จาก hour marker ถัดไป
        double hourHeight = 26.0;
        if (nextHourKey?.currentContext != null) {
          final nextRenderBox =
              nextHourKey!.currentContext!.findRenderObject() as RenderBox?;
          if (nextRenderBox != null) {
            final nextPosition = nextRenderBox.localToGlobal(Offset.zero);
            hourHeight = (nextPosition.dy - position.dy).abs();
          }
        }

        // คำนวณตำแหน่งของเส้นสีแดง (จุดกึ่งกลางของ circle + offset ตามนาที)
        // Circle อยู่ที่จุดกึ่งกลางของ Row ซึ่งมีความสูง 18px ดังนั้นอยู่ที่ 9px จากด้านบน
        final circleCenterOffset = 9.0;
        final calculatedPosition = relativeY +
            circleCenterOffset +
            (currentMinute / 60.0) * hourHeight;

        print('🔴 RED LINE CALCULATION (using actual positions):');
        print(
            '  Current time: ${currentHour.toString().padLeft(2, '0')}:${currentMinute.toString().padLeft(2, '0')}');
        print('  Hour $currentHour marker actual position: $relativeY px');
        print('  Circle center offset: $circleCenterOffset px');
        print('  Hour height: $hourHeight px');
        print(
            '  Minute offset (${currentMinute}/60 * $hourHeight): ${(currentMinute / 60.0) * hourHeight} px');
        print('  Total calculated position: $calculatedPosition px');

        // อัปเดตตำแหน่งของเส้นสีแดงและ rebuild
        if (mounted &&
            (_actualCurrentTimePosition == null ||
                _actualCurrentTimePosition != calculatedPosition)) {
          setState(() {
            _actualCurrentTimePosition = calculatedPosition;
          });

          // Scroll ไปที่เส้นสีแดงหลังจากคำนวณตำแหน่งเสร็จ
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToCurrentTime();
          });
        }
      } else {
        print(
            '⚠️ WARNING: RenderBox is null - cannot calculate actual position');
      }
    } else {
      print(
          '⚠️ WARNING: GlobalKey not ready - currentHourKey: ${currentHourKey?.currentContext != null}, timelineStackKey: ${_timelineStackKey.currentContext != null}');
    }
  }

  Future<void> _loadJobOrders(DateTime date) async {
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    print('📋 [JobOrder] _loadJobOrders called for date: $dateStr');

    // ป้องกันการเรียกหลายครั้งพร้อมกัน - ถ้ากำลังโหลดอยู่แล้ว และเป็นวันที่เดียวกัน ให้ข้าม
    if (_isLoading && _loadingDate != null) {
      final loadingDateStr =
          '${_loadingDate!.year}-${_loadingDate!.month.toString().padLeft(2, '0')}-${_loadingDate!.day.toString().padLeft(2, '0')}';
      if (loadingDateStr == dateStr) {
        print(
            '📋 [JobOrder] Already loading same date, skipping duplicate call for date: $dateStr');
        return;
      }
      // ถ้ากำลังโหลดวันที่อื่นอยู่ ให้รอให้เสร็จก่อน (หรือข้ามไปเลย)
      print(
          '📋 [JobOrder] Already loading different date ($loadingDateStr), will continue with new date: $dateStr');
    }

    // ตั้งค่า loading date
    _loadingDate = date;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // โหลดข้อมูล job orders และ check-in times พร้อมกัน
    print(
        '📋 [JobOrder] Loading job orders and check-in times for date: $dateStr');
    final jobOrdersResult = await _jobOrderService.getJobOrders(date: date);
    final checkInTimesResult = await _loadCheckInTimesWithoutSetState(date);

    print(
        '📋 [JobOrder] Job orders result - success: ${jobOrdersResult['success']}, jobs count: ${jobOrdersResult['success'] == true ? (jobOrdersResult['jobs'] as List).length : 0}');
    print('📋 [JobOrder] Check-in times count: ${checkInTimesResult.length}');

    // ตรวจสอบว่ายังเป็นวันที่ที่เลือกอยู่หรือไม่ (ป้องกัน race condition)
    final isStillSelectedDate = _selectedDate.year == date.year &&
        _selectedDate.month == date.month &&
        _selectedDate.day == date.day;

    if (!isStillSelectedDate) {
      print(
          '📋 [JobOrder] Date changed while loading, ignoring results for date: $dateStr');
      return;
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
        _loadingDate = null; // ล้าง loading date
        // ตั้งค่า check-in times จากผลลัพธ์
        _checkInTimes = checkInTimesResult;
        print(
            '📅 [CheckIn] After setState, _checkInTimes has ${_checkInTimes.length} items');

        if (jobOrdersResult['success'] == true) {
          // ตรวจสอบอีกครั้งว่ายังเป็นวันที่ที่เลือกอยู่หรือไม่ (ป้องกัน race condition)
          final isStillSelectedDate = _selectedDate.year == date.year &&
              _selectedDate.month == date.month &&
              _selectedDate.day == date.day;

          if (!isStillSelectedDate) {
            print(
                '📋 [JobOrder] Date changed while processing, ignoring results for date: $dateStr');
            return;
          }

          // กรองข้อมูลตามวันที่ที่เลือก
          final allJobs = jobOrdersResult['jobs'] as List<JobOrder>;
          print('📋 [JobOrder] Received ${allJobs.length} job(s) from API');
          final selectedDateStart = DateTime(date.year, date.month, date.day);

          // กรอง jobs ที่มี routes ในวันที่ที่เลือก
          final filteredJobs = allJobs.where((job) {
            final hasMatchingRoute = job.routes.any((route) {
              if (route.planIn != null) {
                final routeDate = DateTime(
                  route.planIn!.year,
                  route.planIn!.month,
                  route.planIn!.day,
                );
                if (routeDate.isAtSameMomentAs(selectedDateStart)) {
                  return true;
                }
              }
              if (route.planIn2 != null) {
                final routeDate = DateTime(
                  route.planIn2!.year,
                  route.planIn2!.month,
                  route.planIn2!.day,
                );
                if (routeDate.isAtSameMomentAs(selectedDateStart)) {
                  return true;
                }
              }
              return false;
            });
            if (hasMatchingRoute) {
              print(
                  '📋 [JobOrder] Job ${job.jobNo} has matching route for date $dateStr');
            }
            return hasMatchingRoute;
          }).toList();

          print(
              '📋 [JobOrder] Filtered to ${filteredJobs.length} job(s) for date $dateStr');
          if (filteredJobs.isNotEmpty) {
            print(
                '📋 [JobOrder] First filtered job: ${filteredJobs[0].jobNo}, routes: ${filteredJobs[0].routes.length}');
            for (var route in filteredJobs[0].routes) {
              if (route.planIn != null) {
                print(
                    '📋 [JobOrder] Route ${route.id}: planIn=${route.planIn}, date=${route.planIn!.year}-${route.planIn!.month}-${route.planIn!.day}');
              }
            }
          }
          _jobs = filteredJobs;
          print('📋 [JobOrder] _jobs set to ${_jobs.length} job(s)');

          // คำนวณ summary ใหม่ตามข้อมูลที่กรองแล้ว
          _summary = JobOrderSummary(
            total: filteredJobs.length,
            completed: filteredJobs.where((j) => j.isCompleted).length,
            accepted: filteredJobs.where((j) => j.isAccepted).length,
            pending: filteredJobs.where((j) => j.isPending).length,
          );
        } else {
          print(
              '📋 [JobOrder] Failed to load job orders: ${jobOrdersResult['message']}');
          _errorMessage = jobOrdersResult['message'] as String?;
        }
      });
    }
  }

  // โหลด check-in times โดยไม่ setState (สำหรับใช้ใน _loadJobOrders)
  Future<List<DateTime>> _loadCheckInTimesWithoutSetState(DateTime date) async {
    try {
      final dateStr =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      print('📅 [CheckIn] Loading check-in times for date: $dateStr');
      final response = await _checkInService.getCheckInJobsByDate(dateStr);

      print('📅 [CheckIn] Response success: ${response['success']}');
      print('📅 [CheckIn] Response data: ${response['data']}');

      if (response['success'] == true) {
        final checkIns = response['data'];
        if (checkIns != null && checkIns is List) {
          print('📅 [CheckIn] Found ${checkIns.length} check-in(s)');

          final checkInTimes = checkIns.map((checkIn) {
            print(
                '📅 [CheckIn] Parsing check-in time: ${checkIn['checkInTime']}');
            // Parse เป็น DateTime (ไม่ต้องแปลงเป็น local time)
            return DateTime.parse(checkIn['checkInTime']);
          }).toList();

          print('📅 [CheckIn] Loaded ${checkInTimes.length} check-in times');
          for (var time in checkInTimes) {
            print(
                '📅 [CheckIn] - ${time.toString()} (year: ${time.year}, month: ${time.month}, day: ${time.day}, hour: ${time.hour})');
          }

          return checkInTimes;
        } else {
          print('📅 [CheckIn] No check-in data (null or not a list)');
          return [];
        }
      } else {
        print('📅 [CheckIn] Failed to load: ${response['message']}');
        return [];
      }
    } catch (e, stackTrace) {
      print('❌ [CheckIn] Error loading check-in times: $e');
      print('❌ [CheckIn] Stack trace: $stackTrace');
      return [];
    }
  }

  Future<void> _handleCheckInJob() async {
    // ตรวจสอบ permission
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('กรุณาเปิดใช้งาน Location Service'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('กรุณาอนุญาตให้เข้าถึงตำแหน่ง'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ไม่สามารถเข้าถึงตำแหน่งได้ กรุณาเปิดใน Settings'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

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

    try {
      // ดึงตำแหน่งปัจจุบัน
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // แสดง dialog เพื่อรับเลขไมล์ (บังคับกรอก)
      double? mileage;
      if (mounted) {
        Navigator.of(context).pop(); // ปิด loading dialog ก่อน
        mileage = await showDialog<double>(
          context: context,
          barrierDismissible: false, // ไม่ให้ปิด dialog โดยการกดนอก dialog
          builder: (context) {
            final mileageController = TextEditingController();
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text('เช็คอินเข้างาน'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'กรุณากรอกเลขไมล์',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: mileageController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'เลขไมล์ *',
                          hintText: '0.00',
                          border: OutlineInputBorder(),
                        ),
                        autofocus: true,
                        onChanged: (value) {
                          setState(
                              () {}); // อัปเดต UI เพื่อ enable/disable ปุ่ม
                        },
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        final mileageValue =
                            double.tryParse(mileageController.text);
                        if (mileageValue != null && mileageValue >= 0) {
                          Navigator.of(context).pop(mileageValue);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mileageController.text.isNotEmpty &&
                                double.tryParse(mileageController.text) !=
                                    null &&
                                double.tryParse(mileageController.text)! >= 0
                            ? Colors.red
                            : Colors.grey,
                      ),
                      child: const Text('ยืนยัน'),
                    ),
                  ],
                );
              },
            );
          },
        );
      }

      // ถ้ายกเลิก dialog หรือไม่กรอกเลขไมล์ ให้หยุด
      if (mileage == null && mounted) {
        return;
      }

      // แสดง loading อีกครั้ง
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      // เช็คอินเข้างาน (mileage ต้องไม่เป็น null เพราะผ่านการตรวจสอบแล้ว)
      final result = await _checkInService.checkInJob(
        userLat: position.latitude,
        userLong: position.longitude,
        mileage: mileage!, // ใช้ ! เพราะผ่านการตรวจสอบแล้ว
      );

      if (mounted) {
        Navigator.of(context).pop(); // ปิด loading dialog

        if (result['success'] == true) {
          // Refresh ข้อมูล job orders และ check-in times เพื่อให้ timeline อัปเดต
          await _loadJobOrders(_selectedDate);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'เช็คอินเข้างานสำเร็จ'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'ไม่สามารถเช็คอินเข้างานได้'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // ปิด loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เกิดข้อผิดพลาด: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _scrollToCurrentTime() {
    if (!_scrollController.hasClients) return;

    final now = DateTime.now();
    final selectedDate =
        DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
    final today = DateTime(now.year, now.month, now.day);

    // Scroll ไปที่เวลาปัจจุบันเฉพาะเมื่อเลือกวันที่เป็นวันนี้
    if (selectedDate.isAtSameMomentAs(today)) {
      // ใช้ตำแหน่งจริงของเส้นสีแดงถ้ามี
      if (_actualCurrentTimePosition != null) {
        // เพิ่ม offset สำหรับ sticky header (ประมาณ 200 pixels)
        // และลบ offset เพื่อให้เส้นสีแดงอยู่ตรงกลางหน้าจอ
        final screenHeight = MediaQuery.of(context).size.height;
        final scrollPosition =
            _actualCurrentTimePosition! + 200 - (screenHeight / 2);

        // รอให้ layout เสร็จก่อน scroll
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              scrollPosition.clamp(
                  0.0, _scrollController.position.maxScrollExtent),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
            print(
                '🔴 SCROLL: Scrolling to position: $scrollPosition (red line at: ${_actualCurrentTimePosition})');
          }
        });
      } else {
        // ถ้ายังไม่มีตำแหน่งจริง ให้คำนวณโดยประมาณ
        final currentHour = now.hour;
        final currentMinute = now.minute;

        // คำนวณตำแหน่งโดยประมาณ
        // แต่ละ hour marker มี padding bottom 8px + circle 18px = 26px
        // แต่ละชั่วโมงประมาณ 100 pixels รวม spacing
        final estimatedPosition =
            currentHour * 100.0 + (currentMinute / 60.0) * 100.0;

        // เพิ่ม offset สำหรับ sticky header (ประมาณ 200 pixels)
        final screenHeight = MediaQuery.of(context).size.height;
        final scrollPosition = estimatedPosition + 200 - (screenHeight / 2);

        // รอให้ layout เสร็จก่อน scroll
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              scrollPosition.clamp(
                  0.0, _scrollController.position.maxScrollExtent),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
            print(
                '🔴 SCROLL: Scrolling to estimated position: $scrollPosition');
          }
        });
      }
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
        _loadJobOrders(_selectedDate);
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
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: _handleCheckInJob,
          backgroundColor: Colors.red,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.location_on,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // Header Section (Sticky) - แสดงตลอดเวลา
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              minHeight: 200,
              maxHeight: 200,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Statistics Row
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    ),
                    // Date Picker
                    _buildDatePicker(),
                    // Divider
                    Container(
                      height: 1,
                      color: Colors.grey[300],
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Job Timeline (Scrollable) - แสดง loading หรือ error เฉพาะส่วนนี้
          SliverPadding(
            padding: const EdgeInsets.only(top: 8),
            sliver: _isLoading
                ? SliverToBoxAdapter(
                    child: Container(
                      height: 400,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                  )
                : _errorMessage != null
                    ? SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.all(32),
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
                                onPressed: () => _loadJobOrders(_selectedDate),
                                child: const Text('ลองใหม่'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: _buildTimeline(),
                      ),
          ),
        ],
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

  Widget _buildDatePicker() {
    final today = DateTime.now();
    // แสดง 5 วัน: วันปัจจุบัน ± 2 วัน (2 วันก่อน, วันนี้, 2 วันหลัง)
    final dates = List.generate(5, (index) {
      return today.add(Duration(days: index - 2)); // -2, -1, 0, 1, 2
    });

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: dates.map((date) {
            final isSelected = date.year == _selectedDate.year &&
                date.month == _selectedDate.month &&
                date.day == _selectedDate.day;
            final isToday = date.year == today.year &&
                date.month == today.month &&
                date.day == today.day;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = date;
                });
                // โหลด API ใหม่ตามวันที่ที่เลือก
                _loadJobOrders(date);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.teal : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? Colors.teal
                        : isToday
                            ? Colors.teal.withOpacity(0.5)
                            : Colors.grey[300]!,
                    width: isSelected || isToday ? 2 : 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      _getDayName(date.weekday),
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.white : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${date.day}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Colors.white
                            : isToday
                                ? Colors.teal
                                : Colors.black87,
                      ),
                    ),
                    Text(
                      '${date.month}/${date.year}',
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected
                            ? Colors.white.withOpacity(0.8)
                            : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส'];
    return days[weekday % 7];
  }

  Widget _buildTimeline() {
    // กรองงานตามวันที่ที่เลือก
    final selectedDateStart =
        DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);

    // รวม routes ทั้งหมดที่ตรงกับวันที่ที่เลือก (แสดงเฉพาะ routes)
    List<TimelineItem> timelineItems = [];

    print('📋 [Timeline] Building timeline with ${_jobs.length} job(s)');
    print(
        '📋 [Timeline] Selected date start: ${selectedDateStart.year}-${selectedDateStart.month.toString().padLeft(2, '0')}-${selectedDateStart.day.toString().padLeft(2, '0')}');
    for (var job in _jobs) {
      print(
          '📋 [Timeline] Processing job ${job.jobNo} with ${job.routes.length} route(s)');
      // เพิ่ม routes เท่านั้น (กรองตามวันที่)
      for (var route in job.routes) {
        if (route.planIn != null) {
          // ใช้ UTC date เพื่อเปรียบเทียบ (planIn จาก backend เป็น UTC)
          final planInUtc = route.planIn!.toUtc();
          final routeDateUtc =
              DateTime.utc(planInUtc.year, planInUtc.month, planInUtc.day);
          // แปลง selectedDateStart เป็น UTC สำหรับเปรียบเทียบ
          final selectedDateStartUtc = DateTime.utc(selectedDateStart.year,
              selectedDateStart.month, selectedDateStart.day);

          print(
              '📋 [Timeline] Route ${route.id}: planIn=${route.planIn} (UTC: ${planInUtc.year}-${planInUtc.month.toString().padLeft(2, '0')}-${planInUtc.day.toString().padLeft(2, '0')}), routeDateUtc=${routeDateUtc.year}-${routeDateUtc.month.toString().padLeft(2, '0')}-${routeDateUtc.day.toString().padLeft(2, '0')}, selectedDateStartUtc=${selectedDateStartUtc.year}-${selectedDateStartUtc.month.toString().padLeft(2, '0')}-${selectedDateStartUtc.day.toString().padLeft(2, '0')}');

          if (routeDateUtc.isAtSameMomentAs(selectedDateStartUtc)) {
            print('📋 [Timeline] ✅ Adding route ${route.id} to timeline');
            timelineItems.add(TimelineItem(
              time: route.planIn!,
              title: route.locationName ?? 'ไม่ระบุสถานที่',
              subtitle: route.locationCode ?? '',
              location: route.locationName ?? '',
              isJob: false,
              job: job,
              route: route,
              isCompleted: route.actualIn != null,
              isActive:
                  job.isAccepted && !job.isCompleted && route.actualIn == null,
            ));
          } else {
            print('📋 [Timeline] ❌ Route ${route.id} date mismatch');
          }
        } else {
          print('📋 [Timeline] Route ${route.id} has no planIn');
        }
      }
    }
    print('📋 [Timeline] Total timeline items: ${timelineItems.length}');

    // เรียงตามเวลา
    timelineItems.sort((a, b) => a.time.compareTo(b.time));

    // สร้าง timeline 24 ชั่วโมง
    final hours = List.generate(24, (index) => index);

    // ตรวจสอบว่าวันที่เลือกเป็นวันนี้หรือไม่
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final isToday = selectedDateStart.isAtSameMomentAs(todayStart);

    // คำนวณตำแหน่งของเวลาปัจจุบันโดยใช้ตำแหน่งจริงของ hour markers
    double? currentTimePosition;
    if (isToday) {
      final currentHour = now.hour;
      final currentMinute = now.minute;

      // หาตำแหน่งจริงของ hour marker ปัจจุบันและ hour marker ถัดไป
      // ใช้ addPostFrameCallback เพื่อให้แน่ใจว่า widgets render เสร็จแล้ว
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _calculateActualPosition(currentHour, currentMinute);
      });

      // ลองหาตำแหน่งจริงทันที (ถ้า GlobalKey พร้อมแล้ว)
      _calculateActualPosition(currentHour, currentMinute);

      // ใช้ค่าจริงถ้ามี หรือใช้ค่าประมาณก่อน
      currentTimePosition = _actualCurrentTimePosition ??
          ((currentHour * 26.0) + 9.0 + (currentMinute / 60.0) * 26.0);
    }

    // สร้าง children สำหรับ Stack
    final stackChildren = <Widget>[
      // เส้นแนวตั้ง (แสดงเสมอ) - ปรับตำแหน่งให้ตรงกับวงกลม
      // ตำแหน่ง: 80 (time width) + 8 (spacing) + 9 (half of circle 18/2) - 1 (half of line width 2/2) = 96
      Positioned(
        left:
            96, // จุดกึ่งกลางของเส้น (96 + 1 = 97) = จุดกึ่งกลางของวงกลม (88 + 9 = 97)
        top: 0,
        bottom: 0,
        child: Container(
          width: 2,
          color: Colors.grey[300],
        ),
      ),
      // Timeline items (24 hours + jobs)
      ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 24 *
              26.0, // ความสูงขั้นต่ำสำหรับ 24 ชั่วโมง (แต่ละชั่วโมง 26px: 18px circle + 8px padding)
        ),
        child: Column(
          key: _timelineColumnKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // แสดง 24 ชั่วโมง
            ...hours.map((hour) {
              // หางานที่ตรงกับชั่วโมงนี้
              final itemsForThisHour = timelineItems.where((item) {
                return item.time.hour == hour &&
                    item.time.year == _selectedDate.year &&
                    item.time.month == _selectedDate.month &&
                    item.time.day == _selectedDate.day;
              }).toList();

              // จัดกลุ่ม items ตามเวลา (ชั่วโมงและนาที)
              final groupedItems = <String, List<TimelineItem>>{};
              for (var item in itemsForThisHour) {
                final timeKey =
                    '${item.time.hour.toString().padLeft(2, '0')}:${item.time.minute.toString().padLeft(2, '0')}';
                if (!groupedItems.containsKey(timeKey)) {
                  groupedItems[timeKey] = [];
                }
                groupedItems[timeKey]!.add(item);
              }

              return Column(
                children: [
                  // Hour marker
                  _buildHourMarker(hour),
                  // Jobs for this hour - จัดกลุ่มตามเวลา
                  if (itemsForThisHour.isNotEmpty)
                    ...groupedItems.entries.expand((group) {
                      final itemsAtSameTime = group.value;
                      final isLastGroup =
                          group == groupedItems.entries.last && hour == 23;

                      // ถ้ามีมากกว่า 1 item ที่เวลาเท่ากัน ให้แสดงเป็น 2 column
                      if (itemsAtSameTime.length > 1) {
                        return [
                          _buildTimelineItemsRow(
                            itemsAtSameTime,
                            isLastGroup,
                            hour < 23,
                          ),
                        ];
                      } else {
                        // ถ้ามีแค่ 1 item ให้แสดงแบบเดิม
                        final item = itemsAtSameTime[0];
                        return [
                          _buildTimelineItem(
                            item,
                            isLastGroup,
                            hour < 23,
                            true,
                          ),
                        ];
                      }
                    }),
                  // Empty space if no jobs and last hour
                  if (itemsForThisHour.isEmpty && hour == 23)
                    const SizedBox(height: 16),
                ],
              );
            }),
          ],
        ),
      ),
    ];

    // เพิ่มเส้นบอกเวลาปัจจุบัน (สีแดง) - อยู่ layer บนสุด (ต้องอยู่ท้ายสุดของ Stack)
    // **หมายเหตุ: เส้นสีแดงนี้แยกจากปุ่มเช็คอินสีแดง (FloatingActionButton) ที่ด้านล่าง**
    if (isToday && currentTimePosition != null) {
      print('🔴 RED LINE: Adding red line to stack');
      print('  Position (top): $currentTimePosition px');
      print(
          '  This should align with hour ${now.hour} marker at ${(now.hour * 26.0) + 9.0} px');
      stackChildren.add(
        Positioned(
          left: 0,
          right: 0,
          top:
              currentTimePosition, // ตำแหน่งเวลาปัจจุบัน (ไม่ต้องลบ 1 เพราะ circle center อยู่ที่ 9px จากด้านบนของ hour marker)
          child: IgnorePointer(
            child: SizedBox(
              height: 30, // กำหนดความสูงให้แน่นอน
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // วงกลมสีแดงที่เส้นแนวตั้ง
                  // ตำแหน่ง: 96 (center of vertical line) - 9 (half of 18px circle) = 87
                  Positioned(
                    left: 96 - 9, // 87px
                    top:
                        0, // จุดกึ่งกลางของ circle อยู่ที่ 9px จากด้านบน (18px / 2)
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  // เส้นแนวนอนสีแดง (เริ่มจากจุดแดง)
                  // ตำแหน่ง: 96 (center of vertical line) + 9 (half of 18px circle) = 105 (ขอบขวาของ circle)
                  // top: 9 - 1 = 8 (จุดกึ่งกลางของ circle - half of line height)
                  Positioned(
                    left: 96 + 9, // 105px (ขอบขวาของ circle)
                    right: 0,
                    top:
                        8, // จุดกึ่งกลางของ circle (9px) - half of line height (1px) = 8px
                    child: Container(
                      height: 2,
                      color: Colors.red,
                    ),
                  ),
                  // ข้อความแสดงเวลาปัจจุบันชิดขวา
                  Positioned(
                    right: 0, // ชิดขวาจอ
                    top: 4, // ใต้เส้นสีแดง
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      print(
          '🔴 RED LINE: NOT adding red line - isToday=$isToday, currentTimePosition=$currentTimePosition');
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      child: Stack(
        key: _timelineStackKey,
        clipBehavior: Clip.none, // อนุญาตให้ widget อยู่นอกขอบเขต
        children: stackChildren,
      ),
    );
  }

  Widget _buildHourMarker(int hour) {
    final hourStr = '${hour.toString().padLeft(2, '0')}:00';

    // สร้าง GlobalKey สำหรับ hour marker นี้ถ้ายังไม่มี
    if (!_hourMarkerKeys.containsKey(hour)) {
      _hourMarkerKeys[hour] = GlobalKey();
    }

    // หาเวลาเช็คอินที่อยู่ในชั่วโมงนี้
    // เปรียบเทียบวันที่โดยใช้ UTC date (เพราะ checkInTime เป็น UTC)
    final selectedDateStart = DateTime.utc(
        _selectedDate.year, _selectedDate.month, _selectedDate.day);

    print(
        '📅 [CheckIn] _buildHourMarker - Hour: $hour, Selected date: ${_selectedDate.toString()}, Selected date UTC: ${selectedDateStart.toString()}');
    print('📅 [CheckIn] Total check-in times: ${_checkInTimes.length}');
    for (var ct in _checkInTimes) {
      print(
          '📅 [CheckIn] - Check-in time: ${ct.toString()} (year: ${ct.year}, month: ${ct.month}, day: ${ct.day}, hour: ${ct.hour})');
    }

    final checkInTimesForThisHour = _checkInTimes.where((checkInTime) {
      // ใช้ UTC date สำหรับเปรียบเทียบ
      final checkInDate =
          DateTime.utc(checkInTime.year, checkInTime.month, checkInTime.day);
      final isSameDate = checkInDate.isAtSameMomentAs(selectedDateStart);
      final isSameHour = checkInTime.hour == hour;

      print(
          '📅 [CheckIn] Comparing - Check-in date UTC: ${checkInDate.toString()}, Selected date UTC: ${selectedDateStart.toString()}, Is same date: $isSameDate, Is same hour: $isSameHour (check-in hour: ${checkInTime.hour}, target hour: $hour)');

      if (isSameDate && isSameHour) {
        print(
            '📅 [CheckIn] ✅ Match found - Hour: $hour, Check-in: ${checkInTime.toString()}');
      }

      return isSameDate && isSameHour;
    }).toList();

    if (checkInTimesForThisHour.isNotEmpty) {
      print(
          '📅 [CheckIn] ✅ Hour $hour has ${checkInTimesForThisHour.length} check-in(s)');
    } else {
      print('📅 [CheckIn] ❌ Hour $hour has 0 check-in(s)');
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        key: _hourMarkerKeys[hour],
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hourStr,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // แสดงเวลาเช็คอิน - อยู่ใกล้เส้นแนวตั้ง (ชิดขวา)
                if (checkInTimesForThisHour.isNotEmpty)
                  ...checkInTimesForThisHour.map((checkInTime) {
                    final timeStr =
                        '${checkInTime.hour.toString().padLeft(2, '0')}:${checkInTime.minute.toString().padLeft(2, '0')}';
                    return Container(
                      margin: const EdgeInsets.only(top: 2.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 3.0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'เช็คอิน',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              timeStr,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.grey[400]!,
                width: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItemsRow(
      List<TimelineItem> items, bool isLast, bool showLineAfter) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time label (ไม่แสดงเวลาใน timeline item เพราะแสดงที่ hour marker แล้ว)
        SizedBox(
          width: 80,
          child: const SizedBox.shrink(),
        ),
        const SizedBox(width: 8),
        // Timeline dot - ใช้เส้นแนวตั้งหลัก ไม่ต้องมีเส้นเชื่อมต่อ
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: items.any((item) => item.isActive)
                ? Colors.teal
                : items.every((item) => item.isCompleted)
                    ? Colors.teal
                    : Colors.white,
            border: Border.all(
              color: items.any((item) => item.isActive) ||
                      items.every((item) => item.isCompleted)
                  ? Colors.teal
                  : Colors.grey[400]!,
              width: 2,
            ),
          ),
          child: items.every((item) => item.isCompleted)
              ? const Icon(
                  Icons.check,
                  size: 12,
                  color: Colors.white,
                )
              : null,
        ),
        const SizedBox(width: 20),
        // Event cards - แสดงเป็น 2 column
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column 1
              Expanded(
                child: _buildTimelineItemCard(items[0]),
              ),
              // Column 2 (ถ้ามี item ที่ 2)
              if (items.length > 1) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTimelineItemCard(items[1]),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItemCard(TimelineItem item) {
    final hour = item.time.hour;
    final minute = item.time.minute;
    final timeStr =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: item.job.isAccepted
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetailScreen(job: item.job),
                ),
              );
            }
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: item.isActive ? Colors.teal[50] : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: item.isActive ? Colors.teal : Colors.grey[300]!,
            width: item.isActive ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title - แถวแรก
            Text(
              item.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: item.isActive ? Colors.teal[900] : Colors.black87,
              ),
            ),
            // Job Order - แถวที่สอง
            if (!item.isJob) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  item.job.jobNo,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    item.location,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  '${item.time.year}-${item.time.month.toString().padLeft(2, '0')}-${item.time.day.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  item.route?.planOut != null
                      ? '${timeStr} - ${item.route!.planOut!.hour.toString().padLeft(2, '0')}:${item.route!.planOut!.minute.toString().padLeft(2, '0')}'
                      : timeStr,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            // แสดง actual_in และ actual_out ถ้ามีข้อมูล
            if (item.route?.actualIn != null ||
                item.route?.actualOut != null ||
                item.route?.actualIn2 != null ||
                item.route?.actualOut2 != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 14,
                    color: Colors.green[600],
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      _formatActualTime(item.route),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            // แสดงสถานะเข้างานและออกงาน
            Builder(
              builder: (context) {
                if (item.route == null) {
                  return const SizedBox.shrink();
                }

                // ใช้สถานะจาก API
                final checkInStatus = item.route?.checkInStatus;
                final checkOutStatus = item.route?.checkOutStatus;

                if (checkInStatus == null && checkOutStatus == null) {
                  return const SizedBox.shrink();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        if (checkInStatus != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: checkInStatus == 'เข้าตามเวลา'
                                  ? Colors.green[100]
                                  : checkInStatus == 'เข้าสาย'
                                      ? Colors.red[100]
                                      : Colors.orange[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: checkInStatus == 'เข้าตามเวลา'
                                    ? Colors.green[300]!
                                    : checkInStatus == 'เข้าสาย'
                                        ? Colors.red[300]!
                                        : Colors.orange[300]!,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              checkInStatus,
                              style: TextStyle(
                                fontSize: 10,
                                color: checkInStatus == 'เข้าตามเวลา'
                                    ? Colors.green[700]
                                    : checkInStatus == 'เข้าสาย'
                                        ? Colors.red[700]
                                        : Colors.orange[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        if (checkOutStatus != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: checkOutStatus == 'ออกตามเวลา'
                                  ? Colors.green[100]
                                  : Colors.orange[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: checkOutStatus == 'ออกตามเวลา'
                                    ? Colors.green[300]!
                                    : Colors.orange[300]!,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              checkOutStatus,
                              style: TextStyle(
                                fontSize: 10,
                                color: checkOutStatus == 'ออกตามเวลา'
                                    ? Colors.green[700]
                                    : Colors.orange[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatActualTime(JobRoute? route) {
    if (route == null) return '';

    final actualInStr = route.actualIn != null
        ? '${route.actualIn!.hour.toString().padLeft(2, '0')}:${route.actualIn!.minute.toString().padLeft(2, '0')}'
        : null;
    final actualOutStr = route.actualOut != null
        ? '${route.actualOut!.hour.toString().padLeft(2, '0')}:${route.actualOut!.minute.toString().padLeft(2, '0')}'
        : null;

    if (actualInStr != null && actualOutStr != null) {
      return 'เข้า: $actualInStr ออก: $actualOutStr';
    } else if (actualInStr != null) {
      return 'เข้า: $actualInStr';
    } else if (actualOutStr != null) {
      return 'ออก: $actualOutStr';
    }
    return '';
  }

  Widget _buildTimelineItem(
      TimelineItem item, bool isLast, bool showLineAfter, bool isFirstInHour) {
    final hour = item.time.hour;
    final minute = item.time.minute;
    final timeStr =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Time label (ไม่แสดงเวลาใน timeline item เพราะแสดงที่ hour marker แล้ว)
        SizedBox(
          width: 80,
          child: const SizedBox.shrink(),
        ),
        const SizedBox(width: 8),
        // Timeline dot - ใช้เส้นแนวตั้งหลัก ไม่ต้องมีเส้นเชื่อมต่อ
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: item.isActive
                ? Colors.teal
                : item.isCompleted
                    ? Colors.teal
                    : Colors.white,
            border: Border.all(
              color: item.isActive || item.isCompleted
                  ? Colors.teal
                  : Colors.grey[400]!,
              width: 2,
            ),
          ),
          child: item.isCompleted
              ? const Icon(
                  Icons.check,
                  size: 12,
                  color: Colors.white,
                )
              : null,
        ),
        const SizedBox(width: 20),
        // Event card
        Expanded(
          child: GestureDetector(
            onTap: item.job.isAccepted
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JobDetailScreen(job: item.job),
                      ),
                    );
                  }
                : null,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: item.isActive ? Colors.teal[50] : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: item.isActive ? Colors.teal : Colors.grey[300]!,
                  width: item.isActive ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title - แถวแรก
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: item.isActive ? Colors.teal[900] : Colors.black87,
                    ),
                  ),
                  // Job Order - แถวที่สอง
                  if (!item.isJob) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item.job.jobNo,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.location,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${item.time.year}-${item.time.month.toString().padLeft(2, '0')}-${item.time.day.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Time range
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.isJob && item.job.planOut != null
                            ? '${timeStr} - ${item.job.planOut!.hour.toString().padLeft(2, '0')}:${item.job.planOut!.minute.toString().padLeft(2, '0')}'
                            : item.route?.planOut != null
                                ? '${timeStr} - ${item.route!.planOut!.hour.toString().padLeft(2, '0')}:${item.route!.planOut!.minute.toString().padLeft(2, '0')}'
                                : timeStr,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  // แสดง actual_in และ actual_out ถ้ามีข้อมูล
                  if (item.route?.actualIn != null ||
                      item.route?.actualOut != null ||
                      item.route?.actualIn2 != null ||
                      item.route?.actualOut2 != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: Colors.green[600],
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _formatActualTime(item.route),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  // แสดงสถานะเข้างานและออกงาน
                  if (item.route != null)
                    Builder(
                      builder: (context) {
                        // ใช้สถานะจาก API
                        final checkInStatus = item.route?.checkInStatus;
                        final checkOutStatus = item.route?.checkOutStatus;

                        if (checkInStatus == null && checkOutStatus == null) {
                          return const SizedBox.shrink();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                if (checkInStatus != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: checkInStatus == 'เข้าตามเวลา'
                                          ? Colors.green[100]
                                          : checkInStatus == 'เข้าสาย'
                                              ? Colors.red[100]
                                              : Colors.orange[100],
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: checkInStatus == 'เข้าตามเวลา'
                                            ? Colors.green[300]!
                                            : checkInStatus == 'เข้าสาย'
                                                ? Colors.red[300]!
                                                : Colors.orange[300]!,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      checkInStatus,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: checkInStatus == 'เข้าตามเวลา'
                                            ? Colors.green[700]
                                            : checkInStatus == 'เข้าสาย'
                                                ? Colors.red[700]
                                                : Colors.orange[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                if (checkOutStatus != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: checkOutStatus == 'ออกตามเวลา'
                                          ? Colors.green[100]
                                          : Colors.orange[100],
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: checkOutStatus == 'ออกตามเวลา'
                                            ? Colors.green[300]!
                                            : Colors.orange[300]!,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      checkOutStatus,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: checkOutStatus == 'ออกตามเวลา'
                                            ? Colors.green[700]
                                            : Colors.orange[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  // Action button
                  if (item.job.isPending && item.isJob) ...[
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => _acceptJob(item.job.jobId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        minimumSize: const Size(0, 32),
                      ),
                      child: const Text('กดเพื่อรับงาน'),
                    ),
                  ] else if (item.job.isAccepted && item.isJob) ...[
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                JobDetailScreen(job: item.job),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        minimumSize: const Size(0, 32),
                      ),
                      child: const Text('เช็คอิน'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
