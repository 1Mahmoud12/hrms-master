import 'package:cnattendance/provider/attendancereportprovider.dart';
import 'package:cnattendance/widget/headerprofile.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:cnattendance/widget/attendancescreen/attendancestatus.dart';
import 'package:cnattendance/widget/attendancescreen/attendancetoggle.dart';
import 'package:cnattendance/widget/attendancescreen/reportlistview.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<StatefulWidget> createState() => AttendanceScreenState();
}

class AttendanceScreenState extends State<AttendanceScreen> {
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
      await Provider.of<AttendanceReportProvider>(context, listen: false)
          .getAttendanceReport();
      return 'loaded';
    } catch (e) {
      return 'loaded';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: RefreshIndicator(
          onRefresh: () {
            return loadAttendanceReport();
          },
          child: const SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  HeaderProfile(),
                  AttendanceStatus(),
                  AttendanceToggle(),
                  ReportListView(),
                ],
              ),
            ),
          ),
        ),),
      ),
    );
  }
}
