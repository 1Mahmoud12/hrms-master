import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/my_app.dart';
import 'package:cnattendance/utils/bloc_observe.dart';
import 'package:cnattendance/utils/navigationservice.dart';
import 'package:cnattendance/utils/notification_utility.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:in_app_notification/in_app_notification.dart';

import 'core/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: AppColors.scaffoldBackGround, // Change this to your desired color
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark),
  );*/
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCvg-9ixi6qW3GVEa5e4T6owkIlQ0bPKIo',
      appId: '1:10784846687:android:0399a73ffa4a398d9e3cea',
      messagingSenderId: '10784846687',
      projectId: 'rakelvator',
      storageBucket: 'rakelvator.appspot.com',
    ),
  );

  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  // Step required to send ios push notification
  final NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint('User granted permission');
  } else {
    debugPrint('User declined or has not accepted permission');
  }
  fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
  await Preferences.init();
  genderUser = Preferences.getSaved(key: 'genderUser') ?? '';
  userCache = await preferencesConstants.getUser();
  print('User Cache ====>> ${userCache?.toJson()}');
  await NotificationUtility.initializeAwesomeNotification();

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      // AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });

  FirebaseMessaging.onMessage.listen((event) {
    FlutterRingtonePlayer.play(
      fromAsset: 'assets/sound/beep.mp3',
    );
    try {
      InAppNotification.show(
        child: Card(
          margin: const EdgeInsets.all(15),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            leading: const SizedBox(height: double.infinity, child: Icon(Icons.notifications)),
            iconColor: const Color(0xff011754),
            textColor: const Color(0xff011754),
            minVerticalPadding: 10,
            minLeadingWidth: 0,
            tileColor: Colors.white,
            title: Text(
              event.notification!.title!,
            ),
            subtitle: Text(
              event.notification!.body!,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        context: NavigationService.navigatorKey.currentState!.context,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    debugPrint('Message clicked!');
  });

  final ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  Bloc.observer = MyBlocObserver();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
  configLoading();
}

Future<void> _messageHandler(RemoteMessage message) async {
  FlutterRingtonePlayer.play(
    fromAsset: 'assets/sound/beep.mp3',
  );
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 50.0
    ..radius = 0.0
    ..progressColor = Colors.blue
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.blue
    ..textColor = Colors.black
    ..maskType = EasyLoadingMaskType.none
    ..userInteractions = false
    ..dismissOnTap = false;
}
