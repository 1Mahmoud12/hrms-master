import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/provider/dashboardprovider.dart';
import 'package:cnattendance/provider/prefprovider.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/locationstatus.dart';
import 'package:cnattendance/widget/headerprofile.dart';
import 'package:cnattendance/widget/homescreen/checkattendance.dart';
import 'package:cnattendance/widget/homescreen/overviewdashboard.dart';
import 'package:cnattendance/widget/homescreen/weeklyreportchart.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/data/model/login_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    //loadDashboard();
    locationStatus();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    loadDashboard();
    super.initState();
  }

  void locationStatus() async {
    try {
      final position = await LocationStatus().determinePosition();

      if (!mounted) {
        return;
      }
      final location = Provider.of<DashboardProvider>(context, listen: false).locationStatus;

      location.update('latitude', (value) => position.latitude);
      location.update('longitude', (value) => position.longitude);
    } catch (e) {
      debugPrint(e.toString());
      showToast(e.toString());
    }
  }

  Future<String> loadDashboard() async {
    final fcm = await FirebaseMessaging.instance.getToken();
    debugPrint(fcm.toString());
    try {
      await Provider.of<DashboardProvider>(context, listen: false).getDashboard();

      final user = userCache!;

      Provider.of<CustomerProvider>(context, listen: false)
          .saveBasicUser(User(id: user.id, name: user.name, roleId: user.roleId, email: user.email, username: user.username, avatar: user.avatar));

      return 'loaded';
    } catch (e) {
      debugPrint('Load Error $e');
      return 'loaded';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: Colors.blueGrey,
          edgeOffset: 50,
          onRefresh: () {
            return loadDashboard();
          },
          child: const SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  HeaderProfile(),
                  CheckAttendance(),
                  OverviewDashboard(),
                  WeeklyReportChart(),
                  //80.ESH(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
