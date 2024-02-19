import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/proposal_one_model.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/addReportEngineerBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/addReportEngineerBloc/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/details_elevator.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailsProposalScreen extends StatefulWidget {
  const DetailsProposalScreen({super.key});

  @override
  State<DetailsProposalScreen> createState() => _DetailsProposalScreenState();
}

class _DetailsProposalScreenState extends State<DetailsProposalScreen> {
  TextEditingController reportEngineer = TextEditingController();
  TextEditingController reportSales = TextEditingController();
  TextEditingController costReportEngineer = TextEditingController();

  Map<String, dynamic> argument = {};
  int? index;
  int? formRequestId;
  ProposalOneModel? proposalOneModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    argument = context.getArguments;
    index = argument['index'];
    formRequestId = argument['formRequestId'];
    proposalOneModel = argument['oneProposal'];
    reportEngineer.text = proposalOneModel!.data!.report?.reportEngineer ?? '';
    reportSales.text = proposalOneModel!.data!.report?.reportTechnical ?? '';
    costReportEngineer.text = proposalOneModel!.data!.report?.costs ?? '';
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    reportEngineer.dispose();
    reportSales.dispose();
    costReportEngineer.dispose();
    debugPrint('============= Closing =====================');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        nameDetails: proposalOneModel!.data!.formRequest!.formData!.userNameLabel ?? '',
                        executeDetails: proposalOneModel!.data!.formRequest!.formData!.userNameValue ?? 'N/A',
                      ),
                      DetailsElevatorRow(
                        nameDetails: proposalOneModel!.data!.formRequest!.formData!.userEmailLabel ?? '',
                        executeDetails: proposalOneModel!.data!.formRequest!.formData!.userEmailValue ?? 'N/A',
                      ),
                      DetailsElevatorRow(
                        nameDetails: proposalOneModel!.data!.formRequest!.formData!.phoneNumberLabel ?? '',
                        executeDetails: proposalOneModel!.data!.formRequest!.formData!.phoneNumberValue ?? 'N/A',
                      ),
                      DetailsElevatorRow(
                        nameDetails: proposalOneModel!.data!.formRequest!.formData!.userAgeLabel ?? '',
                        executeDetails: proposalOneModel!.data!.formRequest!.formData!.userAgeValue ?? 'N/A',
                      ),
                      DetailsElevatorRow(
                        nameDetails: proposalOneModel!.data!.formRequest!.formData!.userGenderLabel ?? '',
                        executeDetails: proposalOneModel!.data!.formRequest!.formData!.userGenderValue ?? 'N/A',
                      ),
                      DetailsElevatorRow(
                        nameDetails: proposalOneModel!.data!.formRequest!.formData!.userAddressLabel ?? '',
                        executeDetails: proposalOneModel!.data!.formRequest!.formData!.userAddressValue ?? 'N/A',
                      ),
                    ].paddingDirectional(bottom: context.screenHeight * .01),
                  ),
                ),
                /*  Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        'Products',
                        style: Styles.styleHeader,
                      ),
                    ],
                  ),
                ),
                ...List.generate(
                  proposalOneModel!.data!.products!.length,
                  (index) => Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.white,
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  proposalOneModel!.data!.products![index].name ?? '',
                                  style: Styles.style16700,
                                ),
                                // const Spacer(),
                                Text(
                                  proposalOneModel!.data!.products![index].quantity.toString(),
                                  style: Styles.style16700,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  proposalOneModel!.data!.products![index].salePrice.toString(),
                                  style: Styles.style16700,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),*/
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Report Sales',
                    style: Styles.styleHeader,
                  ),
                ),
                BlocBuilder<AddReportEngineerCubit, AddReportEngineerState>(
                  builder: (context, state) => CustomTextFormField(
                    controller: reportSales,
                    hintText: 'Description',
                    maxLines: 10,
                    enabled: genderUser == RoleId.twelve.name.tr,
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
                    controller: reportEngineer,
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
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: genderUser == RoleId.nine.name.tr ? Colors.transparent : AppColors.grey.withOpacity(.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: costReportEngineer,
                                  style: Styles.style16700,
                                  decoration: InputDecoration(
                                    hintText: '0.0',
                                    hintStyle: Styles.style16700,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                                    fillColor: AppColors.transparent,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(color: Colors.transparent),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(color: Colors.transparent),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(color: Colors.transparent),
                                    ),
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
                          formRequestId: formRequestId!,
                          cost: costReportEngineer.text,
                          reportEngineer: reportEngineer.text,
                          reportSales: reportSales.text,
                          context: context,
                          reportId: proposalOneModel!.data!.report!.reportTechnical != null ? proposalOneModel!.data!.report!.id!.toString() : null,
                        );
                      } else {
                        AddReportEngineerCubit.of(context).postReportSales(
                          formRequestId: formRequestId!,
                          reportSales: reportSales.text,
                          context: context,
                          reportId: proposalOneModel!.data!.report?.reportTechnical != null ? proposalOneModel!.data!.report!.id!.toString() : null,
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
