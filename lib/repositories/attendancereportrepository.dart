import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/connect.dart';
import 'package:cnattendance/data/source/network/model/attendancereport/AttendanceReportResponse.dart';
import 'package:cnattendance/utils/endpoints.dart';

class AttendanceReportRepository {
  Future<AttendanceReportResponse> getAttendanceReport(
    int selectedMonth,
  ) async {
    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await Connect().getResponse(
        '${EndPoints.ATTENDANCE_REPORT_URL}?month=${selectedMonth + 1}',
        headers,
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        print(responseData);

        final responseJson = AttendanceReportResponse.fromJson(responseData);

        return responseJson;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      rethrow;
    }
  }
}
