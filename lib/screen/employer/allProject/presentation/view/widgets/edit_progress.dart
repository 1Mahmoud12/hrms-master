import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/progressBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/progressBloc/state.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/widgets/drop_down_progress.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProgressScreen extends StatelessWidget {
  const EditProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /*
      'nameStep':ProgressCubit.of(context).steps[index]['nameStep'],
                      'description':ProgressCubit.of(context).steps[index]['description'],
                      'chooseStatus':ProgressCubit.of(context).steps[index]['chooseStatus'],
                      'value':ProgressCubit.of(context).steps[index]['value'],
     */
    final argument = context.getArguments;
    ProgressCubit.of(context).nameProgress.text = argument['nameStep'];
    ProgressCubit.of(context).valueProgress.text = argument['value'];
    ProgressCubit.of(context).descriptionProgress.text = argument['description'];
    ProgressCubit.of(context).selectedList = argument['chooseStatus'];
    final int index = argument['index'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Progress',
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
              ProgressCubit.of(context).editProgress(index: index);
              Navigator.pop(context);
              ProgressCubit.of(context).nameProgress.clear();
              ProgressCubit.of(context).valueProgress.clear();
              ProgressCubit.of(context).descriptionProgress.clear();
            } else {
              showToast('You must Input all fields');
            }
          },
          child: Text(
            'Edit',
            style: Styles.style14500.copyWith(color: AppColors.white),
          ),
        ),
      ],
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .05),
        children: [
          BlocBuilder<ProgressCubit, ProgressState>(
            builder: (context, state) {
              return SizedBox(
                width: context.screenWidth * .2,
                child: CustomTextFormField(fillColor: AppColors.white, controller: ProgressCubit.of(context).nameProgress, hintText: 'Name Progress'),
              );
            },
          ),
          BlocBuilder<ProgressCubit, ProgressState>(
            builder: (context, state) =>
                CustomDropDownMenuProgress(selectedItem: ProgressCubit.of(context).selectedList, items: ProgressCubit.of(context).statusList),
          ),
          BlocBuilder<ProgressCubit, ProgressState>(
            builder: (context, state) {
              return SizedBox(
                width: context.screenWidth * .2,
                child: CustomTextFormField(
                  controller: ProgressCubit.of(context).descriptionProgress,
                  hintText: 'Description Progress',
                  fillColor: AppColors.white,
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
                  fillColor: AppColors.white,
                  validationOnNumber: true,
                  controller: ProgressCubit.of(context).valueProgress,
                  hintText: 'Value Progress',
                  textInputType: TextInputType.number,
                ),
              );
            },
          ),
        ].paddingDirectional(bottom: context.screenHeight * .02),
      ),
    );
  }
}
