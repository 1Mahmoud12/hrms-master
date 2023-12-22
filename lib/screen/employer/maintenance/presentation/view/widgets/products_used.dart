import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductsUsed extends StatelessWidget {
  const ProductsUsed({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Products used',
              style: Styles.style16700,
            ),
            Text(
              '\$55,000',
              style: Styles.style16700,
            ),
          ],
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
                child: SvgPicture.asset(Assets.productsUsed),
              ),
              10.ESW(),
              Text(
                'Engine',
                style: Styles.style16700.copyWith(color: Colors.black),
              ),
              const Spacer(),
              const Text('\$15,000'),
            ],
          ),
        ),
      ].paddingDirectional(bottom: 10.h),
    );
  }
}
