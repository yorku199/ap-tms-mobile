class User {
  final int id;
  final String? username;
  final String? name;
  final String? lastname;
  final String? idCardNo;
  final int? role;
  final String? email;
  final String? contactNumber;
  final String? employeeCode;
  final int? departmentId;
  final int? positionId;
  final String? profileImageUrl;
  final int? yardId;
  final String? inTime; // เวลาที่กำหนดให้เข้างาน (HH:MM:SS)
  final String? outTime; // เวลาที่กำหนดให้ออกงาน (HH:MM:SS)

  User({
    required this.id,
    this.username,
    this.name,
    this.lastname,
    this.idCardNo,
    this.role,
    this.email,
    this.contactNumber,
    this.employeeCode,
    this.departmentId,
    this.positionId,
    this.profileImageUrl,
    this.yardId,
    this.inTime,
    this.outTime,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // รองรับทั้ง Id (uppercase) และ id (lowercase) จาก API
      id: (json['Id'] ?? json['id']) as int,
      username: json['username'] as String?,
      name: json['name'] as String?,
      lastname: json['lastname'] as String?,
      idCardNo: json['id_card_no'] as String?,
      role: json['role'] as int?,
      email: json['email'] as String?,
      contactNumber: json['contactnumber'] as String?,
      employeeCode: json['employee_code'] as String?,
      departmentId: json['department_id'] as int?,
      positionId: json['position_id'] as int?,
      profileImageUrl: json['profile_image_url'] as String?,
      yardId: json['yard_id'] as int?,
      inTime: json['in_time'] as String?,
      outTime: json['out_time'] as String?,
    );
  }

  String get fullName {
    final nameParts = [name, lastname].where((part) => part != null && part.isNotEmpty);
    return nameParts.isNotEmpty ? nameParts.join(' ') : 'ไม่ระบุชื่อ';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'lastname': lastname,
      'id_card_no': idCardNo,
      'role': role,
      'email': email,
      'contactnumber': contactNumber,
      'employee_code': employeeCode,
      'department_id': departmentId,
      'position_id': positionId,
      'profile_image_url': profileImageUrl,
      'yard_id': yardId,
      'in_time': inTime,
      'out_time': outTime,
    };
  }
}

