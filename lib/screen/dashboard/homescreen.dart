import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/data/source/network/model/login/User.dart';
import 'package:cnattendance/provider/dashboardprovider.dart';
import 'package:cnattendance/provider/prefprovider.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/locationstatus.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:cnattendance/widget/headerprofile.dart';
import 'package:cnattendance/widget/homescreen/checkattendance.dart';
import 'package:cnattendance/widget/homescreen/overviewdashboard.dart';
import 'package:cnattendance/widget/homescreen/weeklyreportchart.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      final dashboardResponse = await Provider.of<DashboardProvider>(context, listen: false).getDashboard();

      final user = dashboardResponse.data.user;

      Provider.of<CustomerProvider>(context, listen: false)
          .saveBasicUser(User(id: user.id, name: user.name, roleId: user.roleId, email: user.email, username: user.username, avatar: user.avatar));

      return 'loaded';
    } catch (e) {
      debugPrint(e.toString());
      return 'loaded';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        backgroundColor: Colors.blueGrey,
        edgeOffset: 50,
        onRefresh: () {
          return loadDashboard();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [20.ESH(), const HeaderProfile(), const CheckAttendance(), const OverviewDashboard(), const WeeklyReportChart()],
            ),
          ),
        ),
      ),
    );
  }
}
