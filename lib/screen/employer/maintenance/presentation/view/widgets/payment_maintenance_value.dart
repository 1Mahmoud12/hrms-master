import 'dart:io';

import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/home_dashboard_screen.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/malfunctionBloc/cubit/malfunction_cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/malfunctionBloc/cubit/malfunction_state.dart';
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
        BlocListener<MalfunctionCubit, MalfunctionState>(
          listener: (context, state) {
            if (state is MalfunctionErrorState) {
              ErrorWidget(state.error);
            } else if (state is MalfunctionPaymentAddedState) {
              debugPrint('Success====> ');
              showToast('Your request has been sent successfully');
              Navigator.pushReplacementNamed(
                context,
                HomeDashboardScreen.routeName,
              );
            }
          },
          child: SizedBox(
            width: context.screenWidth,
            child: CustomTextButton(
              backgroundColor: AppColors.primaryColor,
              child: Text(
                'Send payment',
                style: Styles.style16700.copyWith(color: AppColors.white),
              ),
              onPress: () {
                if (MainBlocMaintenanceCubit.of(context).image != null) {
                  final File image =
                      BlocProvider.of<MainBlocMaintenanceCubit>(context).image!;

                  BlocProvider.of<MalfunctionCubit>(context).uploadPayment(
                    malfunctionId: userCache!.id!.toString(),
                    imageFile: image,
                  );

                  showToast('Successfully');
                } else {
                  showToast('You must upload Image');
                }
              },
            ),
          ),
        ),
      ],
      body: BlocBuilder<MainBlocMaintenanceCubit, MainBlocMaintenanceState>(
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
                        style: Styles.style16700
                            .copyWith(color: AppColors.primaryColor),
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
                  width: context.screenWidth * .9,
                  height: context.screenHeight * .3,
                  fit: BoxFit.fill,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
