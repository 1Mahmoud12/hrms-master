import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PeriodicMaintenance extends StatelessWidget {
  final String nameMaintenanceReport;
  final String numberElevators;

  const PeriodicMaintenance({super.key, required this.nameMaintenanceReport, required this.numberElevators});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.screenWidth * .02),
      margin: EdgeInsets.all(context.screenWidth * .02),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(15.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: context.screenHeight * .009, horizontal: context.screenWidth * .02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: AppColors.cBackGroundIconMaintenance,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: SvgPicture.asset(
                Assets.maintenance,
                colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
              ),
            ),
          ),
          10.ESW(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                nameMaintenanceReport,
                style: Styles.style14500.copyWith(fontSize: 15.sp, color: AppColors.textColor, fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  Text(
                    'Elevators :',
                    style: Styles.style14500.copyWith(color: AppColors.textColor, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    numberElevators,
                    style: Styles.style14400.copyWith(color: AppColors.textColor),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // const Icon(Icons.location_on_outlined, color: AppColors.subTextColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '14/Aug/2023',
                        style: Styles.style14500.copyWith(color: AppColors.subTextColor.withOpacity(.8), fontWeight: FontWeight.w700),
                      ),
                      10.ESW(),
                      SvgPicture.asset(Assets.arrowMaintenance),
                      10.ESW(),
                      Text(
                        '14/Aug/2023',
                        style: Styles.style14500.copyWith(color: AppColors.subTextColor.withOpacity(.8), fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // const Icon(Icons.location_on_outlined, color: AppColors.subTextColor),

                  Text(
                    'Status: ',
                    style: Styles.style14500.copyWith(color: AppColors.textColor, fontWeight: FontWeight.w700),
                  ),
                  5.ESW(),
                  Text(
                    'In progress',
                    style: Styles.style14500.copyWith(color: AppColors.green, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Location: ',
                    style: Styles.style14500.copyWith(color: AppColors.textColor, fontWeight: FontWeight.w700),
                  ),
                  5.ESW(),
                  Text(
                    'Cairo,Egypt',
                    style: Styles.style14500.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w500),
                  ),
                  SvgPicture.asset(Assets.location),
                ],
              ),
              5.ESH(),
              SizedBox(
                width: context.screenWidth * .65,
                child: TextButton(
                  onPressed: null,
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(20),
                    shape: MaterialStatePropertyAll(
                      ContinuousRectangleBorder(
                        side: const BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(AppColors.white),
                  ),
                  child: Text(
                    'Show Reports',
                    style: Styles.style16700.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ].paddingDirectional(bottom: 5),
          ),
        ],
      ),
    );
  }
}
