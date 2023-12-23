import 'package:cnattendance/screen/employer/allProject/presentation/manager/tasksBloc/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  static TasksCubit of(BuildContext context) => BlocProvider.of<TasksCubit>(context);

  List<String> statusList = ['Mohamed', 'Ahmed', 'Ismail'];
  String selectedList = 'Name Engineer';
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

  void addSelected({required String newSelected}) {
    selectedList = newSelected;
    emit(AddStatusState());
  }

  TextEditingController nameTasks = TextEditingController();
  TextEditingController descriptionTasks = TextEditingController();

  void addTasks() async {
    emit(AddTasksLoadingState());
    String assets = '';
    if ((steps.length % 5) == 0) {
      assets = Assets.stepOne;
    } else if ((steps.length % 5) == 1) {
      assets = Assets.stepTwo;
    } else if ((steps.length % 5) == 2) {
      assets = Assets.stepThree;
    } else if ((steps.length % 5) == 3) {
      assets = Assets.stepFour;
    } else if ((steps.length % 5) == 4) {
      assets = Assets.stepFive;
    }

    steps.add({
      'assets': assets,
      'nameStep': nameTasks.text,
      'description': descriptionTasks.text,
      'nameEngineer': selectedList,
    });
    showToast('Adding successfully');
    emit(AddTasksSuccessState());
  }

  void editTasks({required int index}) async {
    emit(EditTasksLoadingState());
    steps.removeAt(index);
    String assets = '';
    if ((steps.length % 5) == 0) {
      assets = Assets.stepOne;
    } else if ((steps.length % 5) == 1) {
      assets = Assets.stepTwo;
    } else if ((steps.length % 5) == 2) {
      assets = Assets.stepThree;
    } else if ((steps.length % 5) == 3) {
      assets = Assets.stepFour;
    } else if ((steps.length % 5) == 4) {
      assets = Assets.stepFive;
    }

    steps.insert(index, {'assets': assets, 'nameStep': nameTasks.text, 'description': descriptionTasks.text, 'nameEngineer': selectedList});
    showToast('Editing successfully');
    emit(EditTasksSuccessState());
  }

  void deleteTasks({required int index}) {
    steps.removeAt(index);
    showToast('Success Deleted');
    emit(DeleteTasksSuccessState());
  }
}
