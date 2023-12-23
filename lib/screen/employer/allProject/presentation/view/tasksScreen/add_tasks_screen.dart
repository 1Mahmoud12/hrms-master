import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/tasksBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/tasksBloc/state.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/tasksScreen/drop_down_tasks.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTasksScreen extends StatelessWidget {
  const AddTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TasksCubit.of(context).nameTasks.clear();
    TasksCubit.of(context).descriptionTasks.clear();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Tasks',
          style: Styles.styleHeader,
        ),
      ),
      persistentFooterButtons: [
        CustomTextButton(
          backgroundColor: AppColors.primaryColor,
          onPress: () {
            if (TasksCubit.of(context).nameTasks.text != '' && TasksCubit.of(context).descriptionTasks.text != '') {
              TasksCubit.of(context).addTasks();
              Navigator.pop(context);
              TasksCubit.of(context).nameTasks.clear();
              TasksCubit.of(context).descriptionTasks.clear();
            } else {
              showToast('You must Input all fields');
            }
          },
          child: Text(
            'Add',
            style: Styles.style14500.copyWith(color: AppColors.white),
          ),
        ),
      ],
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .05),
        children: [
          BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              return SizedBox(
                width: context.screenWidth * .2,
                child: CustomTextFormField(controller: TasksCubit.of(context).nameTasks, hintText: 'Name Tasks'),
              );
            },
          ),
          BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) =>
                CustomDropDownMenuTasks(selectedItem: TasksCubit.of(context).selectedList, items: TasksCubit.of(context).statusList),
          ),
          BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              return SizedBox(
                width: context.screenWidth * .2,
                child: CustomTextFormField(
                  controller: TasksCubit.of(context).descriptionTasks,
                  hintText: 'Description Tasks',
                  fillColor: AppColors.white,
                  maxLines: 5,
                ),
              );
            },
          ),
          /*BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              return SizedBox(
                width: context.screenWidth * .2,
                child: CustomTextFormField(
                  fillColor: AppColors.white,
                  validationOnNumber: true,
                  controller: TasksCubit.of(context).valueTasks,
                  hintText: 'Value Tasks',
                  textInputType: TextInputType.number,
                ),
              );
            },
          ),*/
        ].paddingDirectional(bottom: context.screenHeight * .02),
      ),
    );
  }
}
