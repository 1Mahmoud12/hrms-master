import 'package:cnattendance/model/member.dart';
import 'package:cnattendance/screen/employer/allProject/data/dataSource/tasks_data_source.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/add_task_params.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/tasksBloc/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  static TasksCubit of(BuildContext context) => BlocProvider.of<TasksCubit>(context);

  Member selectedList = Member(-1, 'Name Engineer', '');
  final List<Map<String, dynamic>> steps = [
    {
      'assets': Assets.stepOne,
      'value': '100',
      'nameStep': 'Step one',
      'nameEngineer': 'Mohamed',
      'description': 'description',
      'chooseStatus': 'Finished',
    },
  ];

  void addSelected({required Member newSelected}) {
    selectedList = newSelected;
    emit(AddStatusState());
  }

  TextEditingController nameTasks = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionTasks = TextEditingController();

  void addTasks({required String projectId}) async {
    emit(AddTasksLoadingState());
    await TasksDataSource.postAddTasks(
      addTaskParams: AddTaskParams(
        nameTask: nameTasks.text,
        descriptionTask: descriptionTasks.text,
        startDateTask: startDateController.text,
        endDateTask: endDateController.text,
        assignedMemberTask: selectedList.id.toString(),
        projectId: projectId,
      ),
    ).then((value) {
      value.fold((l) {
        debugPrint('==== Error ====');
        debugPrint(l.errMessage);
        showToast(l.errMessage);

        emit(AddTasksErrorState());
      }, (r) async {
        showToast('Adding successfully');
        emit(AddTasksSuccessState());
      });
    });
  }

  List<String> imageTask = [
    Assets.stepOne,
    Assets.stepTwo,
    Assets.stepThree,
    Assets.stepFour,
    Assets.stepFive,
  ];

  Future<void> editTasks({required String idTask, required String projectId}) async {
    emit(EditTasksLoadingState());
    await TasksDataSource.postEditTasks(
      addTaskParams: AddTaskParams(
        nameTask: nameTasks.text,
        descriptionTask: descriptionTasks.text,
        startDateTask: startDateController.text,
        endDateTask: endDateController.text,
        assignedMemberTask: selectedList.id.toString(),
        projectId: projectId,
      ),
      idTask: idTask,
    ).then((value) {
      value.fold((l) {
        debugPrint('==== Error ====');
        debugPrint(l.errMessage);
        showToast(l.errMessage);

        emit(AddTasksErrorState());
      }, (r) async {
        showToast('Adding successfully');
        emit(AddTasksSuccessState());
      });
    });
    showToast('Editing successfully');
    emit(EditTasksSuccessState());
  }

  void deleteTasks({required int index}) {
    steps.removeAt(index);
    showToast('Success Deleted');
    emit(DeleteTasksSuccessState());
  }
}
