import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/detailsContractBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/detailsContractBloc/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/details_elevators.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/details_elevator.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';

class DetailsContractProject extends StatelessWidget {
  const DetailsContractProject({super.key});

  @override
  Widget build(BuildContext context) {
    //Create an instance of ScreenshotController
    final ScreenshotController screenshotController = ScreenshotController();
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
                      await DetailsContractCubit.of(context).savePdf(screen: value);
                    });
                  },
                  icon: const Icon(Icons.save_alt)),
            )
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
                      'Details',
                      style: Styles.style14500.copyWith(color: Colors.black),
                    ),
                    const DetailsElevatorRow(nameDetails: 'Start Date', executeDetails: '10 DEC 2023'),
                    const DetailsElevatorRow(nameDetails: 'Installation', executeDetails: 'Installation'),
                    const DetailsElevatorRow(nameDetails: 'Supplying duration', executeDetails: '5 Years'),
                    const DetailsElevatorRow(nameDetails: 'Number of elevators', executeDetails: '15'),
                    const DetailsElevatorRow(nameDetails: 'the cost', executeDetails: '10,000 EGY'),
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
                        linkStyle: Styles.style12400.copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Colors.black),
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
      ),
    );
  }
}
