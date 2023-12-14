import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/details_elevators.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderDetailsContract extends StatelessWidget {
  final String startDate;
  final String endDate;
  final String location;
  final int numberElevators;

  const HeaderDetailsContract({super.key, required this.startDate, required this.endDate, required this.location, required this.numberElevators});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.black12,
          padding: EdgeInsets.all(context.screenWidth * .02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Start Date : ',
                  style: Styles.style16700.copyWith(fontSize: 15.sp, color: AppColors.textColor, fontWeight: FontWeight.w700),
                  children: [TextSpan(text: '$startDate 2024', style: Styles.style14400.copyWith(color: AppColors.subTextColor))],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'End Date : ',
                  style: Styles.style16700.copyWith(fontSize: 15.sp, color: AppColors.textColor, fontWeight: FontWeight.w700),
                  children: [TextSpan(text: '2 Dec 2024', style: Styles.style14400.copyWith(color: AppColors.subTextColor))],
                ),
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Location : ',
                      style: Styles.style16700.copyWith(fontSize: 15.sp, color: AppColors.textColor, fontWeight: FontWeight.w700),
                      children: [TextSpan(text: location, style: Styles.style14400.copyWith(color: AppColors.primaryColor))],
                    ),
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primaryColor,
                    size: context.screenWidth * .05,
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  text: 'Finished elevators : ',
                  style: Styles.style16700.copyWith(fontSize: 15.sp, color: AppColors.textColor, fontWeight: FontWeight.w700),
                  children: [TextSpan(text: '${numberElevators - 5}', style: Styles.style14400.copyWith(color: AppColors.subTextColor))],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'status: ',
                  style: Styles.style16700.copyWith(fontSize: 15.sp, color: AppColors.textColor, fontWeight: FontWeight.w700),
                  children: [TextSpan(text: 'in progress', style: Styles.style14400.copyWith(color: AppColors.green, fontWeight: FontWeight.w500))],
                ),
              ),
            ].paddingDirectional(bottom: context.screenHeight * .01),
          ),
        ),
        /*Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              text: 'Report:- \n',
              style: Styles.style16700.copyWith(fontSize: 15.sp, color: AppColors.textColor, fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                    text: detailsReport.replaceAll('\n', '').replaceAll('.', '.\n\n'),
                    style: Styles.style14400.copyWith(color: AppColors.subTextColor, fontWeight: FontWeight.w500))
              ],
            ),
          ),
        ),*/
        Padding(
          padding: EdgeInsets.all(context.screenWidth * .02),
          child: Container(
            //constraints: BoxConstraints(maxWidth: context.screenWidth * .9),
            padding: EdgeInsets.all(context.screenWidth * .02),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey,
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Wrap(
              children: [
                Text(
                  'Description:-',
                  style: Styles.style14500.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
                ),
                ExpandableText(
                  detailsReport,
                  expandText: 'see more',
                  linkStyle: Styles.style12400.copyWith(fontWeight: FontWeight.w600, color: Colors.black),
                  style: Styles.style12400,
                  maxLines: 22,
                  collapseText: 'see less',
                ),
              ],
            ),
          ),
        ),
      ].paddingDirectional(bottom: context.screenHeight * .02),
    );
  }
}
