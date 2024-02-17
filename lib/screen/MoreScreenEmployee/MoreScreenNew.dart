import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/HolidayScreen/holidayscreennew.dart';
import 'package:cnattendance/screen/MeetingScreen/MeetingScreenNew.dart';
import 'package:cnattendance/screen/SupportScreen/SupportScreenNew.dart';
import 'package:cnattendance/screen/TeamsheetScreen/TeamSheetScreenNew.dart';
import 'package:cnattendance/screen/employer/staticloginhome/staticloginhome_screen.dart';
import 'package:cnattendance/screen/profile/NotificationScreen.dart';
import 'package:cnattendance/screen/profile/aboutscreen.dart';
import 'package:cnattendance/screen/profile/changepasswordscreen.dart';
import 'package:cnattendance/screen/profile/companyrulesscreen.dart';
import 'package:cnattendance/screen/profile/leavecalendarscreen.dart';
import 'package:cnattendance/screen/profile/notice/noticescreen.dart';
import 'package:cnattendance/screen/profile/profilescreen.dart';
import 'package:cnattendance/screen/securitycheck/Securitycheck.dart';
import 'package:cnattendance/screen/tadascreen/tadascreen.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:cnattendance/widget/log_out_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class MoreScreenNew extends StatelessWidget {
  const MoreScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    // final profile = Provider.of<CustomerProvider>(context);
    //print('roleId ${profile.roleId}');
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      // extendBodyBehindAppBar: true,

      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'More',
          style: TextStyle(color: AppColors.textColor, fontSize: 24.sp, fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
            child: InkWell(
              onTap: () {
                pushNewScreen(context, screen: const NotificationScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
              },
              child: SvgPicture.asset(Assets.notification),
            ),
          ),
        ],
        elevation: 0,
      ),
      // backgroundColor: Color(0xffcfcdcb),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                pushNewScreen(context, screen: const ProfileScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    userCache!.avatar ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/dummy_avatar.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              userCache!.name ?? '',
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MoreCardoverviewSvgs(
              type: 'Profile'.tr,
              svgvalue: Assets.profile,
              onPressed: () {
                if (genderUser != RoleId.eight.name.tr || genderUser != RoleId.twelve.name.tr) {
                  pushNewScreen(context, screen: const ProfileScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
                } else {
                  pushNewScreen(
                    context,
                    screen: const StaticLoginHomeScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                }
              },
            ),
            /*MoreCardoverviewSvgs(
            type: 'Projects'.tr,
            svgvalue: Assets.pr,
            onPressed: () {
              pushNewScreen(context, screen: ProjectScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
            },
          ),*/
            /*MoreCardoverviewSvgs(
            type: 'Tasks'.tr,
            svgvalue: Svgconstants.takslist,
            onPressed: () {
              pushNewScreen(context, screen: TaskListScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
            },
          ),*/
            if (genderUser != RoleId.eight.name.tr || genderUser != RoleId.twelve.name.tr)
              MoreCardoverviewSvgs(
                type: 'Meeting'.tr,
                svgvalue: Assets.meeting,
                onPressed: () {
                  pushNewScreen(context, screen: const MeetingScreenNew(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
                },
              ),
            if (genderUser != RoleId.eight.name.tr || genderUser != RoleId.twelve.name.tr)
              MoreCardoverviewSvgs(
                type: 'Holiday'.tr,
                svgvalue: Assets.weekend,
                onPressed: () {
                  pushNewScreen(context, screen: const HolidayScreenNew(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
                },
              ),
            if (genderUser != RoleId.eight.name.tr || genderUser != RoleId.twelve.name.tr)
              MoreCardoverviewSvgs(
                type: 'Team_Sheet'.tr,
                svgvalue: Assets.team,
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: const TeamSheetScreenNew(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
              ),
            if (genderUser != RoleId.eight.name.tr || genderUser != RoleId.twelve.name.tr)
              MoreCardoverviewSvgs(
                type: 'Leave_Calendar'.tr,
                svgvalue: Assets.calender,
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: const LeaveCalendarScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
              ),
            if (genderUser != RoleId.eight.name.tr || genderUser != RoleId.twelve.name.tr)
              MoreCardoverviewSvgs(
                type: 'Notices'.tr,
                svgvalue: Assets.notiesMore,
                onPressed: () {
                  pushNewScreen(context, screen: const NoticeScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
                },
              ),
            MoreCardoverviewSvgs(
              type: 'Support'.tr,
              svgvalue: Assets.Support,
              onPressed: () {
                pushNewScreen(context, screen: const SupportScreenNew(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
              },
            ),
            if (genderUser != RoleId.eight.name.tr || genderUser != RoleId.twelve.name.tr)
              MoreCardoverviewSvgs(
                type: 'Tada'.tr,
                svgvalue: Assets.tada,
                onPressed: () {
                  pushNewScreen(context, screen: const TadaScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
                },
              ),
            MoreCardoverviewSvgs(
              type: 'Companyrule'.tr,
              svgvalue: Assets.rules,
              onPressed: () {
                pushNewScreen(context, screen: const CompanyRulesScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
              },
            ),
            MoreCardoverviewSvgs(
              type: 'About_us'.tr,
              svgvalue: Assets.aboutUS,
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: const AboutScreen('About-us'),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
            ),
            MoreCardoverviewSvgs(
              type: 'Termsandcondition'.tr,
              svgvalue: Assets.term,
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: const AboutScreen('Terms-and-conditions'),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
            ),
            MoreCardoverviewSvgs(
              type: 'Privacy_Policy'.tr,
              svgvalue: Assets.privacyPolicy,
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: const AboutScreen('App-policy'),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
            ),
            if (genderUser != RoleId.eight.name.tr || genderUser != RoleId.twelve.name.tr)
              MoreCardoverviewSvgs(
                type: 'Securitiy'.tr,
                svgvalue: Assets.Security,
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: const SecurityCheckScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
              ),
            MoreCardoverviewSvgs(
              type: 'Change_password'.tr,
              svgvalue: Assets.changePassword,
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: const ChangePasswordScreen(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
            ),
            if (genderUser != RoleId.eight.name.tr || genderUser != RoleId.twelve.name.tr)
              MoreCardoverviewSvgs(
                type: 'Financial requests'.tr,
                svgvalue: Assets.financialRequest,
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: const SecurityCheckScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
              ),
            if (genderUser != RoleId.eight.name.tr || genderUser != RoleId.twelve.name.tr)
              MoreCardoverviewSvgs(
                type: 'Administrativa requests'.tr,
                svgvalue: Assets.AdministrativaRequests,
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: const SecurityCheckScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.fade,
                  );
                },
              ),
            MoreCardoverviewSvgs(
              type: 'Log Out'.tr,
              svgvalue: Assets.logout,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  builder: (context) {
                    return const LogOutBottomSheet();
                  },
                );
                //  pushNewScreen(context, screen: SecurityCheckScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
              },
            ),
            50.ESH(),
            /*Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: InkWell(
                onTap: () {
                  pushNewScreen(context, screen: PaidRequestScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.string(
                        Svgconstants.financial_requ,
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Paid_request".tr,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: InkWell(
                onTap: () {
                  pushNewScreen(context, screen: RequestScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.string(
                        Svgconstants.Adminisntrative_req,
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Unpaid_request".tr,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: InkWell(
                onTap: () {
                  pushNewScreen(context, screen: TranslationScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.string(
                        Svgconstants.more_termscondition,
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("translation".tr,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(left: 5),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: HexColor("#635f54"),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(29))),
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    builder: (context) {
                      return LogOutBottomSheet();
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  'logout'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(left: 5),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: HexColor("#635f54"),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(29))),
              ),
              onPressed: () {
                // Get.snackbar('Success', 'Request Submitted');
                showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    builder: (context) {
                      return DeactivemodalSheet();
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  'Deactivate'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),*/
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}

class MoreCardoverviewSvgs extends StatelessWidget {
  final String type;
  final String svgvalue;
  final VoidCallback onPressed;

  const MoreCardoverviewSvgs({
    super.key,
    required this.type,
    required this.svgvalue,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Card(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 0,
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      svgvalue,
                    ),
                    10.ESW(),
                    Text(
                      type,
                      style:
                          TextStyle(color: type == 'Log Out' ? AppColors.red : AppColors.primaryColor, fontSize: 15.sp, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_outlined, color: type == 'Log Out' ? AppColors.red : AppColors.primaryColor),
                  ],
                ),
                10.ESH(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MoreCardoverviewSvgsandcolor extends StatelessWidget {
  final String type;
  final String svgvalue;
  final Color bgcolor;

  const MoreCardoverviewSvgsandcolor({super.key, required this.type, required this.svgvalue, required this.bgcolor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 20,
      child: Card(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 0,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(color: bgcolor, borderRadius: const BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.string('''
                      $svgvalue
                  '''),
                ),
              ),
              Text(
                type,
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
