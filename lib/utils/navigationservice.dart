import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void showSnackBar(String title, String desc) {
    try {
      InAppNotification.show(
        child: Card(
          margin: const EdgeInsets.all(15),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.notifications),
            ),
            iconColor: const Color(0xff011754),
            textColor: const Color(0xff011754),
            minVerticalPadding: 10,
            minLeadingWidth: 0,
            tileColor: Colors.white,
            title: Text(title),
            subtitle: Text(
              desc,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        context: NavigationService.navigatorKey.currentState!.context,
      );
    } catch (e) {
      print(e);
    }
  }
}
