import 'package:cnattendance/screen/HolidayScreen/holidayscreennew.dart';
import 'package:cnattendance/screen/MeetingScreen/MeetingScreenNew.dart';
import 'package:cnattendance/screen/TeamsheetScreen/TeamSheetScreenNew.dart';
import 'package:cnattendance/screen/profile/aboutscreen.dart';
import 'package:cnattendance/screen/profile/changepasswordscreen.dart';
import 'package:cnattendance/screen/profile/companyrulesscreen.dart';
import 'package:cnattendance/screen/profile/leavecalendarscreen.dart';
import 'package:cnattendance/screen/profile/notice/noticescreen.dart';
import 'package:cnattendance/screen/profile/profilescreen.dart';
import 'package:cnattendance/screen/profile/supportscreen.dart';
import 'package:cnattendance/widget/headerprofile.dart';
import 'package:cnattendance/widget/morescreen/securitycheck.dart';
import 'package:cnattendance/widget/morescreen/services.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: const Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderProfile(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Services',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Services('Profile', Icons.person, ProfileScreen()),
                  Services('Change Password', Icons.password, ChangePasswordScreen()),
                  Services('Meeting', Icons.meeting_room, MeetingScreenNew()),
                  //Services('Pay Slip', Icons.payments_rounded, PaySlipScreen()),
                  Services('Holiday', Icons.calendar_month, HolidayScreenNew()),
                  Services('Team Sheet', Icons.group, TeamSheetScreenNew()),
                  Services('Leave Calendar', Icons.calendar_month_outlined, LeaveCalendarScreen()),
                  Services('Notices', Icons.message, NoticeScreen()),
                  Services('Support', Icons.support_agent, SupportScreen()),
                  Services('TADA', Icons.money, SupportScreen()),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                    child: Text(
                      'Additional',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //Services('Issue Ticket', Icons.note, ProfileScreen()),
                  Services('Company Rules', Icons.rule_folder, CompanyRulesScreen()),
                  Services('About Us', Icons.info, AboutScreen('about-us')),
                  Services('Terms and Conditions', Icons.rule, AboutScreen('terms-and-conditions')),
                  Services('Privacy Policy', Icons.policy, ProfileScreen()),
                  SecurityCheck('Security Check', Icons.security, ''),
                  Services('Log Out', Icons.logout, ProfileScreen()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
