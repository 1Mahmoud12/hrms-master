import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/emergencieBloc/oneEmergencyCubit/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/emergencieBloc/oneEmergencyCubit/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/product_need_emrgency.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'maintenance_report.dart';

class MaintenanceReportMechanicsEmergencie extends StatelessWidget {
  const MaintenanceReportMechanicsEmergencie({super.key});

  @override
  Widget build(BuildContext context) {
    const String status = 'In Progress';
    final String idEmergency = context.getArguments['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maintenance Report'.tr,
          style: Styles.styleHeader,
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: CustomTextButton(
            onPress: () {},
            backgroundColor: AppColors.primaryColor,
            child: Text(
              'submit'.tr,
              style: Styles.style14400.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ],
      body: BlocProvider(
        create: (context) => GetOneEmergencyCubit()
          ..getOneEmergency(context: context, idEmergency: idEmergency),
        child: BlocBuilder<GetOneEmergencyCubit, GetOneEmergencyState>(
          builder: (context, state) => state is GetOneEmergencyLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is GetOneEmergencyErrorState
                  ? ErrorWidget(state.error)
                  : ListView(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Maintenance Status'.tr,
                                style: Styles.style14400,
                              ),
                              Text(
                                ' ${oneEmergencyCache!.data!.report == null ? status : oneEmergencyCache!.data!.report!.status}',
                                style: Styles.style14500.copyWith(
                                  color: status == 'In Progress'.tr
                                      ? AppColors.green
                                      : AppColors.subTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Maintenance Description'.tr,
                                    style: Styles.style14400,
                                  ),
                                ],
                              ),
                              Text(
                                oneEmergencyCache!
                                        .data!.emergency!.description ??
                                    'N/A',
                                maxLines: 3,
                                style: Styles.style14400
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                        ),
                        if (oneEmergencyCache!.data!.report != null)
                          MaintenanceReport(
                            report: oneEmergencyCache!.data!.report,
                          ),
                        const ProductsNeedErmergency(),
                      ].paddingDirectional(bottom: 10.h),
                    ),
        ),
      ),
    );
  }
}
