import 'package:cnattendance/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaveSummary extends StatelessWidget {
  final String maintxt;
  final String svgName;
  final Color colorBackGround;
  final Color borderColor;
  final int allocated;
  final int used;

  const LeaveSummary(
      {super.key,
      required this.maintxt,
      required this.used,
      required this.allocated,
      required this.svgName,
      required this.colorBackGround,
      required this.borderColor,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10).w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: borderColor),
        color: colorBackGround,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(svgName),
            Text(
              used.toString(),
              style: Styles.style18700.copyWith(color: borderColor),
            ),
            Text(
              maintxt,
              style: Styles.style14400,
            ),
          ],
        ),
      ),
    );
  }
}
