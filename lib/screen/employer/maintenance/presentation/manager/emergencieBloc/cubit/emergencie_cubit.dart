import 'dart:convert';
import 'dart:io';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/employer/maintenance/data/dataSource/emergencie_data_source.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/emergencieBloc/cubit/emergencie_state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmergencieCubit extends Cubit<EmergencieState> {
  EmergencieCubit() : super(EmergencieInitial());

  static EmergencieCubit of(BuildContext context) =>
      BlocProvider.of<EmergencieCubit>(context);

  void getAllProposals({required BuildContext context}) async {
    emit(EmergencieLoadingState());

    await EmergencieDataSource.getAllEmergencies().then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        debugPrint('=== Error ====');
        emit(EmergencieErrorState(l.errMessage));
      }, (r) async {
        debugPrint('=== Success ====');

        await Preferences.setSaved(
          value: jsonEncode(r.toJson()),
          key: allEmergenciesKey,
        );
        allEmergenciesCache = r;

        emit(EmergencieSuccessState());
      });
    });
  }

  void addEmergency({
    required String name,
    required String description,
    required String location,
    required File imageFile,
  }) async {
    emit(EmergencieLoadingState());

    try {
      await EmergencieDataSource.addEmergency(
        name: name,
        description: description,
        location: location,
        imageFile: imageFile,
      );
      emit(EmergencieAddedState());
      // result.fold(
      //   (failure) {
      //     debugPrint('Error: ${failure.errMessage}');
      //     showToast(failure.errMessage);
      //     emit(EmergencieErrorState(failure.errMessage));
      //   },
      //   (r) {
      //     debugPrint('Success: ${r.toJson()}');
      //     emit(EmergencieAddedState()); // Emit this state first
      //     emit(EmergencieSuccessState()); // Then emit success state
      //   },
      // );
    } catch (error) {
      debugPrint('Error: $error');
      emit(EmergencieErrorState(error.toString()));
    }
  }



}
