import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/addReportEngineerBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/addReportEngineerBloc/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/details_elevator.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailsProposalScreen extends StatelessWidget {
  const DetailsProposalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = context.getArguments;
    final int index = argument['index'];
    final int formRequestId = argument['formRequestId'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details Proposal',
          style: Styles.styleHeader,
        ),
      ),
      body: BlocProvider(
        create: (context) => AddReportEngineerCubit(),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Details',
                        style: Styles.style14500.copyWith(color: Colors.black),
                      ),
                      DetailsElevatorRow(
                        nameDetails: allProposalsModelCache!.data!.requests![index].formData!.userNameLabel ?? '',
                        executeDetails: allProposalsModelCache!.data!.requests![index].formData!.userNameValue ?? 'N/A',
                      ),
                      DetailsElevatorRow(
                        nameDetails: allProposalsModelCache!.data!.requests![index].formData!.userEmailLabel ?? '',
                        executeDetails: allProposalsModelCache!.data!.requests![index].formData!.userEmailValue ?? 'N/A',
                      ),
                      DetailsElevatorRow(
                        nameDetails: allProposalsModelCache!.data!.requests![index].formData!.phoneNumberLabel ?? '',
                        executeDetails: allProposalsModelCache!.data!.requests![index].formData!.phoneNumberValue ?? 'N/A',
                      ),
                      DetailsElevatorRow(
                        nameDetails: allProposalsModelCache!.data!.requests![index].formData!.userAgeLabel ?? '',
                        executeDetails: allProposalsModelCache!.data!.requests![index].formData!.userAgeValue ?? 'N/A',
                      ),
                      DetailsElevatorRow(
                        nameDetails: allProposalsModelCache!.data!.requests![index].formData!.userGenderLabel ?? '',
                        executeDetails: allProposalsModelCache!.data!.requests![index].formData!.userGenderValue ?? 'N/A',
                      ),
                      DetailsElevatorRow(
                        nameDetails: allProposalsModelCache!.data!.requests![index].formData!.userAddressLabel ?? '',
                        executeDetails: allProposalsModelCache!.data!.requests![index].formData!.userAddressValue ?? 'N/A',
                      ),
                    ].paddingDirectional(bottom: context.screenHeight * .01),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Report Sales',
                    style: Styles.styleHeader,
                  ),
                ),
                BlocBuilder<AddReportEngineerCubit, AddReportEngineerState>(
                  builder: (context, state) => CustomTextFormField(
                    controller: AddReportEngineerCubit.of(context).reportSales,
                    hintText: 'Description',
                    maxLines: 10,
                    enabled: genderUser == RoleId.eleven.name.tr,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Report Engineer',
                    style: Styles.styleHeader,
                  ),
                ),
                BlocBuilder<AddReportEngineerCubit, AddReportEngineerState>(
                  builder: (context, state) => CustomTextFormField(
                    controller: AddReportEngineerCubit.of(context).reportEngineer,
                    hintText: 'Description',
                    maxLines: 10,
                    enabled: genderUser == RoleId.nine.name.tr,
                    onFieldSubmitted: (value) {},
                  ),
                ),
                BlocBuilder<AddReportEngineerCubit, AddReportEngineerState>(
                  builder: (context, state) => Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Total Cost',
                          style: Styles.style16700,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: AddReportEngineerCubit.of(context).costReportEngineer,
                                  style: Styles.style16700,
                                  decoration: InputDecoration(
                                    hintText: '00.00',
                                    hintStyle: Styles.style16700,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                                    fillColor: AppColors.transparent,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.transparent)),
                                  ),
                                  keyboardType: TextInputType.number,
                                  enabled: genderUser == RoleId.nine.name.tr,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'EGP',
                                style: Styles.style16700.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<AddReportEngineerCubit, AddReportEngineerState>(
                  builder: (context, state) => CustomTextButton(
                    backgroundColor: AppColors.primaryColor,
                    child: Text(
                      'Submit',
                      style: Styles.style16700.copyWith(color: AppColors.white),
                    ),
                    onPress: () {
                      if (genderUser == RoleId.nine.name.tr) {
                        AddReportEngineerCubit.of(context).postReportEngineer(
                          formRequestId: formRequestId,
                          cost: AddReportEngineerCubit.of(context).costReportEngineer.text,
                          reportTechnical: AddReportEngineerCubit.of(context).reportEngineer.text,
                          context: context,
                        );
                      } else {
                        AddReportEngineerCubit.of(context).postReportSales(
                          formRequestId: formRequestId,
                          reportTechnical: AddReportEngineerCubit.of(context).reportSales.text,
                          context: context,
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ].paddingDirectional(bottom: 10),
            ),
          ],
        ),
      ),
    );
  }
}
