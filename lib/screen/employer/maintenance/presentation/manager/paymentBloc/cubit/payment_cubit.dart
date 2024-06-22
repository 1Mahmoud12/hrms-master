import 'dart:convert';
import 'dart:io';

import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/employer/maintenance/data/dataSource/payment_data_source.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/paymentBloc/cubit/payment_state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit of(BuildContext context) =>
      BlocProvider.of<PaymentCubit>(context);

  void getOnePayment({
    required BuildContext context,
    required String idPayment,
  }) async {
    emit(PaymentLoadingState());

    await PaymentDataSource.getOnePayment(idPayment: idPayment)
        .then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        debugPrint('=== Error ====');
        emit(PaymentErrorState(l.errMessage));
      }, (r) async {
        debugPrint('=== Success ====');

        await Preferences.setSaved(
          value: jsonEncode(r.toJson()),
          key: onePaymentKey,
        );
        onePaymentCache = r;

        emit(PaymentSuccessState());
      });
    });
  }

  void appPayment({
    required String emrgencieId,
    required File imageFile,
  }) async {
    emit(PaymentLoadingState());

    try {
      await PaymentDataSource.addPayment(
        emrgencieId: emrgencieId,
        imageFile: imageFile,
      );
      emit(PaymentAddedState());
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
      emit(PaymentErrorState(error.toString()));
    }
  }
}
