import 'package:cnattendance/screen/employer/allProject/presentation/manager/progressBloc/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit() : super(ProgressInitial());

  static ProgressCubit of(BuildContext context) => BlocProvider.of<ProgressCubit>(context);

  List<String> statusList = ['In progress', 'Pending', 'Finished'];
  String selectedList = 'In progress';
  final List<Map<String, dynamic>> steps = [
    {
      'assets': Assets.stepOne,
      'value': '20',
      'nameStep': 'Step one',
      'description': 'description',
      'chooseStatus': 'Finished',
    },
    {
      'assets': Assets.stepOne,
      'value': '20',
      'nameStep': 'Step one',
      'description': 'description',
      'chooseStatus': 'Finished',
    },
  ];

  void addSelected({required String newSelected}) {
    selectedList = newSelected;
    emit(AddStatusState());
  }

  TextEditingController nameProgress = TextEditingController();
  TextEditingController descriptionProgress = TextEditingController();
  TextEditingController valueProgress = TextEditingController(text: '0.0');

  void addProgress() async {
    emit(AddProgressLoadingState());
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
      'value': valueProgress.text,
      'nameStep': nameProgress.text,
      'description': descriptionProgress.text,
      'chooseStatus': selectedList,
    });
    showToast('Adding successfully');
    emit(AddProgressSuccessState());
  }

  void editProgress({required int index}) async {
    emit(EditProgressLoadingState());
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

    steps.insert(index, {
      'assets': assets,
      'value': valueProgress.text,
      'nameStep': nameProgress.text,
      'description': descriptionProgress.text,
      'chooseStatus': selectedList
    });
    showToast('Editing successfully');
    emit(EditProgressSuccessState());
  }

  void deleteProgress({required int index}) {
    steps.removeAt(index);
    showToast('Success Deleted');
    emit(DeleteProgressSuccessState());
  }
}
