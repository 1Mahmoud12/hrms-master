import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/progressBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/progressBloc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProgressScreen extends StatelessWidget {
  const AddProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Progress',
          style: Styles.styleHeader,
        ),
      ),
      persistentFooterButtons: [
        CustomTextButton(
            backgroundColor: AppColors.primaryColor,
            onPress: () {
              if (ProgressCubit.of(context).nameProgress.text != '' &&
                  ProgressCubit.of(context).valueProgress.text != '' &&
                  ProgressCubit.of(context).descriptionProgress.text != '') {
                ProgressCubit.of(context).addProgress();
                Navigator.pop(context);
                ProgressCubit.of(context).nameProgress.clear();
                ProgressCubit.of(context).valueProgress.clear();
                ProgressCubit.of(context).descriptionProgress.clear();
              } else {
                showToast('You must Input all fields');
              }
            },
            child: Text(
              'Add',
              style: Styles.style14500.copyWith(color: AppColors.white),
            ))
      ],
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .05),
        children: [
          BlocBuilder<ProgressCubit, ProgressState>(
            builder: (context, state) {
              return SizedBox(
                width: context.screenWidth * .2,
                child: CustomTextFormField(controller: ProgressCubit.of(context).nameProgress, hintText: 'Name Progress'),
              );
            },
          ),
          BlocBuilder<ProgressCubit, ProgressState>(
            builder: (context, state) {
              return SizedBox(
                width: context.screenWidth * .2,
                child: CustomTextFormField(
                  controller: ProgressCubit.of(context).descriptionProgress,
                  hintText: 'Description Progress',
                  maxLines: 5,
                ),
              );
            },
          ),
          BlocBuilder<ProgressCubit, ProgressState>(
            builder: (context, state) {
              return SizedBox(
                width: context.screenWidth * .2,
                child: CustomTextFormField(
                    validationOnNumber: true,
                    controller: ProgressCubit.of(context).valueProgress,
                    hintText: 'Value Progress',
                    textInputType: TextInputType.number),
              );
            },
          ),
        ].paddingDirectional(bottom: context.screenHeight * .02),
      ),
    );
  }
}
