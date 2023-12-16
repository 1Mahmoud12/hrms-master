import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/leaveissue/IssueLeaveResponse.dart';
import 'package:cnattendance/data/source/network/model/leavetype/LeaveType.dart';
import 'package:cnattendance/data/source/network/model/leavetype/Leavetyperesponse.dart';
import 'package:cnattendance/data/source/network/model/leavetypedetail/leave_type_detail.dart';
import 'package:cnattendance/model/LeaveDetail.dart';
import 'package:cnattendance/model/leave.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;

class RequestProvider with ChangeNotifier {
  final List<Leave> _leaveList = [];
  final List<LeaveDetail> _leaveDetailList = [];
  final List requestList = [];

  var _selectedMonth = 0;
  var _selectedType = 0;

  int get selectedMonth {
    return _selectedMonth;
  }

  void get http {}

  void setMonth(int value) {
    _selectedMonth = value;
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
    return [..._leaveDetailList];
  }

  Future<Leavetyperesponse> getLeaveType() async {
    // var uri = Uri.parse(Constant.USER_REQUEST);

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    print('Bearer: $token');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await https.get(
        Uri.parse(EndPoints.USER_REQUEST),
        headers: headers,
      );
      // final response = await http.get(uri);
      print('aasmosaom mom $response');

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        debugPrint('2022134 $responseData');

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

  Future getRequestDetail() async {
    EasyLoading.show(status: 'Please Wait...', maskType: EasyLoadingMaskType.black);

    final uri = Uri.parse(EndPoints.USER_REQUEST_VIEW);
    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      requestList.clear();
      final response = await https.get(uri, headers: headers);
      final responseData = jsonDecode(response.body);
      if (responseData['status_code'] == 200) {
        for (final req in responseData['data']) {
          requestList.add(req);
        }
        EasyLoading.dismiss();

        // print('----------requestList');
        // print(requestList);
        // final responseJson = Leavetypedetailreponse.fromJson(responseData);
        // makeLeaveTypeList(responseJson.data);
        // return responseJson;
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
    final uri = Uri.parse(EndPoints.USER_REQUEST_STORE);
    EasyLoading.show(status: ' Please Wait..', maskType: EasyLoadingMaskType.black);

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers1 = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
      final response = await https.post(
        uri,
        headers: headers1,
        body: {
          'leave_from': from,
          'leave_to': to,
          'leave_type_id': leaveId.toString(),
          'reasons': reason,
        },
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        final responseJson = IssueLeaveResponse.fromJson(responseData);
        Get.snackbar('Successfull', 'Thank You for Submitted');

        debugPrint(responseJson.toString());
        return responseJson;
      } else {
        EasyLoading.dismiss();

        final errorMessage = responseData['message'];
        Get.snackbar('title', '$errorMessage');
        throw errorMessage;
      }
    } catch (error) {
      Get.snackbar('title', 'Something Went Wrong');
      EasyLoading.dismiss();

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
      final response = await https.get(uri, headers: headers);

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
