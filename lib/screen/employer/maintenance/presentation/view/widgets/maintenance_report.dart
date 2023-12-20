import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MaintenanceReport extends StatelessWidget {
  const MaintenanceReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Maintenance Report',
          style: Styles.style16700,
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: Colors.white),
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cBorderDecoration),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(10.w),
                child: SvgPicture.asset(Assets.FileSVG),
              ),
              10.ESW(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Report',
                    style: Styles.style16700.copyWith(color: Colors.black),
                  ),
                  Text(
                    'By Ahmed Mohamed',
                    style: Styles.style12400.copyWith(color: AppColors.subTextColor, fontSize: 10.sp),
                  ),
                ],
              ),
              const Spacer(),
              SvgPicture.asset(Assets.arrowIOS),
            ],
          ),
        ),
      ].paddingDirectional(bottom: 10.h),
    );
  }
}
