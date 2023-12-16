import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/ProjectsScreen/home_dashboard_screen.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMaintenanceValue extends StatelessWidget {
  const PaymentMaintenanceValue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment of maintenance value',
          style: Styles.style18700.copyWith(color: AppColors.primaryColor),
        ),
        elevation: 2,
      ),
      persistentFooterButtons: [
        SizedBox(
          width: context.screenWidth,
          child: CustomTextButton(
            backgroundColor: AppColors.primaryColor,
            child: Text(
              'Send payment',
              style: Styles.style16700.copyWith(color: AppColors.white),
            ),
            onPress: () {
              if (MainBlocMaintenanceCubit.of(context).image != null) {
                showToast('Successfully');
                Navigator.pushReplacementNamed(context, HomeDashboardScreen.routeName);
              } else {
                showToast('You must upload Image');
              }
            },
          ),
        ),
      ],
      body: BlocBuilder<MainBlocMaintenanceCubit, MainBlocMaintenanceState>(
        builder: (context, state) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (MainBlocMaintenanceCubit.of(context).image == null)
              Padding(
                padding: const EdgeInsets.all(8.0),
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
              Center(
                child: Image.file(
                  MainBlocMaintenanceCubit.of(context).image!,
                  width: context.screenWidth * .95,
                ),
              )
          ],
        ),
      ),
    );
  }
}
