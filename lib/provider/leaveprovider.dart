import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/leaveissue/IssueLeaveResponse.dart';
import 'package:cnattendance/data/source/network/model/leavetype/LeaveType.dart';
import 'package:cnattendance/data/source/network/model/leavetype/Leavetyperesponse.dart';
import 'package:cnattendance/data/source/network/model/leavetypedetail/leave_type_detail.dart';
import 'package:cnattendance/data/source/network/model/leavetypedetail/leave_type_details_response.dart';
import 'package:cnattendance/model/LeaveDetail.dart';
import 'package:cnattendance/model/leave.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;

class LeaveProvider with ChangeNotifier {
  final List<Leave> _leaveList = [];
  final List<LeaveDetail> _leaveDetailList = [];

  final List<String> leaveReason = [
    'Issue_Leave'.tr,
    'Early_Leave'.tr,
  ];
  int indexReason = 0;

  void toggle(int index) {
    indexReason = indexReason;
    notifyListeners();
  }

  var _selectedMonth = 0;
  var _selectedType = 0;

  int get selectedMonth {
    return _selectedMonth;
  }

  void setMonth(int value) {
    _selectedMonth = value;
    notifyListeners();
  }

  int get selectedType {
    return _selectedType;
  }

  void setType(int value) {
    _selectedType = value;
  }

  List<Leave> get leaveList {
    return [..._leaveList];
  }

  List<LeaveDetail> get leaveDetailList {
    _leaveDetailList.add(
      LeaveDetail(
        id: 1,
        name: 'name',
        leave_from: DateTime.now().toString(),
        leave_to: DateTime.now().toString(),
        requested_date: DateTime.now().toString(),
        authorization: 'authorization',
        status: 'TestRequest',
      ),
    );
    return [..._leaveDetailList];
  }

  Future<Leavetyperesponse> getLeaveType() async {
    final uri = Uri.parse(EndPoints.LEAVE_TYPE_URL);

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final fcm = await FirebaseMessaging.instance.getToken();
    debugPrint(fcm);

    debugPrint('Bearer: $token');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        final responseJson = Leavetyperesponse.fromJson(responseData);
        makeLeaveList(responseJson.data);
        return responseJson;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      rethrow;
    }
  }

  void makeLeaveList(List<LeaveType> leaveList) {
    _leaveList.clear();

    for (final leave in leaveList) {
      _leaveList.add(
        Leave(
          id: int.parse(leave.leaveTypeId),
          name: leave.leaveTypeName,
          allocated: leave.leaveTaken,
          total: int.parse(leave.totalLeaveAllocated),
          status: leave.leaveTypeStatus,
          isEarlyLeave: leave.earlyExit,
        ),
      );
    }

    notifyListeners();
  }

  Future<Leavetypedetailreponse> getLeaveTypeDetail() async {
    final uri = Uri.parse(EndPoints.LEAVE_TYPE_DETAIL_URL).replace(
      queryParameters: {
        'month': _selectedMonth != 0 ? _selectedMonth.toString() : '',
        'leave_type': _selectedType != 0 ? _selectedType.toString() : '',
      },
    );

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        final responseJson = Leavetypedetailreponse.fromJson(responseData);

        makeLeaveTypeList(responseJson.data);

        return responseJson;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      rethrow;
    }
  }

  void makeLeaveTypeList(List<LeaveTypeDetail> leaveList) {
    _leaveDetailList.clear();

    for (final leave in leaveList) {
      _leaveDetailList.add(
        LeaveDetail(
          id: leave.id,
          name: leave.leaveTypeName,
          leave_from: leave.leaveFrom,
          leave_to: leave.leaveTo,
          requested_date: leave.leaveRequestedDate,
          authorization: leave.statusUpdatedBy,
          status: leave.status,
        ),
      );
    }

    notifyListeners();
  }

  Future<IssueLeaveResponse> issueLeave(String from, String to, String reason, int leaveId) async {
    final uri = Uri.parse(EndPoints.ISSUE_LEAVE);

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
      final response = await http.post(
        uri,
        headers: headers,
        body: {
          'leave_from': from,
          'leave_to': to,
          'leave_type_id': leaveId.toString(),
          'reasons': reason,
        },
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        final responseJson = IssueLeaveResponse.fromJson(responseData);

        debugPrint(responseJson.toString());
        return responseJson;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  Future<IssueLeaveResponse> cancelLeave(int leaveId) async {
    final uri = Uri.parse('${EndPoints.CANCEL_LEAVE}/$leaveId');

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
      final response = await http.get(uri, headers: headers);

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        final responseJson = IssueLeaveResponse.fromJson(responseData);

        debugPrint(responseJson.toString());
        return responseJson;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }
}
