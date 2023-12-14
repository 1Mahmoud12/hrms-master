import 'dart:async';

import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/auth/login_screen.dart';
import 'package:cnattendance/screen/dashboard/bottommenu/bottommenu.dart';
import 'package:cnattendance/screen/employer/ProjectsScreen/home_dashboard_screen.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(milliseconds: 1500),
      () async {
        final Preferences preferences = Preferences();
        if (await preferences.getToken() == '') {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else {
          final _userName = await preferences.getUser();
          debugPrint('cvbnjmk,2 ${_userName.roleId}');
          if (_userName.roleId == '4') {
            Navigator.pushReplacementNamed(context, HomeDashboardScreen.routeName);
          } else {
            Get.offAll(MenuScreen());
          }
          // Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.scaffoldBackGround),
      child: Center(
        child: Image.asset(
          Assets.appLogo,
          //color: AppColors.primaryColor,
          width: context.screenWidth * .6,
          //  height: 220,
        ),
      ),
    );
  }
}
