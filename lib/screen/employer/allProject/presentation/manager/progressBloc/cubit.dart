import 'package:cnattendance/screen/employer/allProject/presentation/manager/progressBloc/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit() : super(ProgressInitial());

  static ProgressCubit of(BuildContext context) => BlocProvider.of<ProgressCubit>(context);

  String status = 'In Progress';
  TextEditingController nameProgress = TextEditingController();
  TextEditingController descriptionProgress = TextEditingController();
  TextEditingController valueProgress = TextEditingController(text: '0.0');

  final List<Map<String, dynamic>> steps = [
    {
      'assets': Assets.stepOne,
      'value': '100',
      'nameStep': 'Step one',
      'description': 'description',
    },
  ];

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

    steps.add({'assets': assets, 'value': valueProgress.text, 'nameStep': nameProgress.text, 'description': descriptionProgress.text});
    showToast('Adding successfully');
    emit(AddProgressSuccessState());
  }
}
