import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/connect.dart';
import 'package:cnattendance/data/source/network/model/rules/CompanyRulesReponse.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';

class CompanyRuleRepository {
  Future<CompanyRulesReponse> getContent() async {
    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await Connect().getResponse(EndPoints.RULES_API, headers);
      debugPrint(response.body);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final rulesResponse = CompanyRulesReponse.fromJson(responseData);
        return rulesResponse;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }
}
