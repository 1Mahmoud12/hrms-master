import 'dart:convert';

import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/employer/maintenance/data/dataSource/elevators_data_source.dart';
import 'package:cnattendance/screen/employer/maintenance/data/model/all_elevators_model.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/elevatorsBloc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElevatorsCubit extends Cubit<ElevatorsState> {
  ElevatorsCubit() : super(ElevatorsInitial());

  static ElevatorsCubit of(BuildContext context) => BlocProvider.of<ElevatorsCubit>(context);
  AllElevatorsModel? allElevatorsModel;

  void getAllElevators({required BuildContext context, required String idPeriodic}) async {
    emit(ElevatorsLoadingState());

    await ElevatorDataSource.getAllElevators(idPeriodic: idPeriodic).then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        debugPrint('=== Error ====');
        emit(ElevatorsErrorState(l.errMessage));
      }, (success) async {
        debugPrint('=== Success ====');

        await Preferences.setSaved(value: jsonEncode(success.toJson()), key: allPeridicsKey);
        allElevatorsModel = success;

        emit(ElevatorsSuccessState());
      });
    });
  }
}
