import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class MalfunctionRequest extends StatelessWidget {
  final String nameMaintenanceReport;
  final String status;
  final String date;
  
  String formattedDate(String fdate) {
    final DateTime date = DateTime.parse(fdate);
    final String formattedDate = DateFormat('dd/MMM/yyyy').format(date);

    return formattedDate;
  }

  const MalfunctionRequest({
    super.key,
    required this.nameMaintenanceReport,
    required this.status, required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.screenWidth * .02),
      margin: EdgeInsets.all(context.screenWidth * .02),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Badge(
            smallSize: context.screenWidth * .025,
            backgroundColor: status == Malfunction.Pending.name
                ? AppColors.red
                : Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: context.screenHeight * .009,
                horizontal: context.screenWidth * .02,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.cBackGroundIconMaintenance,
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: SvgPicture.asset(
                  Assets.maintenance,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
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
                style: Styles.style14500.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: context.screenWidth * .6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // const Icon(Icons.location_on_outlined, color: AppColors.subTextColor),
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.clock),
                          5.ESW(),
                          Text(
                            formattedDate(date),
                            style: Styles.style14500.copyWith(
                              color: AppColors.subTextColor.withOpacity(.8),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // const Icon(Icons.location_on_outlined, color: AppColors.subTextColor),

                          SvgPicture.asset(Assets.status),
                          5.ESW(),
                          Text(
                            status == Malfunction.In_Progress.name
                                ? 'In Progress'
                                : status,
                            style: Styles.style14500.copyWith(
                              color: status == Malfunction.In_Progress.name
                                  ? AppColors.green
                                  : AppColors.subTextColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ].paddingDirectional(bottom: 5),
          ),
          const Spacer(),
          SvgPicture.asset(Assets.arrowIOS),
        ],
      ),
    );
  }
}
