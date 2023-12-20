import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ItemShowModalBottomSheet extends StatelessWidget {
  final String titleShowModalBottomSheet;
  final Function onPress;
  final String assetName;

  const ItemShowModalBottomSheet({super.key, required this.titleShowModalBottomSheet, required this.onPress, required this.assetName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        width: context.screenWidth * .251,
        constraints: BoxConstraints(minHeight: context.screenHeight * .12),
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.all(10.w),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), border: Border.all(color: AppColors.textColorTextFormField)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(assetName),
            5.ESH(),
            Text(
              titleShowModalBottomSheet,
              style: Styles.style12400.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w400, fontSize: 12.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
