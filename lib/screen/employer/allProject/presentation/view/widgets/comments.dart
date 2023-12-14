import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Comments extends StatelessWidget {
  final int newComments;

  const Comments({super.key, required this.newComments});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10).w,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Comments ($newComments)',
                style: Styles.style16700,
              ),
              const Spacer(),
              Text(
                'See All',
                style: Styles.style16700.copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
          10.ESH(),
          Container(
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20.r)),
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Assets.personal),
                    10.ESW(),
                    Text(
                      'Name person',
                      style: Styles.style14500,
                    ),
                  ],
                ),
                10.ESH(),
                Text(
                  'can i see the new report?',
                  style: Styles.style12400.copyWith(color: AppColors.textColorTextFormField),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20.r)),
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Assets.personal),
                    10.ESW(),
                    Text(
                      'Name person',
                      style: Styles.style14500,
                    ),
                  ],
                ),
                10.ESH(),
                Text(
                  'can i see the new report?',
                  style: Styles.style12400.copyWith(color: AppColors.textColorTextFormField),
                ),
              ],
            ),
          ),
        ].paddingDirectional(top: 10.h),
      ),
    );
  }
}
