import 'package:flutter/material.dart';

class EmployeeAttendanceReport with ChangeNotifier {
  int id;
  String attendanceDate;
  String weekDay;
  String checkIn;
  String checkOut;

  EmployeeAttendanceReport({
    required this.id,
    required this.attendanceDate,
    required this.weekDay,
    required this.checkIn,
    required this.checkOut,
  });
}
