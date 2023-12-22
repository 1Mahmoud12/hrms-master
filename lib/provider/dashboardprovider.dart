import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/attendancestatus/AttendanceStatusResponse.dart';
import 'package:cnattendance/data/source/network/model/dashboard/Dashboardresponse.dart';
import 'package:cnattendance/data/source/network/model/dashboard/EmployeeTodayAttendance.dart';
import 'package:cnattendance/data/source/network/model/dashboard/Overview.dart';
import 'package:cnattendance/data/source/network/model/logout/Logoutresponse.dart';
import 'package:cnattendance/screen/auth/view/presentation/login_screen.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/locationstatus.dart';
import 'package:cnattendance/utils/wifiinfo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DashboardProvider with ChangeNotifier {
  final Map<String, String> _overviewList = {
    'present': '0',
    'holiday': '0',
    'leave': '0',
    'request': '0',
    'total_project': '0',
    'total_task': '0',
  };

  final Map<String, double> locationStatus = {
    'latitude': 0.0,
    'longitude': 0.0,
  };

  Map<String, String> get overviewList {
    return _overviewList;
  }

  final Map<String, dynamic> _attendanceList = {'check-in': '-', 'check-out': '-', 'production_hour': '0 hr 0 min', 'production-time': 0.0};

  Map<String, dynamic> get attendanceList {
    return _attendanceList;
  }

  final List<int> _weeklyReport = [];

  List<int> get weeklyReport {
    return _weeklyReport;
  }

  List<BarChartGroupData> barchartValue = [];

  List<BarChartGroupData> rawBarGroups = [];
  List<BarChartGroupData> showingBarGroups = [];

  void buildgraph() {
    const int daysInWeek = 7;
    for (int i = 0; i < daysInWeek; i++) {
      barchartValue.add(makeGroupData(i, 0));
    }

    rawBarGroups.addAll(barchartValue);
    showingBarGroups.addAll(rawBarGroups);
  }

  Future<Dashboardresponse> getDashboard() async {
    final uri = Uri.parse(EndPoints.DASHBOARD_URL);

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final fcm = await FirebaseMessaging.instance.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
      'fcm_token': fcm ?? '',
    };

    try {
      final response = await http.get(uri, headers: headers);

      debugPrint(response.body);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final dashboardResponse = Dashboardresponse.fromJson(responseData);
        debugPrint(dashboardResponse.toString());

        updateAttendanceStatus(dashboardResponse.data.employeeTodayAttendance);
        updateOverView(dashboardResponse.data.overview);

        makeWeeklyReport(dashboardResponse.data.employeeWeeklyReport);

        final DateTime startTime = DateFormat('hh:mm a').parse(dashboardResponse.data.officeTime.startTime);
        final DateTime endTime = DateFormat('hh:mm a').parse(dashboardResponse.data.officeTime.endTime);

        await AwesomeNotifications().cancelAllSchedules();
        for (final shift in dashboardResponse.data.shift_dates) {
          scheduleNewNotification(shift, 'Please check in on time ⏱️⌛️', startTime.hour, startTime.minute);
          scheduleNewNotification(shift, 'Almost done with your shift 😄⌛️ Remember to checkout ⏱️', endTime.hour, endTime.minute);
        }

        return dashboardResponse;
      } else {
        // EasyLoading.show(status: 'Please Wait...', maskType: EasyLoadingMaskType.black);
        logout();
        debugPrint('false_status');
        final errorMessage = responseData['message'];
        //EasyLoading.dismiss();

        throw errorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Logoutresponse> logout() async {
    final uri = Uri.parse(EndPoints.LOGOUT_URL);

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
      final response = await http.get(uri, headers: headers);
      debugPrint(response.body);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 401) {
        final jsonResponse = Logoutresponse.fromJson(responseData);

        preferences.clearPrefs();
        Get.to(const LoginScreen());
        // Get.to(HomeDashboardScreen());
        return jsonResponse;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }

  void makeWeeklyReport(List<dynamic> employeeWeeklyReport) {
    _weeklyReport.clear();
    for (final item in employeeWeeklyReport) {
      if (item != null) {
        final int hr = (item['productive_time_in_min'] / 60).toInt();
        if (hr > EndPoints.TOTAL_WORKING_HOUR) {
          _weeklyReport.add(EndPoints.TOTAL_WORKING_HOUR);
        } else {
          _weeklyReport.add(hr);
        }
      } else {
        _weeklyReport.add(0);
      }
    }

    barchartValue.clear();
    rawBarGroups.clear();
    showingBarGroups.clear();
    for (int i = 0; i < _weeklyReport.length; i++) {
      barchartValue.add(makeGroupData(i, _weeklyReport[i].toDouble()));
    }

    rawBarGroups.addAll(barchartValue);
    showingBarGroups.addAll(rawBarGroups);

    notifyListeners();
  }

  void updateAttendanceStatus(EmployeeTodayAttendance employeeTodayAttendance) {
    _attendanceList.update('production-time', (value) => calculateProdHour(employeeTodayAttendance.productionTime));
    _attendanceList.update('check-out', (value) => employeeTodayAttendance.checkOutAt);
    _attendanceList.update('production_hour', (value) => calculateHourText(employeeTodayAttendance.productionTime));
    _attendanceList.update('check-in', (value) => employeeTodayAttendance.checkInAt);

    notifyListeners();
  }

  void updateOverView(Overview overview) {
    _overviewList.update('present', (value) => overview.presentDays.toString());
    _overviewList.update('holiday', (value) => overview.totalHolidays.toString());
    _overviewList.update('leave', (value) => overview.totalLeaveTaken.toString());
    _overviewList.update('request', (value) => overview.totalPendingLeaves.toString());
    _overviewList.update('total_project', (value) => overview.total_assigned_projects.toString());
    _overviewList.update('total_task', (value) => overview.total_pending_tasks.toString());

    notifyListeners();
  }

  double calculateProdHour(int value) {
    final double hour = value / 60;
    final double hr = hour / EndPoints.TOTAL_WORKING_HOUR;

    return hr > 1 ? 1 : hr;
  }

  String calculateHourText(int value) {
    final double second = value * 60.toDouble();
    final double min = second / 60;
    final int minGone = (min % 60).toInt();
    final int hour = min ~/ 60;

    debugPrint('$hour hr $minGone min');
    return '$hour hr $minGone min';
  }

  Future<bool> getCheckInStatus() async {
    try {
      final position = await LocationStatus().determinePosition();

      locationStatus.update('latitude', (value) => position.latitude);
      locationStatus.update('longitude', (value) => position.longitude);

      if (locationStatus['latitude'] != 0.0 && locationStatus['longitude'] != 0.0) {
        return true;
      } else {
        Future.error('Location is not detected. Please check if location is enabled and try again.');
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<AttendanceStatusResponse> checkInAttendance() async {
    final uri = Uri.parse(EndPoints.CHECK_IN_URL);

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
      final response = await http.post(
        uri,
        headers: headers,
        body: {
          'router_bssid': await WifiInfo().info.getWifiBSSID() ?? '',
          'check_in_latitude': locationStatus['latitude'].toString(),
          'check_in_longitude': locationStatus['longitude'].toString(),
        },
      );
      debugPrint(locationStatus['latitude'].toString());
      debugPrint(locationStatus['longitude'].toString());
      debugPrint(await WifiInfo().wifiBSSID() ?? '');
      debugPrint(response.body);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final attendanceResponse = AttendanceStatusResponse.fromJson(responseData);
        debugPrint(attendanceResponse.toString());

        updateAttendanceStatus(
          EmployeeTodayAttendance(
            checkInAt: attendanceResponse.data.checkInAt,
            checkOutAt: attendanceResponse.data.checkOutAt,
            productionTime: attendanceResponse.data.productiveTimeInMin,
          ),
        );

        return attendanceResponse;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      debugPrint(locationStatus['latitude'].toString());
      debugPrint(locationStatus['longitude'].toString());
      debugPrint(await WifiInfo().wifiBSSID() ?? '');
      rethrow;
    }
  }

  Future<void> scheduleNewNotification(String date, String message, int hour, int minute) async {
    final convertedDate = DateFormat('yyyy-MM-dd').parse(date);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(1000000),
        // -1 is replaced by a random number
        channelKey: 'digital_hr_channel',
        title: 'Hello There',
        body: message,
        payload: {'notificationId': '1234567890'},
      ),
      actionButtons: [
        NotificationActionButton(key: 'REDIRECT', label: 'Open'),
        NotificationActionButton(key: 'DISMISS', label: 'Dismiss', isDangerousOption: true),
      ],
      schedule: NotificationCalendar.fromDate(date: DateTime(convertedDate.year, convertedDate.month, convertedDate.day, hour, minute - 15)),
    );
  }

  Future<AttendanceStatusResponse> checkOutAttendance() async {
    final uri = Uri.parse(EndPoints.CHECK_OUT_URL);

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
      final response = await http.post(
        uri,
        headers: headers,
        body: {
          'router_bssid': await WifiInfo().wifiBSSID() ?? '',
          'check_out_latitude': locationStatus['latitude'].toString(),
          'check_out_longitude': locationStatus['longitude'].toString(),
        },
      );
      debugPrint(response.body);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final attendanceResponse = AttendanceStatusResponse.fromJson(responseData);

        updateAttendanceStatus(
          EmployeeTodayAttendance(
            checkInAt: attendanceResponse.data.checkInAt,
            checkOutAt: attendanceResponse.data.checkOutAt,
            productionTime: attendanceResponse.data.productiveTimeInMin,
          ),
        );

        return attendanceResponse;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }

  final Color leftBarColor = const Color(0xffFFFFFF);

  final double width = 15;

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: leftBarColor,
          width: width,
        ),
      ],
    );
  }
}
