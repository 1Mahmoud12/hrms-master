import 'package:cnattendance/screen/AttendenceScreen/attendanceScreenNew.dart';
import 'package:cnattendance/screen/MoreScreenEmployee/more_screen_new.dart';
import 'package:cnattendance/screen/dashboard/homescreen.dart';
import 'package:cnattendance/screen/leavescreen/LeaveScreenNew.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Employeeeeeeeeeeeeeeeeee
class BottomMenuController extends GetxController {
  final List<Widget> screens = [
    const HomeScreen(),
    const LeaveScreenNew(),
    const AttendanceNew(),
    const MoreScreenNew(),
  ];

  //   final List<Widget> screens = [
  //   HomeScreen(),
  //   ProjectScreen(),
  //   LeaveScreen(),
  //   AttendanceScreen(),
  //   MoreScreen(),
  // ];
  Widget currentscreen = const HomeScreen();
  int currenttab = 0;

  void updatewidget(Widget widget, int tab) {
    currentscreen = widget;
    currenttab = tab;
    update();
  }
}
