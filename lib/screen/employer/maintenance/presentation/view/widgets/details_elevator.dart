import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsElevatorRow extends StatelessWidget {
  final String nameDetails;
  final String executeDetails;

  const DetailsElevatorRow({super.key, required this.nameDetails, required this.executeDetails});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          nameDetails,
          style: Styles.style14500.copyWith(color: AppColors.subTextColor),
        ),
        Text(
          executeDetails,
          style: TextStyle(color: AppColors.primaryColor, fontSize: 13.sp, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
