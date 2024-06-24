import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/cache_image.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/malfunctionBloc/cubit/malfunction_cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/malfunctionBloc/cubit/malfunction_state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/maintenance_report.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/products_used.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MalfunctionScreen extends StatelessWidget {
  const MalfunctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String nameRequest = context.getArguments['nameMaintenanceReport'];
    final String idMalfunction = context.getArguments['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          nameRequest,
          style: Styles.styleHeader,
        ),
      ),
      body: BlocProvider(
        create: (context) => MalfunctionCubit()
          ..getOneMalfunction(context: context, idMalfunction: idMalfunction),
        child: BlocBuilder<MalfunctionCubit, MalfunctionState>(
          builder: (context, state) => state is GetOneMalfunctionLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is GetOneMalfunctionErrorState
                  ? ErrorWidget(state.error)
                  : ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * .05,
                      ),
                      children: [
                        /*Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Maintenance Status',
                      style: Styles.style14400,
                    ),
                    Text(
                      status,
                      style: Styles.style14500
                          .copyWith(color: status == 'In Progress' ? AppColors.green : AppColors.subTextColor, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),*/
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Details',
                                style: Styles.style14400,
                              ),
                              Text(
                                'Name',
                                style: Styles.style14400,
                              ),
                              Text(
                                oneMalfunctioCache!.data!.malfunction!.name ??
                                    'N/A',
                                style: Styles.style14400
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                              Text(
                                'Description',
                                style: Styles.style14400,
                              ),
                              Text(
                                oneMalfunctioCache!
                                        .data!.malfunction!.description ??
                                    'N/A',
                                maxLines: 3,
                                style: Styles.style14400
                                    .copyWith(color: AppColors.primaryColor),
                              ),
                              Text(
                                'location',
                                style: Styles.style14400,
                              ),
                              Row(
                                children: [
                                  Text(
                                    oneMalfunctioCache!
                                            .data!.malfunction!.location ??
                                        'N/A',
                                    style: Styles.style14400.copyWith(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  5.ESW(),
                                  SvgPicture.asset(
                                    Assets.location,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.primaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Attachment',
                                style: Styles.style14400,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: CacheImage(
                                  imageUrl: oneMalfunctioCache!
                                          .data!.malfunction!.img ??
                                      '',
                                  profileImage: false,
                                  height: 60,
                                  width: 90,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (oneMalfunctioCache!.data!.report != null)
                          MaintenanceReport(
                            report: oneMalfunctioCache!.data!.report,
                          ),
                        const ProductsUsed(),
                        CustomTextButton(
                          backgroundColor: AppColors.primaryColor,
                          child: Text(
                            'Confirm',
                            style: Styles.style16700
                                .copyWith(color: AppColors.white),
                          ),
                          onPress: () {
                            showToast('message');
                          },
                        ),
                      ].paddingDirectional(bottom: 10.h),
                    ),
        ),
      ),
    );
  }
}
