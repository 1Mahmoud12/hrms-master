import 'dart:async';

import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/auth/view/presentation/login_screen.dart';
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

class SplashState extends State<SplashScreen> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      const Duration(milliseconds: 1500),
      () async {
        genderUser = Preferences.getSaved(key: 'genderUser') ?? '';
        if (genderUser == '') {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else {
          debugPrint('cvbnjmk,2 $genderUser');
          if (genderUser == RoleId.customer.toString()) {
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
  void dispose() {
    // TODO: implement dispose
    controller.dispose(); // Dispose the AnimationController
    //timer.cancel(); // Cancel the Timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                Assets.appLogo,
                width: context.screenWidth * .6,
                //  height: 220,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
