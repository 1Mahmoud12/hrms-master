import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/logout/Logoutresponse.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MoreScreenProvider with ChangeNotifier {
  Future<bool> deactivateUser({required String password}) async {
    try {
      final Preferences preferences = Preferences();
      final String token = await preferences.getToken();

      final Map<String, String> headers = {
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };
      final uri = Uri.parse(Constant.DEACTIVATE_URL);
      final response = await http.post(
        uri,
        headers: headers,
        body: {
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        final responsedata = jsonDecode(response.body);
        debugPrint(responsedata);
        preferences.clearPrefs();
        return true;
      }
      return false;
    } catch (error) {
      debugPrint('Not cat de active user');
    }
    return false;
  }

  Future<Logoutresponse> logout() async {
    final uri = Uri.parse(Constant.LOGOUT_URL);

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(uri, headers: headers);
      debugPrint(response.body);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 401) {
        final jsonResponse = Logoutresponse.fromJson(responseData);

        preferences.clearPrefs();
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
