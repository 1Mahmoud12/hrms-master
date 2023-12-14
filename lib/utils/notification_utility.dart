import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationUtility {
  static Future<void> initializeAwesomeNotification() async {
    await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/app_icon',
      [
        NotificationChannel(
          //channelGroupKey: 'Bayat_Ts_group',
          channelKey: 'Rak_Ts_channel',
          channelName: 'Rak notifications',
          channelDescription: 'Rak Alert',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
        ), NotificationChannel(
        //channelGroupKey: 'Bayat_Ts_group',
        channelKey: 'digital_hr_channel',
        channelName: 'Rak notifications',
        channelDescription: 'Rak Alert',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
      ],
      // Channel groups are only visual and are not required
      //  channelGroups: [NotificationChannelGroup(channelGroupName: 'HR group', channelGroupKey: 'Bayat_Ts_group')],
      // debug: true,
    );
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction,) async {
    _onTapNotificationScreenNavigateCallback(
      (receivedAction.payload ?? {})['type'] ?? '',
      Map.from(receivedAction.payload ?? {}),
    );
  }

  static void _onTapNotificationScreenNavigateCallback(String notificationType,
      Map<String, dynamic> data,) {
    /*if (notificationType == generalNotificationType) {
      UiUtils.rootNavigatorKey.currentState?.pushNamed(Routes.noticeBoard);
    } else if (notificationType == assignmentlNotificationType) {
      HomeScreen.homeScreenKey.currentState?.navigateToAssignmentContainer();
    }*/
  }
}
