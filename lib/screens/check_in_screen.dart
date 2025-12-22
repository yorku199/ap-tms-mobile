import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/check_in_service.dart';
import '../models/check_in_model.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final CheckInService _checkInService = CheckInService();
  Yard? _selectedYard;
  Position? _currentPosition;
  double? _distance;
  bool _isWithinRadius = false;
  bool _isLoading = false;
  String? _errorMessage;
  CheckIn? _latestCheckIn;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // ดึงข้อมูล yards
      final yards = await _checkInService.getUserYards();
      
      // ดึงข้อมูล check in ล่าสุด
      final latestCheckIn = await _checkInService.getLatestCheckIn();

      setState(() {
        if (yards.isNotEmpty) {
          _selectedYard = yards.first;
        }
        _latestCheckIn = latestCheckIn;
        _isLoading = false;
      });

      // ดึงตำแหน่งปัจจุบัน
      await _getCurrentLocation();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _errorMessage = null;
    });

    try {
      // ตรวจสอบ permission
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = 'กรุณาเปิดใช้งาน Location Service';
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = 'กรุณาอนุญาตให้เข้าถึงตำแหน่ง';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage = 'กรุณาเปิดการอนุญาตตำแหน่งใน Settings';
        });
        return;
      }

      // ดึงตำแหน่งปัจจุบัน
      Position position;
      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 15), // เพิ่ม timeout เป็น 15 วินาที
        );
      } catch (timeoutError) {
        // ถ้า timeout ให้ลองใช้ lastKnownPosition สำหรับ emulator
        Position? lastKnown = await Geolocator.getLastKnownPosition();
        if (lastKnown != null) {
          position = lastKnown;
        } else {
          // ถ้ายังไม่ได้ ให้แสดง error message พร้อมคำแนะนำ
          setState(() {
            _errorMessage = 'ไม่สามารถดึงตำแหน่งได้ กรุณาตั้งค่า location ใน emulator:\n'
                '1. เปิด Extended Controls (ปุ่ม ...)\n'
                '2. ไปที่แท็บ Location\n'
                '3. ตั้งค่า Latitude: 13.7563, Longitude: 100.5018\n'
                '4. คลิก Send\n\n'
                'หรือใช้คำสั่ง: adb emu geo fix 100.5018 13.7563';
          });
          return;
        }
      }

      setState(() {
        _currentPosition = position;
        _errorMessage = null; // ล้าง error message เมื่อสำเร็จ
      });

      // คำนวณระยะทางถ้ามี yard ที่เลือก
      if (_selectedYard != null && _selectedYard!.lat != null && _selectedYard!.long != null) {
        _calculateDistance();
      }
    } catch (e) {
      setState(() {
        String errorMsg = e.toString();
        if (errorMsg.contains('TimeoutException')) {
          _errorMessage = 'ไม่สามารถดึงตำแหน่งได้ (Timeout)\n\n'
              'กรุณาตั้งค่า location ใน emulator:\n'
              '1. เปิด Extended Controls (ปุ่ม ...)\n'
              '2. ไปที่แท็บ Location\n'
              '3. ตั้งค่า Latitude: 13.7563, Longitude: 100.5018\n'
              '4. คลิก Send\n\n'
              'หรือใช้คำสั่ง: adb emu geo fix 100.5018 13.7563';
        } else {
          _errorMessage = 'ไม่สามารถดึงตำแหน่งได้: ${e.toString()}';
        }
      });
    }
  }

  void _calculateDistance() {
    if (_currentPosition == null ||
        _selectedYard == null ||
        _selectedYard!.lat == null ||
        _selectedYard!.long == null) {
      return;
    }

    double distance = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      _selectedYard!.lat!,
      _selectedYard!.long!,
    );

    bool isWithinRadius = false;
    if (_selectedYard!.radius != null) {
      isWithinRadius = distance <= _selectedYard!.radius!;
    }

    setState(() {
      _distance = distance;
      _isWithinRadius = isWithinRadius;
    });
  }

  Future<void> _handleCheckIn() async {
    if (_selectedYard == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('กรุณาเลือก yard'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ไม่สามารถดึงตำแหน่งได้'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedYard!.lat == null || _selectedYard!.long == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yard นี้ยังไม่มีข้อมูลตำแหน่ง'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // ตรวจสอบว่าอยู่ในรัศมีหรือไม่
    if (!_isWithinRadius) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('คุณอยู่นอกรัศมีที่กำหนด (${_distance?.toStringAsFixed(2) ?? 'N/A'} เมตร) กรุณาเข้าใกล้ yard ก่อนเช็คอิน'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 4),
        ),
      );
      return;
    }

    // แสดง dialog ยืนยัน
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ยืนยันการเช็คอิน'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Yard: ${_selectedYard!.name}'),
            const SizedBox(height: 8),
            Text('ระยะทาง: ${_distance?.toStringAsFixed(2) ?? 'N/A'} เมตร'),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 20),
                SizedBox(width: 4),
                Text(
                  'อยู่ในรัศมี',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('ยืนยัน'),
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

    try {
      final result = await _checkInService.checkIn(
        yardId: _selectedYard!.id,
        userLat: _currentPosition!.latitude,
        userLong: _currentPosition!.longitude,
        yardLat: _selectedYard!.lat!,
        yardLong: _selectedYard!.long!,
        distance: _distance ?? 0,
      );

      if (mounted) {
        Navigator.of(context).pop(); // ปิด loading dialog

        if (result['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'เช็คอินสำเร็จ'),
              backgroundColor: Colors.green,
            ),
          );
          // รีโหลดข้อมูล
          await _loadData();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'ไม่สามารถเช็คอินได้'),
              backgroundColor: Colors.red,
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
          ),
        );
      }
    }
  }

  Future<void> _handleCheckOut() async {
    if (_latestCheckIn == null) {
      return;
    }

    // แสดง dialog ยืนยัน
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ยืนยันการเช็คเอาท์'),
        content: const Text('คุณต้องการเช็คเอาท์หรือไม่?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('ยกเลิก'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('ยืนยัน'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // ดึงตำแหน่งปัจจุบันก่อน check out
    await _getCurrentLocation();

    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ไม่สามารถดึงตำแหน่งได้'),
          backgroundColor: Colors.red,
        ),
      );
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
      final result = await _checkInService.checkOut(
        userLat: _currentPosition!.latitude,
        userLong: _currentPosition!.longitude,
      );

      if (mounted) {
        Navigator.of(context).pop(); // ปิด loading dialog

        if (result['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'เช็คเอาท์สำเร็จ'),
              backgroundColor: Colors.green,
            ),
          );
          // รีโหลดข้อมูล
          await _loadData();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'ไม่สามารถเช็คเอาท์ได้'),
              backgroundColor: Colors.red,
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
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เช็คอิน'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // เพิ่ม background color
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : (_selectedYard == null || _selectedYard!.lat == null || _selectedYard!.long == null)
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_errorMessage != null)
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.red),
                            ),
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        const Text(
                          'ไม่พบข้อมูลสถานที่บริษัท',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              : Stack(
                  children: [
                    // Google Map แสดงเต็มจอ
                    SizedBox.expand(
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            _selectedYard!.lat!,
                            _selectedYard!.long!,
                          ),
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('yard_location'),
                            position: LatLng(
                              _selectedYard!.lat!,
                              _selectedYard!.long!,
                            ),
                            infoWindow: InfoWindow(
                              title: _selectedYard!.name,
                              snippet: _selectedYard!.address ?? '',
                            ),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed,
                            ),
                          ),
                          if (_currentPosition != null)
                            Marker(
                              markerId: const MarkerId('current_location'),
                              position: LatLng(
                                _currentPosition!.latitude,
                                _currentPosition!.longitude,
                              ),
                              infoWindow: const InfoWindow(
                                title: 'ตำแหน่งปัจจุบัน',
                              ),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueBlue,
                              ),
                            ),
                        },
                        circles: _selectedYard!.radius != null
                            ? {
                                Circle(
                                  circleId: const CircleId('yard_radius'),
                                  center: LatLng(
                                    _selectedYard!.lat!,
                                    _selectedYard!.long!,
                                  ),
                                  radius: _selectedYard!.radius!.toDouble(),
                                  fillColor: Colors.blue.withOpacity(0.2),
                                  strokeColor: Colors.blue,
                                  strokeWidth: 2,
                                ),
                              }
                            : {},
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        mapType: MapType.normal,
                        zoomControlsEnabled: false,
                        compassEnabled: true,
                        onMapCreated: (GoogleMapController controller) {
                          _mapController = controller;
                        },
                      ),
                    ),

                    // Panel รายละเอียดบริษัทด้านบน
                    Positioned(
                      top: 16,
                      left: 16,
                      right: 16,
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'สถานที่บริษัท',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              if (_selectedYard != null) ...[
                                // แสดงชื่อ
                                Text(
                                  'ชื่อ: ${_selectedYard!.name}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // แสดง title
                                if (_selectedYard!.title != null && _selectedYard!.title!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      'หัวข้อ: ${_selectedYard!.title}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                // แสดง address
                                if (_selectedYard!.address != null && _selectedYard!.address!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      'ที่อยู่: ${_selectedYard!.address}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                // แสดงระยะทางและสถานะ
                                if (_currentPosition != null && _distance != null) ...[
                                  const SizedBox(height: 8),
                                  const Divider(),
                                  const SizedBox(height: 8),
                                  Text(
                                    'ระยะทาง: ${_distance!.toStringAsFixed(2)} เมตร',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        _isWithinRadius ? Icons.check_circle : Icons.warning,
                                        color: _isWithinRadius ? Colors.green : Colors.orange,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        _isWithinRadius ? 'อยู่ในรัศมี' : 'อยู่นอกรัศมี',
                                        style: TextStyle(
                                          color: _isWithinRadius ? Colors.green : Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ปุ่มเช็คอิน/เช็คเอาท์ด้านล่างสุด
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SafeArea(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Latest check in/out info
                              if (_latestCheckIn != null)
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.blue.shade200),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'เช็คอินล่าสุด',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      if (_latestCheckIn!.checkInTime != null)
                                        Text(
                                          'เวลาเข้า: ${_formatDateTime(_latestCheckIn!.checkInTime!)}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      if (_latestCheckIn!.checkOutTime != null) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          'เวลาออก: ${_formatDateTime(_latestCheckIn!.checkOutTime!)}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),

                              // Check In/Out button
                              // แสดงปุ่มเช็คอินถ้ายังไม่มี check in วันนี้ หรือแสดงปุ่มเช็คเอาท์ถ้ามี check in วันนี้
                              // อนุญาตให้เช็คเอาท์ได้หลายครั้งในวันเดียวกัน
                              if (_latestCheckIn == null || _isNewDay(_latestCheckIn!.checkInTime))
                                ElevatedButton.icon(
                                  onPressed: _handleCheckIn,
                                  icon: const Icon(Icons.login),
                                  label: const Text('เช็คอิน'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    minimumSize: const Size(double.infinity, 50),
                                  ),
                                )
                              else
                                ElevatedButton.icon(
                                  onPressed: _handleCheckOut,
                                  icon: const Icon(Icons.logout),
                                  label: const Text('เช็คเอาท์'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    minimumSize: const Size(double.infinity, 50),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Error message overlay
                    if (_errorMessage != null)
                      Positioned(
                        top: 100,
                        left: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error, color: Colors.red),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, size: 20),
                                onPressed: () {
                                  setState(() {
                                    _errorMessage = null;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  // ตรวจสอบว่าเป็นวันใหม่หรือไม่ (เลยเที่ยงคืน)
  bool _isNewDay(DateTime? checkInTime) {
    if (checkInTime == null) return true;
    
    final now = DateTime.now();
    final checkInDate = DateTime(checkInTime.year, checkInTime.month, checkInTime.day);
    final today = DateTime(now.year, now.month, now.day);
    
    // ถ้า check in time ไม่ใช่วันนี้ แสดงว่าขึ้นวันใหม่แล้ว
    return checkInDate.isBefore(today);
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}

