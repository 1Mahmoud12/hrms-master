import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/tasksBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/tasksBloc/state.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.find<ProjectDetailController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasks',
          style: Styles.styleHeader.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (genderUser == RoleId.nine.name.tr)
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.addTasksScreen);
              },
              icon: const Icon(Icons.add),
            ),
        ],
      ),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) => ListView(
          padding: EdgeInsets.all(context.screenWidth * .02),
          children: [
            ...List.generate(
              model.project.value.tasks.length,
              (index) => Dismissible(
                key: Key(model.project.value.tasks[index].id!.toString()),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    Assets.trash,
                    width: context.screenWidth * .06,
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.blue,
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    Assets.edit,
                    colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                    width: context.screenWidth * .06,
                  ),
                ),
                confirmDismiss: (direction) async {
                  if (direction.index == 2) {
                    final argument = {
                      'index': index,
                    };
                    Navigator.pushNamed(context, AppRoute.editTasksScreen, arguments: argument);
                  } else {
                    TasksCubit.of(context).deleteTasks(index: index);
                  }
                  return false;
                },
                onDismissed: (direction) {},
                child: Container(
                  margin: EdgeInsets.all(context.screenWidth * .02),
                  padding: EdgeInsets.all(context.screenWidth * .02),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), color: AppColors.white),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: context.screenWidth * .4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: AppColors.cBackGroundIconButton, borderRadius: BorderRadius.circular(10.r)),
                        child: SvgPicture.asset(TasksCubit.of(context).imageTask[index % 5]),
                      ),
                      10.ESW(),
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.project.value.tasks[index].name ?? '',
                                  style: Styles.style14500.copyWith(fontSize: 15.sp, color: AppColors.textColorTextFormField),
                                ),
                                5.ESH(),
                                Text(
                                  model.project.value.tasks[index].status ?? '',
                                ),
                                5.ESH(),
                                /* SizedBox(
                                  width: context.screenWidth * .5,
                                  child: Text(TasksCubit.of(context).steps[index]['description']),
                                ),*/
                                5.ESH(),
                                /*SizedBox(
                                  height: context.screenHeight * .002,
                                  width: context.screenWidth * .5,
                                  child: SliderTheme(
                                    data: SliderThemeData(
                                      trackShape: CustomTrackShape(),
                                      //thumbColor: Colors.transparent,
                                      thumbShape: SliderComponentShape.noThumb,
                                      trackHeight: 2,
                                    ),
                                    child: Slider(
                                      value: double.parse(TasksCubit.of(context).steps[index]['value']) / 100,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),*/
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                Text(
                                  '${model.project.value.tasks[index].progress ?? 0}%',
                                  style: Styles.style14500.copyWith(fontSize: 15.sp, color: AppColors.textColorTextFormField),
                                ),
                                5.ESH(),
                                Text(
                                  model.project.value.tasks[index].endDate ?? '',
                                ),
                                5.ESH(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
