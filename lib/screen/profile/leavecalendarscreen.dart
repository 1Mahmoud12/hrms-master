import 'dart:io';

import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/leavecalendarprovider.dart';
import 'package:cnattendance/widget/leavecalendar/LeaveCalendarView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LeaveCalendarScreen extends StatelessWidget {
  const LeaveCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LeaveCalendarProvider(),
      child: const LeaveCalendar(),
    );
  }
}

class LeaveCalendar extends StatefulWidget {
  const LeaveCalendar({super.key});

  @override
  State<StatefulWidget> createState() => LeaveCalendarState();
}

class LeaveCalendarState extends State<LeaveCalendar> {
  bool initial = true;

  @override
  void didChangeDependencies() {
    if (initial) {
      getLeaves();
      getLeaveByDate();
      initial = false;
    }
    super.didChangeDependencies();
  }

  void getLeaves() async {
    await Provider.of<LeaveCalendarProvider>(context).getLeaves();
  }

  void getLeaveByDate() async {
    final inputDate = DateTime.now();
    final outputFormat = DateFormat('yyyy-MM-dd');
    final outputDate = outputFormat.format(inputDate);
    await Provider.of<LeaveCalendarProvider>(context).getLeavesByDay(outputDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Platform.isAndroid
                ? const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )
                : const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),),
        title: Text(
          'Leave_Calendar'.tr,
          style: Styles.styleHeader,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // backgroundColor: Color(0xffcfcdcb),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0).w,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaveCalendarView(),
              // Container(
              //     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              //     child: Text(
              //       'Leave List',
              //       style: TextStyle(color: Colors.white, fontSize: 18),
              //     )),
              // LeaveListView(),
            ],
          ),
        ),
      ),
    );
  }
}
