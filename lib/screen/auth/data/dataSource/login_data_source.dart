import 'dart:convert';
import 'dart:io';

import 'package:cnattendance/core/services/api/remote/errors/failures.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/auth/data/model/login_model.dart';
import 'package:cnattendance/utils/deviceuuid.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginDataSource {
  static Future<Either<Failure, LoginModel>> login(
    String username,
    String password,
  ) async {
    final uri = Uri.parse(EndPoints.loginUrl);
    debugPrint(EndPoints.loginUrl);

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
    };

    try {
      // debugPrint('working');
      // var fcm = await FirebaseMessaging.instance.getToken();

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
      final responseData = json.decode(response.body);
      debugPrint(responseData.toString());
      if (responseData['status'] == false) throw responseData['message'];
      final responseJson = LoginModel.fromJson(responseData);
      print(responseJson.data?.user!.toJson());
      await Preferences.setSaved(
        value: jsonEncode(responseJson.data?.user!.toJson()),
        key: userCacheKey,
      );
      userCache = responseJson.data!.user;

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
