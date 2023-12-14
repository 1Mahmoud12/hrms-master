import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/provider/dashboardprovider.dart';
import 'package:cnattendance/provider/prefprovider.dart';
import 'package:cnattendance/utils/authservice.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/widget/attendance_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckAttendance extends StatefulWidget {
  const CheckAttendance({super.key});

  @override
  State<StatefulWidget> createState() => CheckAttendanceState();
}

class CheckAttendanceState extends State<CheckAttendance> {
  @override
  Widget build(BuildContext context) {
    final attendanceList = Provider.of<DashboardProvider>(context).attendanceList;
    final pref = Provider.of<CustomerProvider>(context);

    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('EEEE , MMMM d , yyyy').format(now);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*DigitalClock(
            is24HourTimeFormat: false,
            areaDecoration: BoxDecoration(color: Colors.transparent),
            // hourMinuteDigitDecoration: BoxDecoration(color: Colors.transparent),
            secondDigitDecoration: BoxDecoration(color: Colors.transparent),
            digitAnimationStyle: Curves.easeOutExpo,
            hourMinuteDigitTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 50,
            ),
            secondDigitTextStyle: TextStyle(
              color: Colors.white,
            ),
            amPmDigitTextStyle: TextStyle(
              color: Colors.white,
            ),
          ),*/
          /*SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
            formattedDate,
            style: TextStyle(color: AppColors.textColor, fontSize: context.screenWidth * .05),
          )),*/
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(90)),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.1475, 0.6484, 0.8575],
                      colors: [Colors.white, Color.fromRGBO(255, 255, 255, 0.80), Color.fromRGBO(214, 212, 222, 0.67)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(20, 9, 69, 0.15),
                        offset: Offset(0, 50),
                        blurRadius: 100,
                      ),
                    ],
                    backgroundBlendMode: BlendMode.luminosity,
                  ),
                  padding: const EdgeInsets.all(20),
                  // color: attendanceList['check-in'] != "-" &&
                  //         attendanceList['check-out'] == "-"
                  //     ? HexColor("#e82e5f").withOpacity(.5)
                  //     : HexColor("#3b98cc").withOpacity(.5),
                  child: IconButton(
                    iconSize: 70,
                    onPressed: () async {
                      if (await pref.getUserAuth()) {
                        final bool isAuthenticated = await AuthService.authenticateUser();
                        if (isAuthenticated) {
                          showModalBottomSheet(
                              context: context,
                              useRootNavigator: true,
                              builder: (context) {
                                return const AttedanceBottomSheet();
                              },);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Either no biometric is enrolled or biometric did not match'),
                          ),),);
                        }
                      } else {
                        showModalBottomSheet(
                            context: context,
                            useRootNavigator: true,
                            builder: (context) {
                              return const AttedanceBottomSheet();
                            },);
                      }
                    },
                    icon: const Icon(
                      Icons.fingerprint_sharp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
              child: Text(
            'checkin_out'.tr,
            style: TextStyle(color: AppColors.textColor, fontSize: context.screenWidth * .05),
          ),),
          /*SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            child: LinearPercentIndicator(
              animation: true,
              animationDuration: 1000,
              lineHeight: 30.0,
              padding: EdgeInsets.all(0),
              percent: attendanceList['production-time']!,
              center: Text(
                attendanceList['production_hour'],
                style: TextStyle(color: AppColors.textColor),
              ),
              barRadius: const Radius.circular(20),
              backgroundColor: HexColor("#3dFFFFFF"),
              progressColor: attendanceList['check-in'] != "-" && attendanceList['check-out'] == "-" ? HexColor("#EDE7B0") : HexColor("#EDE7B0"),
            ),
          ),*/
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                attendanceList['check-in']!,
                style: const TextStyle(color: AppColors.textColor),
              ),
              Text(
                attendanceList['check-out']!,
                style: const TextStyle(color: AppColors.textColor),
              ),
            ],),
          ),
        ],
      ),
    );
  }
}
