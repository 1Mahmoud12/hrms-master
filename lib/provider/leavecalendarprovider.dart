import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/employeeleavecalendar/Employeeleavecalendarresponse.dart';
import 'package:cnattendance/data/source/network/model/employeeleavecalendarbyday/EmployeeLeavesByDayResponse.dart';
import 'package:cnattendance/data/source/network/model/employeeleavecalendarbyday/employee_leaves_by_day.dart';
import 'package:cnattendance/model/LeaveByDay.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LeaveCalendarProvider with ChangeNotifier {
  final Map<String, List<dynamic>> _employeeLeaveList = {};

  final List<LeaveByDay> _employeeLeaveByDayList = [];

  Map<String, List<dynamic>> get employeeLeaveList {
    return _employeeLeaveList;
  }

  List<LeaveByDay> get employeeLeaveByDayList {
    return _employeeLeaveByDayList;
  }

  Future<Employeeleavecalendarresponse> getLeaves() async {
    final uri = Uri.parse(EndPoints.LEAVE_CALENDAR_API);

    final Preferences preferences = Preferences();

    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        final responseJson = Employeeleavecalendarresponse.fromJson(responseData);

        _employeeLeaveList.clear();

        for (final item in responseJson.data) {
          final List<int> list = [];
          for (int i = 0; i < item.leaveCount; i++) {
            list.add(i);
          }
          _employeeLeaveList.addAll({item.date: list});
        }

        notifyListeners();

        return responseJson;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<EmployeeLeavesByDayResponse> getLeavesByDay(String value) async {
    final uri = Uri.parse(EndPoints.LEAVE_CALENDAR_BY_DAY_API).replace(queryParameters: {'leave_date': value});

    final Preferences preferences = Preferences();

    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        final responseJson = EmployeeLeavesByDayResponse.fromJson(responseData);

        makeLeaveByDayList(responseJson.data);

        return responseJson;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      rethrow;
    }
  }

  void makeLeaveByDayList(List<EmployeeLeavesByDay> data) {
    _employeeLeaveByDayList.clear();
    for (final item in data) {
      _employeeLeaveByDayList.add(LeaveByDay(id: item.leaveId, name: item.userName, post: item.post, days: item.leaveDays, avatar: item.userAvatar));
    }
    notifyListeners();
  }
}
