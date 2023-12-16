import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemShowModalBottomSheet extends StatelessWidget {
  final String titleShowModalBottomSheet;
  final Function onPress;
  const ItemShowModalBottomSheet({super.key, required this.titleShowModalBottomSheet, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        width: context.screenWidth,
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.all(10.w),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(15.r), border: Border.all(color: AppColors.grey)),
        child: Center(
          child: Text(
            titleShowModalBottomSheet,
            style: Styles.style16700.copyWith(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
