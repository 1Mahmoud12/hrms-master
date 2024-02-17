import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/profile/NotificationScreen.dart';
import 'package:cnattendance/screen/profile/profilescreen.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class HeaderProfile extends StatefulWidget {
  const HeaderProfile({super.key});

  @override
  State<StatefulWidget> createState() => HeaderState();
}

class HeaderState extends State<HeaderProfile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(context, screen: const ProfileScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 50.w),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(context.screenWidth * .08),
                  child: Image.network(
                    userCache!.avatar!,
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
                  // child: Image.network(
                  //   'https://png.pngtree.com/png-vector/20220709/ourmid/pngtree-businessman-user-avatar-wearing-suit-with-red-tie-png-image_5809521.png',
                  //   width: 50,
                  //   height: 50,
                  //   fit: BoxFit.cover,
                  //   errorBuilder: (context, error, stackTrace) {
                  //     return Image.asset(
                  //       'assets/images/dummy_avatar.png',
                  //       width: 50,
                  //       height: 50,
                  //       fit: BoxFit.cover,
                  //     );
                  //   },
                  // ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hi'.tr,
                        style: TextStyle(color: AppColors.textColor, fontSize: context.screenWidth * .05),
                      ),
                      Text(
                        userCache!.name ?? '',
                        style: TextStyle(color: AppColors.textColor, fontSize: context.screenWidth * .05),
                      ),
                      /*Text(
                        provider.userName,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),*/
                    ],
                  ),
                  Text(
                    'Let’s be Productive today!'.tr,
                    style: TextStyle(color: AppColors.subTextColor, fontSize: context.screenWidth * .04),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                pushNewScreen(context, screen: const NotificationScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
              },
              icon: Badge.count(
                count: 5,
                textStyle: TextStyle(fontSize: context.screenWidth * .02, fontWeight: FontWeight.w700),
                child: const Icon(
                  Icons.notifications,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
