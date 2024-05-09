import 'package:cnattendance/model/member.dart';
import 'package:cnattendance/model/task.dart';
import 'package:cnattendance/screen/employer/allProject/data/dataSource/tasks_data_source.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/add_task_params.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/tasksBloc/state.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  static TasksCubit of(BuildContext context) => BlocProvider.of<TasksCubit>(context);
  final model = Get.find<ProjectDetailController>();
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
        model.project.value.tasks.add(
          Task(
            model.project.value.tasks.length,
            nameTasks.text,
            model.project.value.name,
            startDateController.text,
            endDateController.text,
            'Not Started',
          ),
        );
        showToast('Adding successfully');
        nameTasks.clear();
        startDateController.clear();
        endDateController.clear();
        descriptionTasks.clear();
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

  Future<void> editTasks({required int indexTask, required String projectId}) async {
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
      idTask: model.project.value.tasks[indexTask].id.toString(),
    ).then((value) {
      value.fold((l) {
        debugPrint('==== Error ====');
        debugPrint(l.errMessage);
        showToast(l.errMessage);

        emit(EditTasksErrorState());
      }, (r) async {
        model.project.value.tasks[indexTask] = Task(
          model.project.value.tasks[indexTask].id,
          nameTasks.text,
          model.project.value.name,
          DateFormat('MMM dd yyy').format(DateTime.parse(startDateController.text)).substring(0, 10),
          DateFormat('MMM dd yyy').format(DateTime.parse(endDateController.text)).substring(0, 10),
          model.project.value.tasks[indexTask].status,
          members: [selectedList],
        );
        nameTasks.clear();
        descriptionTasks.clear();
        startDateController.clear();
        endDateController.clear();
        selectedList = Member(-1, 'Name Engineer', 'image');
        showToast('Editing successfully');
        emit(EditTasksSuccessState());
      });
    });
  }

  void deleteTasks({required String idTask, required int index}) async {
    emit(DeleteTasksLoadingState());
    await TasksDataSource.postDeleteTask(
      idTask: idTask,
    ).then((value) {
      value.fold((l) {
        debugPrint('==== Error ====');
        debugPrint(l.errMessage);
        showToast(l.errMessage);

        emit(DeleteTasksErrorState());
      }, (r) async {
        model.project.value.tasks.removeAt(index);
        showToast('Success Deleted');
        emit(DeleteTasksSuccessState());
      });
    });
  }
}
