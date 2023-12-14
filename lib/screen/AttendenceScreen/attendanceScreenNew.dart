import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/profile/NotificationScreen.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/widget/attendancescreen/attendancestatus.dart';
import 'package:cnattendance/widget/attendancescreen/attendancetoggle.dart';
import 'package:cnattendance/widget/attendancescreen/reportlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../provider/attendancereportprovider.dart';

class AttendanceNew extends StatefulWidget {
  const AttendanceNew({super.key});

  @override
  State<AttendanceNew> createState() => _AttendanceNewState();
}

class _AttendanceNewState extends State<AttendanceNew> {
  bool initial = true;

  @override
  void didChangeDependencies() {
    if (initial) {
      loadAttendanceReport();
      initial = false;
    }
    super.didChangeDependencies();
  }

  Future<String> loadAttendanceReport() async {
    try {
      await Provider.of<AttendanceReportProvider>(context, listen: false).getAttendanceReport();
      return 'loaded';
    } catch (e) {
      return 'loaded';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: InkWell(
              onTap: () {
                pushNewScreen(context, screen: const NotificationScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
              },
              child: SvgPicture.asset(Assets.notification),
            ),
          ),
        ],
        title: Text(
          'Attendance'.tr,
          style: Styles.styleHeader,
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return loadAttendanceReport();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8, right: 20),
                    child: Row(
                      children: [
                        Text(
                          'Todays_Attendance'.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const AttendanceStatus(),
                  const AttendanceToggle(),
                  const ReportListView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
