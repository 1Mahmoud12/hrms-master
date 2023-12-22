import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamProjectScreen extends StatelessWidget {
  const TeamProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Project', style: Styles.styleHeader),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .05, vertical: context.screenHeight * .02),
        children: [
          ...List.generate(
            5,
            (index) => Container(
              height: context.screenHeight * .08,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: const AssetImage(Assets.temporaryPerson),
                    radius: 20.r,
                  ),
                  15.ESW(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'name Team',
                          style: Styles.style14400.copyWith(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Mechanics',
                          style: Styles.style14400.copyWith(color: AppColors.textColorTextFormField),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ].paddingDirectional(bottom: context.screenHeight * .02),
      ),
    );
  }
}
