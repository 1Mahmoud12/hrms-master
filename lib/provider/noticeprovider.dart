import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/notice/NoticeDomain.dart';
import 'package:cnattendance/data/source/network/model/notice/NoticeResponse.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:cnattendance/model/notification.dart' as Not;
import 'package:intl/intl.dart';

class NoticeProvider with ChangeNotifier {
  static int per_page = 10;
  int page = 1;

  final List<Not.Notification> _notificationList = [];

  List<Not.Notification> get notificationList {
    return [..._notificationList];
  }

  Future<NoticeResponse> getNotice() async {
    final uri = Uri.parse(EndPoints.NOTICE_URL).replace(
      queryParameters: {
        'page': page.toString(),
        'per_page': per_page.toString(),
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
      debugPrint(response.body);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final jsonResponse = NoticeResponse.fromJson(responseData);

        makeNotificationList(jsonResponse.data);
        return jsonResponse;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }

  void makeNotificationList(List<NoticeDomain> data) {
    if (page == 1) {
      _notificationList.clear();
    }

    if (data.isNotEmpty) {
      for (final item in data) {
        final DateTime tempDate = DateFormat('yyyy-MM-dd').parse(item.noticePublishedDate);
        _notificationList.add(
          Not.Notification(
            id: item.id,
            title: item.noticeTitle,
            description: item.description,
            month: DateFormat('MMM').format(tempDate),
            day: tempDate.day,
            date: tempDate,
          ),
        );
      }

      page += page;
    }

    notifyListeners();
  }
}
