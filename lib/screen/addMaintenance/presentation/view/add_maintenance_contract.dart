import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_drop_down_menu.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/services/googleMap/google_map_no_scaffold.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/addMaintenance/presentation/manager/mainBlocMaintenanceContract/cubit.dart';
import 'package:cnattendance/screen/addMaintenance/presentation/manager/mainBlocMaintenanceContract/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddMaintenanceContract extends StatelessWidget {
  const AddMaintenanceContract({super.key});

  @override
  Widget build(BuildContext context) {
    const String orderType = 'Maintenance Engineer';
    final List<String> deviceType = ['ahmed', 'mahmoud', 'mohamed'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maintenance Contract',
          style: Styles.styleHeader,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.w),
        children: [
          CustomTextFormField(
            controller: MainBlocMaintenanceContractCubit.of(context).nameContract,
            hintText: 'name',
            fillColor: AppColors.cFillColorDropDownButton,
          ),
          CustomTextFormField(
            controller: MainBlocMaintenanceContractCubit.of(context).emailController,
            hintText: 'Email',
            fillColor: AppColors.cFillColorDropDownButton,
          ),
          CustomTextFormField(
            controller: MainBlocMaintenanceContractCubit.of(context).phoneController,
            hintText: 'Phone',
            fillColor: AppColors.cFillColorDropDownButton,
            textInputType: TextInputType.number,
          ),
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
              SizedBox(
                width: context.screenWidth * .47,
                child: CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'Model',
                  textInputType: TextInputType.number,
                  fillColor: AppColors.cFillColorDropDownButton,
                ),
              ),
              SizedBox(
                width: context.screenWidth * .47,
                child: CustomTextFormField(
                  controller: TextEditingController(),
                  hintText: 'Examination Date:',
                  textInputType: TextInputType.number,
                  fillColor: AppColors.cFillColorDropDownButton,
                ),
              ),
            ],
          ),
          CustomDropDownMenu(selectedItem: orderType, items: deviceType),
          BlocBuilder<MainBlocMaintenanceContractCubit, MainBlocMaintenanceContractState>(
            builder: (context, state) => CustomTextFormField(
              controller: MainBlocMaintenanceContractCubit.of(context).addressController,
              hintText: 'Address',
              fillColor: AppColors.cFillColorDropDownButton,
            ),
          ),
          GoogleMapWithoutScaffold(cubit: MainBlocMaintenanceContractCubit.of(context)),
          SafeArea(
            child: BlocBuilder<MainBlocMaintenanceContractCubit, MainBlocMaintenanceContractState>(
              builder: (context, state) => CustomTextButton(
                backgroundColor: AppColors.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.addMaintenance),
                    5.ESW(),
                    Text(
                      'Continue',
                      style: Styles.style16700.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
                onPress: () {
                  final arguments = {
                    'numberElevators': MainBlocMaintenanceContractCubit.of(context).numberController.text,
                  };
                  if (MainBlocMaintenanceContractCubit.of(context).numberController.text != '') {
                    showToast(MainBlocMaintenanceContractCubit.of(context).numberController.text);
                    Navigator.pushNamed(context, AppRoute.addElevator, arguments: arguments);
                  } else {
                    showToast('You must add number elevators');
                  }
                },
              ),
            ),
          ),
        ].paddingDirectional(top: 10.h),
      ),
    );
  }
}
