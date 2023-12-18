import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/details_elevators.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/details_elevator.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllDetailsReport extends StatelessWidget {
  const AllDetailsReport({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = context.getArguments;
    /*  final arguments = {
                  'maintenanceEngineer': 'Name Technical',
                  'customerName': 'Customer Name',
                  'address': 'Egypt, Assut',
                  'phone': '120932437435',
                  'reportDate:': '24th Sep 2023',
                  'description': 'Description',
                };*/
    final String maintenanceEngineer = arguments['maintenanceEngineer'];
    final String customerName = arguments['customerName'];
    final String address = arguments['address'];
    final String phone = arguments['phone'];
    final String elevatorName = arguments['elevatorName'];
    final String reportDate = arguments['reportDate'] ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          elevatorName,
          style: Styles.styleHeader,
        ),
      ),
      body: ListView(
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
                DetailsElevatorRow(nameDetails: 'Maintenance Engineer ', executeDetails: maintenanceEngineer),
                DetailsElevatorRow(nameDetails: 'Report Date ', executeDetails: reportDate),
                DetailsElevatorRow(nameDetails: 'Customer Name', executeDetails: customerName),
                DetailsElevatorRow(nameDetails: 'Phone', executeDetails: phone),
                DetailsElevatorRow(nameDetails: 'address', executeDetails: address),
              ].paddingDirectional(bottom: context.screenHeight * .01),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(context.screenWidth * .02),
            child: Container(
              //constraints: BoxConstraints(maxWidth: context.screenWidth * .9),
              padding: EdgeInsets.all(context.screenWidth * .03),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Wrap(
                children: [
                  Text(
                    'Description:- \n',
                    style: Styles.style12400.copyWith(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 14.sp),
                  ),
                  ExpandableText(
                    detailsReport,
                    expandText: 'see more',
                    linkStyle: Styles.style12400.copyWith(fontWeight: FontWeight.w700, color: Colors.black),
                    style: Styles.style12400.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.subTextColor),
                    maxLines: 22,
                    collapseText: 'see less',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
