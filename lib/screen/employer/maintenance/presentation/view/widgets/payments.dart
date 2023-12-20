import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentsReportCustomer extends StatelessWidget {
  const PaymentsReportCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<MainBlocMaintenanceCubit, MainBlocMaintenanceState>(
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (MainBlocMaintenanceCubit.of(context).image == null)
                Center(
                  child: CustomTextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.upload),
                        5.ESW(),
                        Text(
                          'Upload payment receipt',
                          style: Styles.style16700.copyWith(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    onPress: () {
                      MainBlocMaintenanceCubit.of(context).selectImage();
                    },
                  ),
                ),
              if (MainBlocMaintenanceCubit.of(context).image != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment',
                      style: Styles.style18700.copyWith(color: Colors.black),
                    ),
                    Container(
                      width: context.screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () => MainBlocMaintenanceCubit.of(context).selectImage(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15.w),
                              decoration: BoxDecoration(
                                color: const Color(0xff246BFD).withOpacity(.2),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.r), topLeft: Radius.circular(10.r)),
                              ),
                              child: Text(
                                'upload',
                                style: Styles.style14400.copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<MainBlocMaintenanceCubit, MainBlocMaintenanceState>(
                      builder: (context, state) {
                        return Stack(
                          children: [
                            if (MainBlocMaintenanceCubit.of(context).image.toString() != "File: ''")
                              Container(
                                width: context.screenWidth * .4,
                                height: context.screenHeight * .2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  image: DecorationImage(
                                    image: FileImage(
                                      MainBlocMaintenanceCubit.of(context).image!,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            if (MainBlocMaintenanceCubit.of(context).image.toString() != "File: ''")
                              Container(
                                width: context.screenWidth * .4,
                                height: context.screenHeight * .2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Colors.black12,
                                ),
                                child: Center(
                                  child: InkWell(
                                    onTap: () => MainBlocMaintenanceCubit.of(context).imageFileClear(),
                                    child: Container(
                                      padding: EdgeInsets.all(8.w),
                                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black26),
                                      child: const Icon(
                                        Icons.close,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    if (MainBlocMaintenanceCubit.of(context).image != null && MainBlocMaintenanceCubit.of(context).image.toString() != "File: ''")
                      Center(
                        child: Image.file(
                          MainBlocMaintenanceCubit.of(context).image!,
                          width: context.screenWidth * .9,
                          height: context.screenHeight * .15,
                          fit: BoxFit.fill,
                        ),
                      ),
                  ].paddingDirectional(bottom: 10.h),
                ),
              20.ESH(),
            ],
          ),
        ),
      ],
    );
  }
}
