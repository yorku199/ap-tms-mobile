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
  List<Yard> _allYards = []; // เก็บรายการ yards ทั้งหมด
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
        _allYards = yards;
        // กรองเฉพาะบริษัทที่มี title, lat, long, radius
        final validYards = yards.where((yard) => 
          yard.title != null && 
          yard.title!.isNotEmpty && 
          yard.lat != null && 
          yard.long != null && 
          yard.radius != null
        ).toList();
        
        if (validYards.isNotEmpty) {
          // เลือกบริษัทแรกที่มีข้อมูลครบ หรือบริษัทที่เลือกอยู่แล้ว
          _selectedYard = _selectedYard != null && validYards.any((y) => y.id == _selectedYard!.id)
              ? validYards.firstWhere((y) => y.id == _selectedYard!.id)
              : validYards.first;
        } else if (yards.isNotEmpty) {
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

  // แสดง dialog เลือกบริษัท
  Future<void> _showYardSelectionDialog() async {
    // กรองเฉพาะบริษัทที่มี title, lat, long, radius
    final validYards = _allYards.where((yard) => 
      yard.title != null && 
      yard.title!.isNotEmpty && 
      yard.lat != null && 
      yard.long != null && 
      yard.radius != null
    ).toList();

    if (validYards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ไม่พบบริษัทที่มีข้อมูลครบถ้วน'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final selectedYard = await showDialog<Yard>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('เลือกบริษัท'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: validYards.length,
            itemBuilder: (context, index) {
              final yard = validYards[index];
              final isSelected = _selectedYard?.id == yard.id;
              
              return ListTile(
                title: Text(yard.title ?? yard.name),
                subtitle: yard.address != null && yard.address!.isNotEmpty
                    ? Text(yard.address!)
                    : null,
                leading: Icon(
                  isSelected ? Icons.check_circle : Icons.location_on,
                  color: isSelected ? Colors.green : Colors.grey,
                ),
                selected: isSelected,
                onTap: () {
                  Navigator.of(context).pop(yard);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ยกเลิก'),
          ),
        ],
      ),
    );

    if (selectedYard != null) {
      setState(() {
        _selectedYard = selectedYard;
      });

      // อัปเดต map camera
      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(selectedYard.lat!, selectedYard.long!),
          ),
        );
      }

      // คำนวณระยะทางใหม่
      if (_currentPosition != null) {
        _calculateDistance();
      }
    }
  }

  Future<void> _handleCheckIn() async {
    if (_selectedYard == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('กรุณาเลือกสถานที่บริษัท'),
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
          content: Text('สถานที่บริษัทนี้ยังไม่มีข้อมูลตำแหน่ง'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // ตรวจสอบว่าอยู่ในรัศมีหรือไม่
    if (!_isWithinRadius) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('คุณอยู่นอกรัศมีที่กำหนด (${_distance?.toStringAsFixed(2) ?? 'N/A'} เมตร) กรุณาเข้าใกล้สถานที่บริษัทก่อนเช็คอิน'),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 4),
        ),
      );
      return;
    }

    // แสดง dialog ยืนยัน (แสดงสถานะที่ถูกต้อง)
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ยืนยันการเช็คอิน'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('สถานที่บริษัท: ${_selectedYard!.title ?? _selectedYard!.name}'),
            const SizedBox(height: 8),
            Text('ระยะทาง: ${_distance?.toStringAsFixed(2) ?? 'N/A'} เมตร'),
            const SizedBox(height: 8),
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
            if (!_isWithinRadius) ...[
              const SizedBox(height: 8),
              const Text(
                'กรุณาเข้าใกล้สถานที่บริษัทก่อนเช็คอิน',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('ยกเลิก'),
          ),
          // ปิดการใช้งานปุ่มยืนยันถ้าอยู่นอกรัศมี
          TextButton(
            onPressed: _isWithinRadius ? () => Navigator.of(context).pop(true) : null,
            child: const Text('ยืนยัน'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    // ตรวจสอบรัศมีอีกครั้งก่อนส่งไป API (ป้องกันการเปลี่ยนแปลงตำแหน่งระหว่างที่แสดง dialog)
    // ดึงตำแหน่งปัจจุบันอีกครั้ง
    try {
      final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
      
      // คำนวณระยะทางอีกครั้ง
      if (_selectedYard!.lat != null && _selectedYard!.long != null) {
        final currentDistance = Geolocator.distanceBetween(
          currentPosition.latitude,
          currentPosition.longitude,
          _selectedYard!.lat!,
          _selectedYard!.long!,
        );
        
        bool isWithinRadius = false;
        if (_selectedYard!.radius != null) {
          isWithinRadius = currentDistance <= _selectedYard!.radius!;
        }
        
        if (!isWithinRadius) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('คุณอยู่นอกรัศมีที่กำหนด (${currentDistance.toStringAsFixed(2)} เมตร) กรุณาเข้าใกล้สถานที่บริษัทก่อนเช็คอิน'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 4),
            ),
          );
          return;
        }
        
        // อัปเดตตำแหน่งและระยะทาง
        setState(() {
          _currentPosition = currentPosition;
          _distance = currentDistance;
          _isWithinRadius = isWithinRadius;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ไม่สามารถตรวจสอบตำแหน่งได้: ${e.toString()}'),
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
          // รีโหลดข้อมูล
          await _loadData();
          
          // แสดงเวลาเช็คอินหลังจากทำรายการสำเร็จ
          if (_latestCheckIn != null && _latestCheckIn!.checkInTime != null) {
            final checkInTime = _formatDateTime(_latestCheckIn!.checkInTime!);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(result['message'] ?? 'เช็คอินสำเร็จ'),
                    const SizedBox(height: 4),
                    Text(
                      'เวลาเช็คอิน: $checkInTime',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 4),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result['message'] ?? 'เช็คอินสำเร็จ'),
                backgroundColor: Colors.green,
              ),
            );
          }
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

    // ตรวจสอบว่าอยู่ในรัศมีหรือไม่ (ต้องตรวจสอบก่อนเช็คเอาท์)
    if (_selectedYard != null && _selectedYard!.lat != null && _selectedYard!.long != null && _selectedYard!.radius != null) {
      // คำนวณระยะทางอีกครั้ง
      final currentDistance = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        _selectedYard!.lat!,
        _selectedYard!.long!,
      );
      
      final isWithinRadius = currentDistance <= _selectedYard!.radius!;
      
      if (!isWithinRadius) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('คุณอยู่นอกรัศมีที่กำหนด (${currentDistance.toStringAsFixed(2)} เมตร) กรุณาเข้าใกล้สถานที่บริษัทก่อนเช็คเอาท์'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
        return;
      }
      
      // อัปเดตระยะทาง
      setState(() {
        _distance = currentDistance;
        _isWithinRadius = isWithinRadius;
      });
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
          // รีโหลดข้อมูล
          await _loadData();
          
          // แสดงเวลาเช็คเอาท์หลังจากทำรายการสำเร็จ
          if (_latestCheckIn != null && _latestCheckIn!.checkOutTime != null) {
            final checkOutTime = _formatDateTime(_latestCheckIn!.checkOutTime!);
            final checkInTimeText = _latestCheckIn!.checkInTime != null
                ? _formatDateTime(_latestCheckIn!.checkInTime!)
                : 'N/A';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(result['message'] ?? 'เช็คเอาท์สำเร็จ'),
                    const SizedBox(height: 4),
                    Text(
                      'เวลาเช็คอิน: $checkInTimeText',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'เวลาเช็คเอาท์: $checkOutTime',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 4),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result['message'] ?? 'เช็คเอาท์สำเร็จ'),
                backgroundColor: Colors.green,
              ),
            );
          }
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
                      child: InkWell(
                        onTap: _showYardSelectionDialog,
                        borderRadius: BorderRadius.circular(4),
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'สถานที่บริษัท',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 12),
                              if (_selectedYard != null) ...[
                                // แสดงชื่อ (ใช้ title แทน name)
                                Text(
                                  'ชื่อ: ${_selectedYard!.title ?? _selectedYard!.name}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
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
                              // แสดงช่องเวลาเช็คอินและเวลาเช็คเอาท์ (เฉพาะวันที่ปัจจุบัน)
                              if (_latestCheckIn != null && _isTodayCheckIn(_latestCheckIn!))
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      // ช่องที่ 1: เวลาเช็คอิน
                                      if (_latestCheckIn!.checkInTime != null)
                                        Expanded(
                                          child: Builder(
                                            builder: (context) {
                                              // ใช้ in_time จาก check_in record แทน user.inTime เพื่อความถูกต้อง
                                              final timeDiff = _calculateCheckInTimeDifference(
                                                _latestCheckIn!.checkInTime!,
                                                _latestCheckIn!.inTime,
                                              );

                                              return Container(
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.green[50],
                                                  borderRadius: BorderRadius.circular(6),
                                                  border: Border.all(color: Colors.green.shade200, width: 1),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      'เวลาเช็คอิน',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        const Icon(Icons.login, size: 14, color: Colors.green),
                                                        const SizedBox(width: 4),
                                                        Flexible(
                                                          child: Text(
                                                            _formatDateTime(_latestCheckIn!.checkInTime!),
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.green,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // แสดงว่าสายหรือก่อนเวลา (แสดงเสมอ)
                                                    const SizedBox(height: 6),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: timeDiff != null
                                                            ? (timeDiff.contains('สาย')
                                                                ? Colors.red[100]
                                                                : timeDiff.contains('ก่อนเวลา')
                                                                    ? Colors.blue[100]
                                                                    : Colors.green[100])
                                                            : Colors.grey[200],
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: Text(
                                                        timeDiff ?? 'ไม่มีข้อมูลเวลา',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.bold,
                                                          color: timeDiff != null
                                                              ? (timeDiff.contains('สาย')
                                                                  ? Colors.red[800]
                                                                  : timeDiff.contains('ก่อนเวลา')
                                                                      ? Colors.blue[800]
                                                                      : Colors.green[800])
                                                              : Colors.grey[600],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      // ช่องที่ 2: เวลาเช็คเอาท์
                                      if (_latestCheckIn!.checkOutTime != null) ...[
                                        if (_latestCheckIn!.checkInTime != null)
                                          const SizedBox(width: 8),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.orange[50],
                                              borderRadius: BorderRadius.circular(6),
                                              border: Border.all(color: Colors.orange.shade200, width: 1),
                                            ),
                                            child: Builder(
                                              builder: (context) {
                                                // ใช้ out_time จาก check_out record แทน user.outTime เพื่อความถูกต้อง
                                                final timeDiff = _calculateCheckOutTimeDifference(
                                                  _latestCheckIn!.checkOutTime!,
                                                  _latestCheckIn!.outTime,
                                                );

                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Text(
                                                      'เวลาเช็คเอาท์',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        const Icon(Icons.logout, size: 14, color: Colors.orange),
                                                        const SizedBox(width: 4),
                                                        Flexible(
                                                          child: Text(
                                                            _formatDateTime(_latestCheckIn!.checkOutTime!),
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.orange,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // แสดงว่าออกก่อนเวลาหรือหลังเวลา (แสดงเสมอ)
                                                    const SizedBox(height: 6),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: timeDiff != null
                                                            ? (timeDiff.contains('ก่อนเวลา')
                                                                ? Colors.red[100]
                                                                : timeDiff.contains('หลังเวลา')
                                                                    ? Colors.blue[100]
                                                                    : Colors.green[100])
                                                            : Colors.grey[200],
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: Text(
                                                        timeDiff ?? 'ไม่มีข้อมูลเวลา',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.bold,
                                                          color: timeDiff != null
                                                              ? (timeDiff.contains('ก่อนเวลา')
                                                                  ? Colors.red[800]
                                                                  : timeDiff.contains('หลังเวลา')
                                                                      ? Colors.blue[800]
                                                                      : Colors.green[800])
                                                              : Colors.grey[600],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),

                              // Check In/Out button
                              // ตรวจสอบว่าวันนี้มีการ check in แล้วหรือไม่
                              // ถ้ามี check in ในวันเดียวกัน (ไม่ใช่วันใหม่) ให้แสดงปุ่มเช็คเอาท์ทันที
                              Builder(
                                builder: (context) {
                                  // ตรวจสอบว่าวันนี้มีการ check in แล้วหรือไม่
                                  // ตรวจสอบทันทีเมื่อเปิดหน้า
                                  final bool hasCheckInToday = _latestCheckIn != null && 
                                      _latestCheckIn!.checkInTime != null &&
                                      !_isNewDay(_latestCheckIn!.checkInTime);
                                  
                                  // ถ้ายังไม่มี check in ในวันนี้ หรือเป็นวันใหม่
                                  if (!hasCheckInToday) {
                                    // แสดงปุ่มเช็คอิน
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // แสดงเวลาเช็คอินล่าสุดเหนือปุ่ม (ถ้ามี)
                                        if (_latestCheckIn != null && _latestCheckIn!.checkInTime != null)
                                          Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                            margin: const EdgeInsets.only(bottom: 8),
                                            decoration: BoxDecoration(
                                              color: Colors.green[50],
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(color: Colors.green.shade200),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.access_time, size: 16, color: Colors.green),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'เวลาเช็คอินล่าสุด: ${_formatDateTime(_latestCheckIn!.checkInTime!)}',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
                                        ),
                                      ],
                                    );
                                  } else {
                                    // แสดงปุ่มเช็คเอาท์ - มีการเช็คอินแล้วในวันนี้
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
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
                                    );
                                  }
                                },
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

  // ตรวจสอบว่า check-in เป็นของวันที่ปัจจุบันหรือไม่
  bool _isTodayCheckIn(CheckIn checkIn) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    // ตรวจสอบจาก checkInTime
    if (checkIn.checkInTime != null) {
      final checkInDate = DateTime(
        checkIn.checkInTime!.year,
        checkIn.checkInTime!.month,
        checkIn.checkInTime!.day,
      );
      if (checkInDate.year == today.year &&
          checkInDate.month == today.month &&
          checkInDate.day == today.day) {
        return true;
      }
    }
    
    // ตรวจสอบจาก checkOutTime
    if (checkIn.checkOutTime != null) {
      final checkOutDate = DateTime(
        checkIn.checkOutTime!.year,
        checkIn.checkOutTime!.month,
        checkIn.checkOutTime!.day,
      );
      if (checkOutDate.year == today.year &&
          checkOutDate.month == today.month &&
          checkOutDate.day == today.day) {
        return true;
      }
    }
    
    return false;
  }

  // คำนวณว่าสายหรือก่อนเวลากี่ชั่วโมงกี่นาที (สำหรับเช็คอิน)
  String? _calculateCheckInTimeDifference(DateTime checkInTime, String? inTime) {
    if (inTime == null || inTime.isEmpty) return null;

    try {
      // แปลง inTime (HH:MM:SS) เป็น DateTime สำหรับวันนี้
      final timeParts = inTime.split(':');
      if (timeParts.length < 2) return null;

      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      // ใช้เฉพาะเวลา (ชั่วโมงและนาที) ของ checkInTime เพื่อเปรียบเทียบ
      final checkInHour = checkInTime.hour;
      final checkInMinute = checkInTime.minute;

      // คำนวณความแตกต่างเป็นนาที
      final checkInTotalMinutes = checkInHour * 60 + checkInMinute;
      final scheduledTotalMinutes = hour * 60 + minute;
      final differenceInMinutes = checkInTotalMinutes - scheduledTotalMinutes;

      if (differenceInMinutes > 0) {
        // สาย
        final hours = differenceInMinutes ~/ 60;
        final minutes = differenceInMinutes % 60;
        if (hours > 0) {
          return 'สาย $hours ชม. $minutes นาที';
        } else {
          return 'สาย $minutes นาที';
        }
      } else if (differenceInMinutes < 0) {
        // ก่อนเวลา
        final absMinutes = differenceInMinutes.abs();
        final hours = absMinutes ~/ 60;
        final minutes = absMinutes % 60;
        if (hours > 0) {
          return 'ก่อนเวลา $hours ชม. $minutes นาที';
        } else {
          return 'ก่อนเวลา $minutes นาที';
        }
      } else {
        // ตรงเวลา
        return 'ตรงเวลา';
      }
    } catch (e) {
      return null;
    }
  }

  // คำนวณว่าออกก่อนเวลาหรือหลังเวลากี่ชั่วโมงกี่นาที (สำหรับเช็คเอาท์)
  String? _calculateCheckOutTimeDifference(DateTime checkOutTime, String? outTime) {
    if (outTime == null || outTime.isEmpty) return null;

    try {
      // แปลง outTime (HH:MM:SS) เป็น DateTime สำหรับวันนี้
      final timeParts = outTime.split(':');
      if (timeParts.length < 2) return null;

      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      // ใช้เฉพาะเวลา (ชั่วโมงและนาที) ของ checkOutTime เพื่อเปรียบเทียบ
      final checkOutHour = checkOutTime.hour;
      final checkOutMinute = checkOutTime.minute;

      // คำนวณความแตกต่างเป็นนาที
      final checkOutTotalMinutes = checkOutHour * 60 + checkOutMinute;
      final scheduledTotalMinutes = hour * 60 + minute;
      final differenceInMinutes = checkOutTotalMinutes - scheduledTotalMinutes;

      if (differenceInMinutes > 0) {
        // หลังเวลา
        final hours = differenceInMinutes ~/ 60;
        final minutes = differenceInMinutes % 60;
        if (hours > 0) {
          return 'หลังเวลา $hours ชม. $minutes นาที';
        } else {
          return 'หลังเวลา $minutes นาที';
        }
      } else if (differenceInMinutes < 0) {
        // ก่อนเวลา
        final absMinutes = differenceInMinutes.abs();
        final hours = absMinutes ~/ 60;
        final minutes = absMinutes % 60;
        if (hours > 0) {
          return 'ก่อนเวลา $hours ชม. $minutes นาที';
        } else {
          return 'ก่อนเวลา $minutes นาที';
        }
      } else {
        // ตรงเวลา
        return 'ตรงเวลา';
      }
    } catch (e) {
      return null;
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}

