import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/employer/maintenance/data/dataSource/malfunction_data_source.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/malfunctionBloc/cubit/malfunction_state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MalfunctionCubit extends Cubit<MalfunctionState> {
  MalfunctionCubit() : super(MalfunctionInitial());

  static MalfunctionCubit of(BuildContext context) =>
      BlocProvider.of<MalfunctionCubit>(context);

  void getAllProposals({required BuildContext context}) async {
    emit(MalfunctionLoadingState());

    await MalfunctionDataSource.getAllMalfunctions().then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        debugPrint('=== Error ====');
        emit(MalfunctionErrorState(l.errMessage));
      }, (r) async {
        debugPrint('=== Success ====');

        await Preferences.setSaved(
          value: jsonEncode(r.toJson()),
          key: allMalfunctionsKey,
        );
        allMalfunctionCache = r;

        emit(MalfunctionSuccessState());
      });
    });
  }

  void addMalfunction({
    required String name,
    required String description,
    required String location,
    required File imageFile,
  }) async {
    emit(MalfunctionLoadingState());

    try {
      await MalfunctionDataSource.addMalfunction(
        name: name,
        description: description,
        location: location,
        imageFile: imageFile,
      );
      emit(MalfunctionAddedState());
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
      emit(MalfunctionErrorState(error.toString()));
    }
  }


 void uploadPayment({
    required String malfunctionId,
  
    required File imageFile,
  }) async {
    emit(MalfunctionLoadingState());

    try {
      await MalfunctionDataSource.uploadPayment(
        malfunctionId: malfunctionId,
       
        imageFile: imageFile,
      );
      emit(MalfunctionPaymentAddedState());
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
      emit(MalfunctionErrorState(error.toString()));
    }
  }







}
