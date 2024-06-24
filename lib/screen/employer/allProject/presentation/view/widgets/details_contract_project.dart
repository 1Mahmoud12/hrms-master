import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/detailsContractBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/detailsContractBloc/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/details_elevator.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class DetailsContractProject extends StatelessWidget {
  const DetailsContractProject({super.key});

  @override
  Widget build(BuildContext context) {
    //Create an instance of ScreenshotController
    final ScreenshotController screenshotController = ScreenshotController();
    final model = Get.find<ProjectDetailController>();

    return BlocProvider(
      create: (context) => DetailsContractCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Details Contract',
            style: Styles.styleHeader,
          ),
          actions: [
            BlocBuilder<DetailsContractCubit, DetailsContractState>(
              builder: (context, state) => IconButton(
                onPressed: () async {
                  await screenshotController.capture().then((value) async {
                    await DetailsContractCubit.of(context)
                        .savePdf(screen: value);
                  });
                },
                icon: const Icon(Icons.save_alt),
              ),
            ),
          ],
        ),
        body: Screenshot(
          controller: screenshotController,
          child: ListView(
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
                        nameDetails: 'Start Date'.tr,
                        executeDetails: model.project.value.date),
                    DetailsElevatorRow(
                        nameDetails: 'Installation'.tr,
                        executeDetails: model.project.value.status),
                    DetailsElevatorRow(
                        nameDetails: 'Supplying duration'.tr,
                        executeDetails: model.project.value.deadline),
                    DetailsElevatorRow(
                        nameDetails: 'Priority'.tr,
                        executeDetails: model.project.value.priority),
                    // DetailsElevatorRow(nameDetails: 'the cost', executeDetails: '${model.project.value.noOfTask} EGY'),
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
                            fontSize: 14.sp),
                      ),
                      Html(
                        data: model.project.value.description,
                      ),
                      /* ExpandableText(
                        model.project.value.description,
                        expandText: 'see more',
                        linkStyle: Styles.style12400.copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Colors.black),
                        style: Styles.style12400.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.subTextColor),
                        maxLines: 22,
                        collapseText: 'see less',
                      ),*/
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
