import 'dart:convert';
import 'dart:io';

import 'package:cnattendance/core/services/api/remote/errors/failures.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/login/Loginresponse.dart';
import 'package:cnattendance/utils/deviceuuid.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginDataSource {
  static Future<Either<Failure, LoginResponse>> login(String username, String password) async {
    final uri = Uri.parse(EndPoints.loginUrl);
    debugPrint(EndPoints.loginUrl);

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8'};

    try {
      // debugPrint('working');
      // var fcm = await FirebaseMessaging.instance.getToken();

      debugPrint('fcm $username $password ${await DeviceUUid().getUniqueDeviceId()}');
      final response = await http.post(
        uri,
        headers: headers,
        body: {
          'username': username,
          'password': password,
          'fcm_token': fcmToken,
          'device_type': Platform.isIOS ? 'ios' : 'android',
          'uuid': await DeviceUUid().getUniqueDeviceId(),
        },
      );

      debugPrint('logining = == $response');

      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());

      final responseJson = LoginResponse.fromJson(responseData);
      await preferencesConstants.saveUser(responseJson.data);

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
