import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/component/number_month.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/model/member.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/tasksBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/tasksBloc/state.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/tasksScreen/drop_down_tasks.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditTasksScreen extends StatelessWidget {
  const EditTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.find<ProjectDetailController>();

    /*
      'nameStep':TasksCubit.of(context).steps[index]['nameStep'],
                      'description':TasksCubit.of(context).steps[index]['description'],
                      'chooseStatus':TasksCubit.of(context).steps[index]['chooseStatus'],
                      'value':TasksCubit.of(context).steps[index]['value'],
     */
    final argument = context.getArguments;

    final int index = argument['index'];

    TasksCubit.of(context).nameTasks.text = model.project.value.tasks[index].name!;
    TasksCubit.of(context).descriptionTasks.text = model.project.value.tasks[index].description ?? '';
    TasksCubit.of(context).startDateController.text = convertStringDateTime(model.project.value.tasks[index].date!);
    TasksCubit.of(context).endDateController.text = convertStringDateTime(model.project.value.tasks[index].endDate!);
    TasksCubit.of(context).selectedList =
        model.project.value.tasks[index].members!.isNotEmpty ? model.project.value.tasks[index].members![0] : Member(-1, 'Name Engineer', 'image');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Tasks',
          style: Styles.styleHeader,
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: CustomTextButton(
            backgroundColor: AppColors.primaryColor,
            onPress: () async {
              if (TasksCubit.of(context).nameTasks.text != '' && TasksCubit.of(context).descriptionTasks.text != '') {
                await TasksCubit.of(context)
                    .editTasks(idTask: model.project.value.tasks[index].id.toString(), projectId: model.project.value.id.toString());
                Navigator.pop(context);
                TasksCubit.of(context).nameTasks.clear();
                TasksCubit.of(context).descriptionTasks.clear();
                TasksCubit.of(context).startDateController.clear();
                TasksCubit.of(context).endDateController.clear();
                TasksCubit.of(context).selectedList = Member(-1, 'Name Engineer', 'image');
              } else {
                showToast('You must Input all fields');
              }
            },
            child: Text(
              'Edit',
              style: Styles.style14500.copyWith(color: AppColors.white),
            ),
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
                child: CustomTextFormField(fillColor: AppColors.white, controller: TasksCubit.of(context).nameTasks, hintText: 'Name Tasks'),
              );
            },
          ),
          BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) =>
                CustomDropDownMenuTasks(selectedItem: TasksCubit.of(context).selectedList, items: model.project.value.members),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2026))
                        .then((value) {
                      TasksCubit.of(context).startDateController.text = DateFormat('yyyy-MM-dd hh:mm').format(value!);
                    });
                  },
                  child: CustomTextFormField(
                    controller: TasksCubit.of(context).startDateController,
                    hintText: 'Start Date',
                    enabled: false,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2026))
                        .then((value) {
                      TasksCubit.of(context).endDateController.text = DateFormat('yyyy-MM-dd hh:mm').format(value!);
                    });
                  },
                  child: CustomTextFormField(
                    controller: TasksCubit.of(context).endDateController,
                    hintText: 'End Date',
                    enabled: false,
                  ),
                ),
              ),
            ],
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
/*
          BlocBuilder<TasksCubit, TasksState>(
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
          ),
*/
        ].paddingDirectional(bottom: context.screenHeight * .02),
      ),
    );
  }
}
