class AttendanceStatus {
  AttendanceStatus({
    required this.checkInAt,
    required this.checkOutAt,
    required this.productiveTimeInMin,
  });

  factory AttendanceStatus.fromJson(dynamic json) {
    return AttendanceStatus(
        checkInAt: json['check_in_at'] ?? '-', checkOutAt: json['check_out_at'] ?? '-', productiveTimeInMin: json['productive_time_in_min'] ?? 0,);
  }

  String checkInAt;
  String checkOutAt;
  int productiveTimeInMin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['check_in_at'] = checkInAt;
    map['check_out_at'] = checkOutAt;
    map['productive_time_in_min'] = productiveTimeInMin;
    return map;
  }
}
