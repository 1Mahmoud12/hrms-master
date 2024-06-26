import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MaintenanceReport extends StatelessWidget {
  final dynamic report;
  final String? type;
  const MaintenanceReport({super.key, required this.report, this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Maintenance Report'.tr,
          style: Styles.style16700,
        ),
        InkWell(
          onTap: () {
            final arguments = {
              'Report': report,
            };
            if (type == 'Emergency') {
              Navigator.pushNamed(
                context,
                AppRoute.allDetailsReport,
                arguments: arguments,
              );
            } else {
              Navigator.pushNamed(
                context,
                AppRoute.allDetailsReportMalfunction,
                arguments: arguments,
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: Colors.white,
            ),
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
                      'Report'.tr,
                      style: Styles.style16700.copyWith(color: Colors.black),
                    ),
                    Text(
                      'By ${report.technical!.name ?? 'N/A'}',
                      style: Styles.style12400.copyWith(
                        color: AppColors.subTextColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SvgPicture.asset(Assets.arrowIOS),
              ],
            ),
          ),
        ),
      ].paddingDirectional(bottom: 10.h),
    );
  }
}
