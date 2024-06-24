import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/provider/profileprovider.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BankDetail extends StatelessWidget {
  const BankDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context, listen: false).profile;

    return Directionality(
      textDirection: defaultLanguage != 'en' ? TextDirection.ltr : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Stack(
          children: [
            SvgPicture.asset(Assets.cardBandSVG),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * .07, right: context.screenWidth * .07),
                  child: Text(
                    profile.bankName,
                    style: Styles.style18700.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 80.h,
              left: 30.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: context.screenHeight * .03, right: context.screenWidth * .07),
                    child: Text(
                      maskText(profile.bankNumber),
                      style: Styles.style18700.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 120.h,
              left: 210.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: context.screenHeight * .03, right: context.screenWidth * .07),
                    child: Text(
                      profile.joinedDate.substring(5, 10),
                      style: Styles.style18700.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Card(
                shape: ButtonBorder(),
                color: Colors.transparent,
                elevation: 0,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String maskText(String text) {
    if (text.length != 15) return text; // Handle invalid lengths
    return '${text.substring(0, 4)} **** **** ${text.substring(12)}';
  }
}
