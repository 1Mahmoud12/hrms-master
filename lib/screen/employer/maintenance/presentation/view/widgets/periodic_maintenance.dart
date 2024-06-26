import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/data/model/periodic_model.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PeriodicMaintenance extends StatelessWidget {
  final Periodic periodic;

  const PeriodicMaintenance({super.key, required this.periodic});

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
                periodic.name ?? '',
                style: Styles.style14500.copyWith(fontSize: 15.sp, color: AppColors.textColor, fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  Text(
                    'Elevators :'.tr,
                    style: Styles.style14500.copyWith(color: AppColors.textColor, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    periodic.numelevaters ?? '0',
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
                        (periodic.updatedAt ?? DateTime.now().toString()).substring(0, 10),
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
                    'Status: '.tr,
                    style: Styles.style14500.copyWith(color: AppColors.textColor, fontWeight: FontWeight.w700),
                  ),
                  5.ESW(),
                  Text(
                    'In progress'.tr,
                    style: Styles.style14500.copyWith(color: AppColors.green, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Location: '.tr,
                    style: Styles.style14500.copyWith(color: AppColors.textColor, fontWeight: FontWeight.w700),
                  ),
                  5.ESW(),
                  Text(
                    periodic.city ?? '',
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
                    'Show Reports'.tr,
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
