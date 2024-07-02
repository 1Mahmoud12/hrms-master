import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/reportMalfunctionBloc/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/reportMalfunctionBloc/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/details_elevators.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/details_elevator.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/products_need_mechanics.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AllDetailsReportMalfunction extends StatelessWidget {
  const AllDetailsReportMalfunction({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = context.getArguments;
    final report = arguments['Report'];

    ReportMalfunctionCubit.of(context).maintenanceEngineerController.text =
        report.technical!.name ?? 'N/A';
    ReportMalfunctionCubit.of(context).customerNameController.text =
        userCache!.name ?? 'N/A';
    ReportMalfunctionCubit.of(context).phoneController.text =
        '${report.technical!.phone ?? 'N / A'}';
    ReportMalfunctionCubit.of(context).detailsReportController.text =
        report!.description ?? 'N / A';
    ReportMalfunctionCubit.of(context).reportDateController.text =
        report.updatedAt!.substring(0, 10);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report'.tr,
          style: Styles.styleHeader,
        ),
        actions: [
          if (genderUser == RoleId.nine.name.tr)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: BlocBuilder<ReportMalfunctionCubit, ReportState>(
                builder: (context, state) => InkWell(
                  onTap: () {
                    ReportMalfunctionCubit.of(context).updateReportMechanics(
                      maintenanceEngineer: ReportMalfunctionCubit.of(context)
                          .maintenanceEngineerController
                          .text,
                      reportDate: ReportMalfunctionCubit.of(context)
                          .reportDateController
                          .text,
                      customerName: ReportMalfunctionCubit.of(context)
                          .customerNameController
                          .text,
                      phone: ReportMalfunctionCubit.of(context)
                          .phoneController
                          .text,
                      address: ReportMalfunctionCubit.of(context)
                          .addressController
                          .text,
                      detailsReport: detailsReport,
                    );
                    Navigator.pushNamed(context, AppRoute.editReportScreen);
                  },
                  child: SvgPicture.asset(
                    Assets.edit,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      persistentFooterButtons: [
        CustomTextButton(
          backgroundColor: AppColors.primaryColor,
          onPress: () {
            Navigator.pop(context);
          },
          child: Text(
            'submit'.tr,
            style: Styles.style14400.copyWith(color: AppColors.white),
          ),
        ),
      ],
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      body: BlocBuilder<ReportMalfunctionCubit, ReportState>(
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
                    'Details'.tr,
                    style: Styles.style14500.copyWith(color: Colors.black),
                  ),
                  DetailsElevatorRow(
                    nameDetails: 'Maintenance Engineer'.tr,
                    executeDetails: ReportMalfunctionCubit.of(context)
                        .maintenanceEngineerController
                        .text,
                  ),
                  DetailsElevatorRow(
                    nameDetails: 'Report Date'.tr,
                    executeDetails: ReportMalfunctionCubit.of(context)
                        .reportDateController
                        .text,
                  ),
                  DetailsElevatorRow(
                    nameDetails: 'Customer Name'.tr,
                    executeDetails: ReportMalfunctionCubit.of(context)
                        .customerNameController
                        .text,
                  ),
                  DetailsElevatorRow(
                    nameDetails: 'Phone'.tr,
                    executeDetails:
                        ReportMalfunctionCubit.of(context).phoneController.text,
                  ),
                  DetailsElevatorRow(
                    nameDetails: 'address'.tr,
                    executeDetails: ReportMalfunctionCubit.of(context)
                        .addressController
                        .text,
                  ),
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
                      'Description:-'.tr,
                      style: Styles.style12400.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                      ),
                    ),
                    ExpandableText(
                      report.description ?? 'N/A',
                      expandText: 'see more'.tr,
                      linkStyle: Styles.style12400.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      style: Styles.style12400.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.subTextColor,
                      ),
                      maxLines: 22,
                      collapseText: 'see less'.tr,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(context.screenWidth * .03),
              child: const ProductsNeedMalfunction(),
            ),
          ],
        ),
      ),
    );
  }
}
