class Yard {
  final int id;
  final String name;
  final String? title;
  final String? address;
  final double? lat;
  final double? long;
  final int? radius;

  Yard({
    required this.id,
    required this.name,
    this.title,
    this.address,
    this.lat,
    this.long,
    this.radius,
  });

  factory Yard.fromJson(Map<String, dynamic> json) {
    return Yard(
      id: json['id'] as int,
      name: json['name'] as String,
      title: json['title'] as String?,
      address: json['address'] as String?,
      lat: json['lat'] != null ? (json['lat'] as num).toDouble() : null,
      long: json['long'] != null ? (json['long'] as num).toDouble() : null,
      radius: json['radius'] as int?,
    );
  }
}

class CheckIn {
  final int id;
  final int userId;
  final int yardId;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final String? inTime; // เวลาที่กำหนดให้เข้างาน ณ เวลาที่เช็คอิน (HH:MM:SS)
  final String? outTime; // เวลาที่กำหนดให้ออกงาน ณ เวลาที่เช็คเอาท์ (HH:MM:SS)
  final double? userLat;
  final double? userLong;
  final double? yardLat;
  final double? yardLong;
  final double? distance;

  CheckIn({
    required this.id,
    required this.userId,
    required this.yardId,
    this.checkInTime,
    this.checkOutTime,
    this.inTime,
    this.outTime,
    this.userLat,
    this.userLong,
    this.yardLat,
    this.yardLong,
    this.distance,
  });

  factory CheckIn.fromJson(Map<String, dynamic> json) {
    return CheckIn(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      yardId: json['yard_id'] as int,
      checkInTime: json['check_in_time'] != null
          ? DateTime.parse(json['check_in_time'] as String)
          : null,
      checkOutTime: json['check_out_time'] != null
          ? DateTime.parse(json['check_out_time'] as String)
          : null,
      inTime: json['in_time'] as String?,
      outTime: json['out_time'] as String?,
      userLat: json['user_lat'] != null
          ? (json['user_lat'] as num).toDouble()
          : null,
      userLong: json['user_long'] != null
          ? (json['user_long'] as num).toDouble()
          : null,
      yardLat: json['yard_lat'] != null
          ? (json['yard_lat'] as num).toDouble()
          : null,
      yardLong: json['yard_long'] != null
          ? (json['yard_long'] as num).toDouble()
          : null,
      distance: json['distance'] != null
          ? (json['distance'] as num).toDouble()
          : null,
    );
  }
}

class CheckInJob {
  final int id;
  final int userId;
  final DateTime? checkInTime;
  final double? userLat;
  final double? userLong;
  final double? mileage;

  CheckInJob({
    required this.id,
    required this.userId,
    this.checkInTime,
    this.userLat,
    this.userLong,
    this.mileage,
  });

  factory CheckInJob.fromJson(Map<String, dynamic> json) {
    return CheckInJob(
      id: json['id'] as int,
      userId: json['userId'] as int,
      checkInTime: json['checkInTime'] != null
          ? DateTime.parse(json['checkInTime'] as String)
          : null,
      userLat: json['userLat'] != null
          ? (json['userLat'] as num).toDouble()
          : null,
      userLong: json['userLong'] != null
          ? (json['userLong'] as num).toDouble()
          : null,
      mileage: json['mileage'] != null
          ? (json['mileage'] as num).toDouble()
          : null,
    );
  }
}

