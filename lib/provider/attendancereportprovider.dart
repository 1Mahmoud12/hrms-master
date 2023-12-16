import 'package:cnattendance/data/source/network/model/attendancereport/EmployeeAttendance.dart';
import 'package:cnattendance/data/source/network/model/attendancereport/EmployeeTodayAttendance.dart';
import 'package:cnattendance/model/employeeattendancereport.dart';
import 'package:cnattendance/model/month.dart';
import 'package:cnattendance/repositories/attendancereportrepository.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceReportProvider with ChangeNotifier {
  final List<EmployeeAttendanceReport> _attendanceReport = [];
  AttendanceReportRepository repository = AttendanceReportRepository();

  final Map<String, dynamic> _todayReport = {
    'check_in_at': '-',
    'check_out_at': '-',
    'production_hour': '0 hr 0 min',
    'production_percent': 0.0,
  };

  final List<Month> month = [
    Month(0, 'January'),
    Month(1, 'February'),
    Month(2, 'March'),
    Month(3, 'April'),
    Month(4, 'May'),
    Month(5, 'June'),
    Month(6, 'July'),
    Month(7, 'August'),
    Month(8, 'September'),
    Month(9, 'October'),
    Month(10, 'November'),
    Month(11, 'December'),
  ];

  bool isLoading = false;

  int selectedMonth = DateTime.now().month - 1;

  List<EmployeeAttendanceReport> get attendanceReport {
    return [..._attendanceReport];
  }

  Map<String, dynamic> get todayReport {
    return _todayReport;
  }

  Future<void> getAttendanceReport() async {
    isLoading = true;
    try {
      final responseJson = await repository.getAttendanceReport(selectedMonth);
      isLoading = false;
      makeTodayReport(responseJson.data.employeeTodayAttendance);
      makeAttendanceReport(responseJson.data.employeeAttendance);
      getProdHour(responseJson.data.employeeTodayAttendance.checkInAt, responseJson.data.employeeTodayAttendance.checkOutAt);
    } catch (error) {
      isLoading = false;
      rethrow;
    }
  }

  void makeAttendanceReport(List<EmployeeAttendance> employeeAttendance) {
    _attendanceReport.clear();
    for (final item in employeeAttendance) {
      _attendanceReport.add(
        EmployeeAttendanceReport(
          id: item.id,
          attendanceDate: item.attendanceDate,
          weekDay: item.weekDay,
          checkIn: item.checkIn,
          checkOut: item.checkOut,
        ),
      );
    }

    notifyListeners();
  }

  void makeTodayReport(EmployeeTodayAttendance employeeTodayAttendance) {
    _todayReport['check_in_at'] = employeeTodayAttendance.checkInAt;
    _todayReport['check_out_at'] = employeeTodayAttendance.checkOutAt;

    notifyListeners();
  }

  void getProdHour(String start, String end) {
    if (start == '-') {
      return;
    }

    if (start != '-' && end != '-') {
      final DateTime current = DateTime.now();
      DateTime startDate = DateFormat('hh:mm a').parse(start);
      DateTime endDate = DateFormat('hh:mm a').parse(end);

      startDate = DateTime(current.year, current.month, current.day, startDate.hour, startDate.minute, startDate.second);

      endDate = DateTime(current.year, current.month, current.day, endDate.hour, endDate.minute, endDate.second);

      final value = endDate.difference(startDate).inMinutes;
      final double second = value * 60.toDouble();
      final double min = second / 60;
      final int minGone = (min % 60).toInt();
      final int hour = min ~/ 60;
      _todayReport['production_hour'] = '$hour hr $minGone min';

      final double hours = value / 60;
      final hrPercent = hours / EndPoints.TOTAL_WORKING_HOUR;
      _todayReport['production_percent'] = hrPercent > 1.0 ? 1.0 : hrPercent;

      notifyListeners();
      return;
    }

    if (start != '-' && end == '-') {
      final DateTime now = DateTime.now();
      final String formattedDate = DateFormat('hh:mm a').format(now);

      final DateTime endDate = DateFormat('hh:mm a').parse(formattedDate);
      final DateTime startDate = DateFormat('hh:mm a').parse(start);

      final value = endDate.difference(startDate).inMinutes;

      final int minGone = value % 60;
      final int hour = value ~/ 60;
      _todayReport['production_hour'] = '$hour hr $minGone min';

      final double hours = value / 60;
      final hrPercent = hours / EndPoints.TOTAL_WORKING_HOUR;
      _todayReport['production_percent'] = hrPercent > 1.0 ? 1.0 : hrPercent;

      notifyListeners();
      return;
    }
  }
}
