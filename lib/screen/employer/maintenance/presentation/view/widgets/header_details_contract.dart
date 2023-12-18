import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/details_elevator.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderDetailsContract extends StatelessWidget {
  final String startDate;
  final String endDate;
  final String location;

  const HeaderDetailsContract({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(context.screenWidth * .03),
          margin: EdgeInsets.all(context.screenWidth * .03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details',
                style: Styles.style14500.copyWith(color: Colors.black),
              ),
              const DetailsElevatorRow(nameDetails: 'Maintenance Engineer ', executeDetails: 'Eman Saber'),
              const DetailsElevatorRow(nameDetails: 'contract Date ', executeDetails: '24th Sep 2023'),
              const DetailsElevatorRow(nameDetails: 'Customer Name', executeDetails: 'Jane Doe'),
              const DetailsElevatorRow(nameDetails: 'Phone', executeDetails: '01127260336'),
              const DetailsElevatorRow(nameDetails: 'Examination Date:', executeDetails: '24th Sep 2023'),
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
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .03),
            child: Text(
              'Elevator report History',
              style: Styles.styleHeader,
            ),
          ),
        ),
        SizedBox(
          height: context.screenHeight * .58,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                final arguments = {
                  'maintenanceEngineer': 'Name Technical',
                  'customerName': 'Customer Name',
                  'address': 'Egypt, Assut',
                  'phone': '120932437435',
                  'reportDate': '24th Sep 2023',
                  'description': 'Description',
                  'elevatorName': 'Elevator 1',
                };
                Navigator.pushNamed(context, AppRoute.allDetailsReport, arguments: arguments);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.cBorderDecoration),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(10.w),
                      child: SvgPicture.asset(Assets.FileSVG),
                    ),
                    15.ESW(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name Report',
                          style: Styles.style18700,
                        ),
                        SizedBox(
                          width: context.screenWidth * .65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'By Name Technical',
                                style: Styles.style12400.copyWith(color: AppColors.subTextColor),
                              ),
                              Text(
                                '14 Marc',
                                style: Styles.style12400.copyWith(color: AppColors.subTextColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios_sharp),
                  ],
                ),
              ),
            ),
          ),
        ),
      ].paddingDirectional(bottom: context.screenHeight * .01),
    );
  }
}
