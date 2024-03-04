import 'dart:convert';

import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/employer/maintenance/data/dataSource/elevators_data_source.dart';
import 'package:cnattendance/screen/employer/maintenance/data/model/one_elevator_model.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/oneElevatorBloc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OneElevatorCubit extends Cubit<OneElevatorState> {
  OneElevatorCubit() : super(OneElevatorInitial());

  static OneElevatorCubit of(BuildContext context) => BlocProvider.of<OneElevatorCubit>(context);
  OneElevatorModel? oneElevatorModel;

  void getAllOneElevator({required BuildContext context, required String idElevator}) async {
    emit(OneElevatorLoadingState());

    await ElevatorDataSource.getOneElevator(idElevator: idElevator).then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        debugPrint('=== Error ====');
        emit(OneElevatorErrorState(l.errMessage));
      }, (success) async {
        debugPrint('=== Success ====');

        await Preferences.setSaved(value: jsonEncode(success.toJson()), key: allPeridicsKey);
        oneElevatorModel = success;

        emit(OneElevatorSuccessState());
      });
    });
  }
}
