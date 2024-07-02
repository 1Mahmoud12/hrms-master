import 'package:bloc/bloc.dart';
import 'package:cnattendance/screen/profile/dataSource/reset_password_data_source.dart';
import 'package:cnattendance/screen/profile/manager/resetPasswordBloc/cubit/reset_password_state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(RestPasswordInitial());
  Future<void> resetPassword({required String email}) async {
    try {
      emit(RestPasswordLoading());
      ResetPasswordDataSource().resetPassword(email).then(
            (value) => {
              value.fold((l) {
                debugPrint(l.errMessage);
                showToast(l.errMessage);
                debugPrint('=== Error ====');
                emit(RestPasswordError(l.errMessage));
              }, (r) async {
                debugPrint('=== Success ====');

                emit(RestPasswordSuccess());
              }),
            },
          );
      emit(RestPasswordInitial());
    } catch (e) {
      emit(RestPasswordError(e.toString()));
    }
  }
}
