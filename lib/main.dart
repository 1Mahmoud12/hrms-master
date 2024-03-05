import 'dart:convert';
import 'dart:io';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/firebase_obtion.dart';
import 'package:cnattendance/my_app.dart';
import 'package:cnattendance/screen/auth/data/model/login_model.dart';
import 'package:cnattendance/utils/bloc_observe.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'core/theme/color_constraint.dart';
import 'core/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: AppColors.scaffoldBackGround, // Change this to your desired color
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark),
  );
  await initializeFirebaseApp();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  // Step required to send ios push notification

  fcmToken = await FirebaseMessaging.instance.getToken() ?? '';

  final ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  Bloc.observer = MyBlocObserver();

  // Caching
  await Preferences.init();
  genderUser = await Preferences.getSaved(key: 'genderUser') ?? '';
  userCache = User.fromJson(jsonDecode(await Preferences.getSaved(key: userCacheKey) ?? '{}'));
  tokenCache = await Preferences.getSaved(key: tokenCacheKey) ?? '';
  debugPrint('genderUser ====>> $genderUser');
  debugPrint('User Cache ====>> ${userCache?.toJson()}');
  debugPrint('tokenCache ====>> $tokenCache ');

  runApp(
    DevicePreview(
      // ignore: avoid_redundant_argument_values
      enabled: !kReleaseMode,
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
