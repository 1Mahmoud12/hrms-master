import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/connect.dart';
import 'package:cnattendance/data/source/network/model/changepassword/ChangePasswordResponse.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:flutter/material.dart';

class ChangePasswordRepository{
  Future<ChangePasswordResponse> changePassword(
      String old, String newPassword, String confirm,) async {
    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final body = {
      'current_password': old,
      'new_password': newPassword,
      'confirm_password': confirm,
    };

    try {
      final response = await Connect().postResponse(Constant.CHANGE_PASSWORD_API, headers, body);
      debugPrint(response.body);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = ChangePasswordResponse.fromJson(responseData);

        return jsonResponse;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }
}