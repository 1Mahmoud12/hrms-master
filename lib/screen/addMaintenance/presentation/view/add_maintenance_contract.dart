import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_check_box.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/utils.dart';
import 'package:cnattendance/screen/addMaintenance/presentation/manager/mainBlocMaintenanceContract/cubit.dart';
import 'package:cnattendance/screen/addMaintenance/presentation/manager/mainBlocMaintenanceContract/state.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMaintenanceContract extends StatelessWidget {
  const AddMaintenanceContract({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maintenance Contract',
          style: Styles.styleHeader,
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        BlocBuilder<MainBlocMaintenanceContractCubit, MainBlocMaintenanceContractState>(
          builder: (context, state) => CustomTextButton(
            backgroundColor: AppColors.primaryColor,
            child: Text(
              'Submit',
              style: Styles.style16700.copyWith(color: AppColors.white),
            ),
            onPress: () {
              if (MainBlocMaintenanceContractCubit.of(context).nameContract.text.isNotEmpty &&
                  MainBlocMaintenanceContractCubit.of(context).cityController.text.isNotEmpty &&
                  MainBlocMaintenanceContractCubit.of(context).numberController.text.isNotEmpty &&
                  MainBlocMaintenanceContractCubit.of(context).modelElevator.text.isNotEmpty &&
                  MainBlocMaintenanceContractCubit.of(context).numberStops.text.isNotEmpty &&
                  MainBlocMaintenanceContractCubit.of(context).maximumLoad.text.isNotEmpty &&
                  MainBlocMaintenanceContractCubit.of(context).installationDate.text.isNotEmpty &&
                  MainBlocMaintenanceContractCubit.of(context).initialStatusElevator.text.isNotEmpty) {
                Utils.showToast(title: 'The request has been sent successfully', state: UtilState.success);
                Navigator.pushReplacementNamed(context, AppRoute.periodicMaintenanceScreenItems);
                MainBlocMaintenanceContractCubit.of(context).nameContract.clear();
                MainBlocMaintenanceContractCubit.of(context).cityController.clear();
                MainBlocMaintenanceContractCubit.of(context).numberController.clear();
                MainBlocMaintenanceContractCubit.of(context).modelElevator.clear();
                MainBlocMaintenanceContractCubit.of(context).numberStops.clear();
                MainBlocMaintenanceContractCubit.of(context).maximumLoad.clear();
                MainBlocMaintenanceContractCubit.of(context).installationDate.clear();
                MainBlocMaintenanceContractCubit.of(context).initialStatusElevator.clear();
              } else {
                Utils.showToast(title: 'You must input all fields', state: UtilState.warning);
              }
              /*final arguments = {
                'numberElevators': MainBlocMaintenanceContractCubit.of(context).numberController.text,
              };
              if (MainBlocMaintenanceContractCubit.of(context).numberController.text != '') {
                showToast(MainBlocMaintenanceContractCubit.of(context).numberController.text);
                Navigator.pushNamed(context, AppRoute.addElevator, arguments: arguments);
              } else {
                showToast('You must add number elevators');
              }*/
            },
          ),
        ),
      ],
      body: ListView(
        padding: EdgeInsets.all(10.w),
        children: [
          CustomTextFormField(
            controller: MainBlocMaintenanceContractCubit.of(context).nameContract,
            hintText: 'name',
            fillColor: AppColors.cFillColorDropDownButton,
          ),
          CustomTextFormField(
            controller: MainBlocMaintenanceContractCubit.of(context).cityController,
            hintText: 'City',
            fillColor: AppColors.cFillColorDropDownButton,
          ),
          /*  CustomTextFormField(
            controller: MainBlocMaintenanceContractCubit.of(context).phoneController,
            hintText: 'Phone',
            fillColor: AppColors.cFillColorDropDownButton,
            textInputType: TextInputType.number,
          ),*/
          CustomTextFormField(
            controller: MainBlocMaintenanceContractCubit.of(context).numberController,
            hintText: 'Number of Elevators',
            fillColor: AppColors.cFillColorDropDownButton,
            textInputType: TextInputType.number,
          ),
          Text(
            'Elevator Details',
            style: Styles.style18700.copyWith(color: Colors.black),
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: MainBlocMaintenanceContractCubit.of(context).modelElevator,
                  hintText: 'Model',
                  textInputType: TextInputType.number,
                  fillColor: AppColors.cFillColorDropDownButton,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: MainBlocMaintenanceContractCubit.of(context).numberStops,
                  hintText: 'Number of Stops',
                  textInputType: TextInputType.number,
                  fillColor: AppColors.cFillColorDropDownButton,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: MainBlocMaintenanceContractCubit.of(context).maximumLoad,
                  hintText: 'Maximum Load',
                  textInputType: TextInputType.number,
                  fillColor: AppColors.cFillColorDropDownButton,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: MainBlocMaintenanceContractCubit.of(context).installationDate,
                  hintText: 'Installation Date',
                  textInputType: TextInputType.number,
                  fillColor: AppColors.cFillColorDropDownButton,
                ),
              ),
            ],
          ),
          CustomTextFormField(
            controller: MainBlocMaintenanceContractCubit.of(context).initialStatusElevator,
            hintText: 'Initial status of the elevator',
            textInputType: TextInputType.emailAddress,
            fillColor: AppColors.cFillColorDropDownButton,
            maxLines: 5,
          ),
          Text(
            'Is there an elevator monitoring company or not?',
            style: Styles.style16700.copyWith(fontWeight: FontWeight.w400),
          ),
          Row(
            children: [
              BlocBuilder<MainBlocMaintenanceContractCubit, MainBlocMaintenanceContractState>(
                builder: (context, state) => Expanded(
                  child: CustomCheckBox(
                    onTap: () => MainBlocMaintenanceContractCubit.of(context).changeCheckBox(),
                    textValue: 'yes',
                    checkBox: MainBlocMaintenanceContractCubit.of(context).checkBox,
                  ),
                ),
              ),
              BlocBuilder<MainBlocMaintenanceContractCubit, MainBlocMaintenanceContractState>(
                builder: (context, state) => Expanded(
                  child: CustomCheckBox(
                    onTap: () => MainBlocMaintenanceContractCubit.of(context).changeCheckBox(),
                    textValue: 'No',
                    checkBox: !MainBlocMaintenanceContractCubit.of(context).checkBox,
                  ),
                ),
              ),
            ],
          ),
        ].paddingDirectional(top: 10.h),
      ),
    );
  }
}
