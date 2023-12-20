import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/state.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttachmentsReportCustomer extends StatelessWidget {
  const AttachmentsReportCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBlocMaintenanceCubit, MainBlocMaintenanceState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attachment',
            style: Styles.style18700.copyWith(color: Colors.black),
          ),
          Container(
            width: context.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            child: InkWell(
              onTap: () => MainBlocMaintenanceCubit.of(context).selectMoreImages(),
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
          if (MainBlocMaintenanceCubit.of(context).imagesAttachment.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<MainBlocMaintenanceCubit, MainBlocMaintenanceState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: context.screenHeight * .31,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Stack(
                                children: [
                                  Container(
                                    width: context.screenWidth * .3,
                                    height: context.screenHeight * .15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      image: DecorationImage(
                                        image: FileImage(
                                          MainBlocMaintenanceCubit.of(context).imagesAttachment[index],
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: context.screenWidth * .3,
                                    height: context.screenHeight * .15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: Colors.black12,
                                    ),
                                    child: Center(
                                      child: InkWell(
                                        onTap: () => MainBlocMaintenanceCubit.of(context).imagesAttachmentClear(index: index),
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
                              ),
                          separatorBuilder: (context, index) => 10.ESW(),
                          itemCount: MainBlocMaintenanceCubit.of(context).imagesAttachment.length),
                    );
                  },
                ),
              ].paddingDirectional(bottom: 10.h),
            ),
          20.ESH(),
        ].paddingDirectional(bottom: context.screenHeight * .01),
      ),
    );
  }
}
