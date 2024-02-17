import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/reportBloc/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/reportBloc/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/details_elevators.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/details_elevator.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
    ReportBloc.of(context).maintenanceEngineerController.text = arguments['maintenanceEngineer'];
    ReportBloc.of(context).customerNameController.text = arguments['customerName'];
    ReportBloc.of(context).addressController.text = arguments['address'];
    ReportBloc.of(context).phoneController.text = arguments['phone'];
    final String elevatorName = arguments['elevatorName'];
    ReportBloc.of(context).detailsReportController.text = detailsReport;
    ReportBloc.of(context).reportDateController.text = arguments['reportDate'] ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          elevatorName,
          style: Styles.styleHeader,
        ),
        actions: [
          if (genderUser == RoleId.nine.name.tr)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: BlocBuilder<ReportBloc, ReportState>(
                builder: (context, state) => InkWell(
                  onTap: () {
                    ReportBloc.of(context).updateReportMechanics(
                      maintenanceEngineer: ReportBloc.of(context).maintenanceEngineerController.text,
                      reportDate: ReportBloc.of(context).reportDateController.text,
                      customerName: ReportBloc.of(context).customerNameController.text,
                      phone: ReportBloc.of(context).phoneController.text,
                      address: ReportBloc.of(context).addressController.text,
                      detailsReport: detailsReport,
                    );
                    Navigator.pushNamed(context, AppRoute.editReportScreen);
                  },
                  child: SvgPicture.asset(
                    Assets.edit,
                    colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  ),
                ),
              ),
            )
        ],
      ),
      body: BlocBuilder<ReportBloc, ReportState>(
        builder: (context, state) => ListView(
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
                  DetailsElevatorRow(nameDetails: 'Maintenance Engineer ', executeDetails: ReportBloc.of(context).maintenanceEngineerController.text),
                  DetailsElevatorRow(nameDetails: 'Report Date ', executeDetails: ReportBloc.of(context).reportDateController.text),
                  DetailsElevatorRow(nameDetails: 'Customer Name', executeDetails: ReportBloc.of(context).customerNameController.text),
                  DetailsElevatorRow(nameDetails: 'Phone', executeDetails: ReportBloc.of(context).phoneController.text),
                  DetailsElevatorRow(nameDetails: 'address', executeDetails: ReportBloc.of(context).addressController.text),
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
      ),
    );
  }
}
