import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/notification/NotifiactionDomain.dart';
import 'package:cnattendance/data/source/network/model/notification/NotificationResponse.dart';
import 'package:cnattendance/model/notification.dart' as not;
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NotificationProvider with ChangeNotifier {
  static int perPage = 10;
  int page = 1;

  List<String> selectLabel = ['General', 'Leave', 'Request'];
  int indexList = 0;

  void toggle(int index) {
    indexList = index;
    notifyListeners();
  }

  final List<not.Notification> _notificationList = [];

  List<not.Notification> get notificationList {
    return [..._notificationList];
  }

  Future<NotificationResponse> getNotification() async {
    final uri = Uri.parse(EndPoints.NOTIFICATION_URL).replace(
      queryParameters: {
        'page': page.toString(),
        'per_page': perPage.toString(),
      },
    );

    final Preferences preferences = Preferences();
    final String token = preferences.getToken();

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
        final jsonResponse = NotificationResponse.fromJson(responseData);

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

  void makeNotificationList(List<NotifiactionDomain> data) {
    if (page == 1) {
      _notificationList.clear();
    }

    if (data.isNotEmpty) {
      for (final item in data) {
        final DateTime tempDate = DateFormat('yyyy-MM-dd').parse(item.notificationPublishedDate);
        _notificationList.add(
          not.Notification(
            id: item.id,
            title: item.notificationTitle,
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
