class JobOrder {
  final int jobId;
  final String jobNo;
  final String truckNo;
  final String route;
  final DateTime? planIn;
  final DateTime? planOut;
  final DateTime? stampDate;
  final int jobClass;
  final String status;
  final int statusReceive;
  final List<JobRoute> routes;

  JobOrder({
    required this.jobId,
    required this.jobNo,
    required this.truckNo,
    required this.route,
    this.planIn,
    this.planOut,
    this.stampDate,
    this.jobClass = 0,
    required this.status,
    required this.statusReceive,
    required this.routes,
  });

  factory JobOrder.fromJson(Map<String, dynamic> json) {
    return JobOrder(
      jobId: json['job_id'] as int,
      jobNo: json['job_no'] as String? ?? '',
      truckNo: json['truck_no'] as String? ?? 'ไม่ระบุ',
      route: json['route'] as String? ?? 'ไม่ระบุ',
      planIn: json['plan_in'] != null
          ? DateTime.parse(json['plan_in'] as String)
          : null,
      planOut: json['plan_out'] != null
          ? DateTime.parse(json['plan_out'] as String)
          : null,
      stampDate: json['stamp_date'] != null
          ? DateTime.parse(json['stamp_date'] as String)
          : null,
      jobClass: json['job_class'] as int? ?? 0,
      status: json['status'] as String? ?? 'Draft',
      statusReceive: json['status_receive'] as int? ?? 0,
      routes: (json['routes'] as List<dynamic>?)
              ?.map((r) => JobRoute.fromJson(r as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  bool get isPending => statusReceive == 0;
  bool get isAccepted => statusReceive == 1;
  bool get isCompleted => statusReceive == 2;

  String get formattedTime {
    if (planIn == null && planOut == null) {
      return 'ไม่ระบุเวลา';
    }
    final inStr = planIn != null
        ? '${planIn!.year}-${planIn!.month.toString().padLeft(2, '0')}-${planIn!.day.toString().padLeft(2, '0')} ${planIn!.hour.toString().padLeft(2, '0')}:${planIn!.minute.toString().padLeft(2, '0')}'
        : '';
    final outStr = planOut != null
        ? '${planOut!.year}-${planOut!.month.toString().padLeft(2, '0')}-${planOut!.day.toString().padLeft(2, '0')} ${planOut!.hour.toString().padLeft(2, '0')}:${planOut!.minute.toString().padLeft(2, '0')}'
        : '';
    
    if (inStr.isNotEmpty && outStr.isNotEmpty) {
      return '$inStr - $outStr';
    } else if (inStr.isNotEmpty) {
      return inStr;
    } else if (outStr.isNotEmpty) {
      return outStr;
    }
    return 'ไม่ระบุเวลา';
  }
}

class JobRoute {
  final int id;
  final int jobId;
  final int? routeDetailId;
  final DateTime? planIn;
  final DateTime? planOut;
  final DateTime? planIn2;
  final DateTime? planOut2;
  final DateTime? actualIn;
  final DateTime? actualOut;
  final String? locationName;
  final String? locationCode;
  final int? sequence;
  final int? driverId;
  final String? driverName;
  final DateTime? actualIn2;
  final DateTime? actualOut2;
  final String? locationName2;
  final String? locationCode2;

  JobRoute({
    required this.id,
    required this.jobId,
    this.routeDetailId,
    this.planIn,
    this.planOut,
    this.planIn2,
    this.planOut2,
    this.actualIn,
    this.actualOut,
    this.locationName,
    this.locationCode,
    this.sequence,
    this.driverId,
    this.driverName,
    this.actualIn2,
    this.actualOut2,
    this.locationName2,
    this.locationCode2,
  });

  factory JobRoute.fromJson(Map<String, dynamic> json) {
    return JobRoute(
      id: json['id'] as int,
      jobId: json['job_id'] as int,
      routeDetailId: json['route_detail_id'] as int?,
      planIn: json['plan_in'] != null
          ? DateTime.parse(json['plan_in'] as String)
          : null,
      planOut: json['plan_out'] != null
          ? DateTime.parse(json['plan_out'] as String)
          : null,
      planIn2: json['plan_in2'] != null
          ? DateTime.parse(json['plan_in2'] as String)
          : null,
      planOut2: json['plan_out2'] != null
          ? DateTime.parse(json['plan_out2'] as String)
          : null,
      actualIn: json['actual_in'] != null
          ? DateTime.parse(json['actual_in'] as String)
          : null,
      actualOut: json['actual_out'] != null
          ? DateTime.parse(json['actual_out'] as String)
          : null,
      locationName: json['location_name'] as String?,
      locationCode: json['location_code'] as String?,
      sequence: json['sequence'] as int?,
      driverId: json['driver_id'] as int?,
      driverName: json['driver_name'] as String?,
      actualIn2: json['actual_in2'] != null
          ? DateTime.parse(json['actual_in2'] as String)
          : null,
      actualOut2: json['actual_out2'] != null
          ? DateTime.parse(json['actual_out2'] as String)
          : null,
      locationName2: json['location_name2'] as String?,
      locationCode2: json['location_code2'] as String?,
    );
  }
}

class JobOrderSummary {
  final int total;
  final int completed;
  final int accepted;
  final int pending;

  JobOrderSummary({
    required this.total,
    required this.completed,
    required this.accepted,
    required this.pending,
  });

  factory JobOrderSummary.fromJson(Map<String, dynamic> json) {
    return JobOrderSummary(
      total: json['total'] as int? ?? 0,
      completed: json['completed'] as int? ?? 0,
      accepted: json['accepted'] as int? ?? 0,
      pending: json['pending'] as int? ?? 0,
    );
  }
}

