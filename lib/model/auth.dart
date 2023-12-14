import 'dart:convert';
import 'dart:io';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/login/Loginresponse.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:cnattendance/utils/deviceuuid.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<Loginresponse> login(String username, String password) async {
    final uri = Uri.parse(Constant.LOGIN_URL);
    debugPrint(Constant.LOGIN_URL);

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8'};

    try {
      // debugPrint('working');
      // var fcm = await FirebaseMessaging.instance.getToken();

      final fcm = await FirebaseMessaging.instance.getToken();
      debugPrint('fcm $fcm');
      final response = await http.post(
        uri,
        headers: headers,
        body: {
          'username': username,
          'password': password,
          'fcm_token': 'fcm',
          'device_type': Platform.isIOS ? 'ios' : 'android',
          'uuid': await DeviceUUid().getUniqueDeviceId(),
        },
      );

      debugPrint('logining = == $response');

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        debugPrint(responseData.toString());

        final Preferences preferences = Preferences();
        final responseJson = Loginresponse.fromJson(responseData);
        await preferences.saveUser(responseJson.data);

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
