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

