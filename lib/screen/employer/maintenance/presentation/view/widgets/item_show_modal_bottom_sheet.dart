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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Row(
          children: [
            Text(
              titleShowModalBottomSheet,
              style: Styles.style16700.copyWith(fontSize: 14.sp),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_sharp)
          ],
        ),
      ),
    );
  }
}
