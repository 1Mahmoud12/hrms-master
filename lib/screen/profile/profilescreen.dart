import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/provider/profileprovider.dart';
import 'package:cnattendance/screen/profile/NotificationScreen.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/widget/profile/bankdetail.dart';
import 'package:cnattendance/widget/profile/basicdetail.dart';
import 'package:cnattendance/widget/profile/heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool initalState = true;

  @override
  void didChangeDependencies() {
    if (initalState) {
      getProfileDetail();
      initalState = false;
    }
    super.didChangeDependencies();
  }

  bool isLoading = true;

  Future<String> getProfileDetail() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<ProfileProvider>(context, listen: false).getProfile();
    } catch (e) {
      return 'loaded';
    }

    setState(() {
      isLoading = false;
    });
    return 'loaded';
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<ProfileProvider>(context, listen: false).profile;
    //final profile = Provider.of<PrefProvider>(context);

    return Container(
      // decoration: RadialDecoration(),
      color: AppColors.scaffoldBackGround,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  pushNewScreen(context,
                      screen: const NotificationScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
                },
                child: SvgPicture.asset(Assets.notification),
              ),
            ),
          ],
          title: Text(
            'Profile'.tr,
            style: Styles.styleHeader,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () {
            return getProfileDetail();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const Heading(),
                Divider(
                  color: AppColors.dividerColor,
                  thickness: 1,
                  endIndent: 20.w,
                  indent: 20.w,
                ),
                if (userCache != null)
                  Container(
                    padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
                    width: double.infinity,
                    child: Text(
                      'Other_details'.tr,
                      style: const TextStyle(color: Color(0xff635F54), fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  )
                else
                  const SizedBox(),
                if (userCache != null) const BasicDetail() else const SizedBox(),
                if (userProfile.bankName != '' && userProfile.bankNumber.length >= 15 && userProfile.joinedDate != '')
                  Container(
                    padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
                    width: double.infinity,
                    child: Text(
                      'Bank_Details'.tr,
                      style: const TextStyle(color: Color(0xff635F54), fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                  )
                else
                  const SizedBox(),
                if (userProfile.bankName != '' && userProfile.bankNumber.length >= 15 && userProfile.joinedDate != '')
                  const BankDetail()
                else
                  const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
