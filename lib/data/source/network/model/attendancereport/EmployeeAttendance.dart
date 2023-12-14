class EmployeeAttendance {
  EmployeeAttendance({
    required this.id,
    required this.attendanceDate,
    required this.weekDay,
    required this.checkIn,
    required this.checkOut,
  });

  factory EmployeeAttendance.fromJson(dynamic json) {
    return EmployeeAttendance(
        id: json['id'],
        attendanceDate: json['attendance_date'] ?? '',
        weekDay: json['week_day'] ?? '',
        checkIn: json['check_in'] ?? '-',
        checkOut: json['check_out'] ?? '-',);
  }

  int id;
  String attendanceDate;
  String weekDay;
  String checkIn;
  String checkOut;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['attendance_date'] = attendanceDate;
    map['week_day'] = weekDay;
    map['check_in'] = checkIn;
    map['check_out'] = checkOut;
    return map;
  }
}
