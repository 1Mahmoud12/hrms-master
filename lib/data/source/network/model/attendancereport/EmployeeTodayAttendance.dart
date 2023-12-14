class EmployeeTodayAttendance {
  EmployeeTodayAttendance({
    required this.checkInAt,
    required this.checkOutAt,
  });

  factory EmployeeTodayAttendance.fromJson(dynamic json) {
    return EmployeeTodayAttendance(
      checkInAt: json['check_in_at'] ?? '-',
      checkOutAt: json['check_out_at'] ?? '-',
    );
  }

  String checkInAt;
  String checkOutAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['check_in_at'] = checkInAt;
    map['check_out_at'] = checkOutAt;
    return map;
  }
}
