import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/meeting/MeetingDomain.dart';
import 'package:cnattendance/data/source/network/model/meeting/MeetingReponse.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MeetingProvider extends ChangeNotifier {
  static int per_page = 10;
  int page = 1;

  final List<MeetingDomain> _meetingList = [];

  List<MeetingDomain> get meetingList {
    return [..._meetingList];
  }

  Future<MeetingReponse> getMeetingList() async {
    final uri = Uri.parse(EndPoints.MEETING_URL).replace(
      queryParameters: {
        'page': page.toString(),
        'per_page': per_page.toString(),
      },
    );

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    print(token);

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

        final responseJson = MeetingReponse.fromJson(responseData);

        makeMeetingList(responseJson.data);
        return responseJson;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (error) {
      rethrow;
    }
  }

  void makeMeetingList(List<MeetingDomain> data) {
    if (page == 1) {
      _meetingList.clear();
    }

    if (data.isNotEmpty) {
      for (final item in data) {
        _meetingList.add(item);
      }

      page += page;
    }

    notifyListeners();
  }
}
