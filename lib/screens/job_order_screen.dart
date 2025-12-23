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

  @override
  void initState() {
    super.initState();
    _loadJobOrders();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

      // Scroll ไปที่เวลาปัจจุบันหลังจากโหลดข้อมูลเสร็จ
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCurrentTime();
      });
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
      final currentHour = now.hour;
      final currentMinute = now.minute;

      // คำนวณตำแหน่งโดยประมาณ
      // แต่ละ hour marker มี padding bottom 8px + circle 24px = 32px
      // แต่ละชั่วโมงประมาณ 100 pixels รวม spacing
      final estimatedPosition =
          currentHour * 100.0 + (currentMinute / 60.0) * 100.0;

      // เพิ่ม offset สำหรับ sticky header (ประมาณ 200 pixels)
      final scrollPosition = estimatedPosition + 200;

      // รอให้ layout เสร็จก่อน scroll
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            scrollPosition.clamp(
                0.0, _scrollController.position.maxScrollExtent),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
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
              : CustomScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    // Header Section (Sticky)
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
                                padding:
                                    const EdgeInsets.fromLTRB(16, 24, 16, 12),
                                child: Row(
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
                              ),
                              // Date Picker
                              _buildDatePicker(),
                              // Divider
                              Container(
                                height: 1,
                                color: Colors.grey[300],
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Job Timeline (Scrollable)
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 8),
                      sliver: SliverToBoxAdapter(
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

    for (var job in _jobs) {
      // เพิ่ม routes เท่านั้น (กรองตามวันที่)
      for (var route in job.routes) {
        if (route.planIn != null) {
          final routeDate = DateTime(
              route.planIn!.year, route.planIn!.month, route.planIn!.day);
          if (routeDate.isAtSameMomentAs(selectedDateStart)) {
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
          }
        }
      }
    }

    // เรียงตามเวลา
    timelineItems.sort((a, b) => a.time.compareTo(b.time));

    // สร้าง timeline 24 ชั่วโมง
    final hours = List.generate(24, (index) => index);

    // ตรวจสอบว่าวันที่เลือกเป็นวันนี้หรือไม่
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final isToday = selectedDateStart.isAtSameMomentAs(todayStart);

    // คำนวณตำแหน่งของเวลาปัจจุบัน
    // hour marker มี: Text (fontSize 16, ~22px) + Padding bottom (8px) + Circle (24px) = ~54px
    // แต่ละชั่วโมงรวม spacing ประมาณ 60-70px
    // ใช้ 70px ต่อชั่วโมงเพื่อความแม่นยำ
    double? currentTimePosition;
    if (isToday) {
      final currentHour = now.hour;
      final currentMinute = now.minute;
      // คำนวณตำแหน่ง: (ชั่วโมง * 70) + (นาที / 60 * 70)
      // แต่ละชั่วโมง = 70 pixels (hour marker + spacing)
      currentTimePosition = currentHour * 70.0 + (currentMinute / 60.0) * 70.0;

      // Debug: print เพื่อตรวจสอบ
      print(
          '🔴 RED LINE DEBUG: isToday=$isToday, currentTimePosition=$currentTimePosition, hour=$currentHour, minute=$currentMinute, selectedDate=${_selectedDate.toString().substring(0, 10)}, todayStart=${todayStart.toString().substring(0, 10)}');
    } else {
      print(
          '🔴 RED LINE DEBUG: isToday=$isToday, selectedDate=${_selectedDate.toString().substring(0, 10)}, todayStart=${todayStart.toString().substring(0, 10)}');
    }

    // สร้าง children สำหรับ Stack
    final stackChildren = <Widget>[
      // เส้นแนวตั้ง (แสดงเสมอ) - ปรับตำแหน่งให้ตรงกับวงกลม (80 + 8 + 12 = 100)
      Positioned(
        left:
            99, // 80 (time width) + 8 (spacing) + 12 (half of circle 24/2) - 1 (half of line width 2/2)
        top: 0,
        bottom: 0,
        child: Container(
          width: 2,
          color: Colors.grey[300],
        ),
      ),
      // Timeline items (24 hours + jobs)
      Column(
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
          // แสดงข้อความถ้าไม่มีงาน
          if (timelineItems.isEmpty)
            Padding(
              padding:
                  const EdgeInsets.only(left: 80.0, top: 32.0, bottom: 32.0),
              child: Text(
                'ไม่มีงานในวันนี้',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
        ],
      ),
    ];

    // เพิ่มเส้นบอกเวลาปัจจุบัน (สีแดง) - อยู่ layer บนสุด (ต้องอยู่ท้ายสุดของ Stack)
    // **หมายเหตุ: เส้นสีแดงนี้แยกจากปุ่มเช็คอินสีแดง (FloatingActionButton) ที่ด้านล่าง**
    if (isToday && currentTimePosition != null) {
      print(
          '🔴 RED LINE: Adding red line to stack at position $currentTimePosition');
      stackChildren.add(
        Positioned(
          left: 0,
          right: 0,
          top: currentTimePosition - 1, // ตำแหน่งเวลาปัจจุบัน
          child: IgnorePointer(
            child: SizedBox(
              height: 30, // กำหนดความสูงให้แน่นอน
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // วงกลมสีแดงที่เส้นแนวตั้ง
                  Positioned(
                    left:
                        99 - 9, // 99 (center of line) - 9 (half of 18px circle)
                    top:
                        -9, // -9 (half of 18px circle) เพื่อให้จุดอยู่ตรงกลางเส้น
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
                  Positioned(
                    left: 99 + 9, // เริ่มจากขอบขวาของจุดแดง (99 + 9)
                    right: 0,
                    top: -1, // -1 เพื่อให้เส้นอยู่ตรงกลาง (height 2 / 2 = 1)
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
        clipBehavior: Clip.none, // อนุญาตให้ widget อยู่นอกขอบเขต
        children: stackChildren,
      ),
    );
  }

  Widget _buildHourMarker(int hour) {
    final hourStr = '${hour.toString().padLeft(2, '0')}:00';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              hourStr,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 24,
            height: 24,
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
        // Timeline dot and line
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
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
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
            if (!isLast && showLineAfter)
              Container(
                width: 2,
                height: 80,
                color: Colors.grey[300],
                margin: const EdgeInsets.only(top: 4),
              ),
          ],
        ),
        const SizedBox(width: 12),
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
          ],
        ),
      ),
    );
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
        // Timeline dot and line
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
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
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
            if (!isLast || showLineAfter)
              Container(
                width: 2,
                height: 80,
                color: Colors.grey[300],
                margin: const EdgeInsets.only(top: 4),
              ),
          ],
        ),
        const SizedBox(width: 12),
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
