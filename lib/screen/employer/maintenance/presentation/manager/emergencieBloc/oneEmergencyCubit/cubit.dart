import 'dart:convert';

import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/employer/maintenance/data/dataSource/emergencie_data_source.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/emergencieBloc/oneEmergencyCubit/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetOneEmergencyCubit extends Cubit<GetOneEmergencyState> {
  GetOneEmergencyCubit() : super(GetOneEmergencyInitial());

  static GetOneEmergencyCubit of(BuildContext context) => BlocProvider.of<GetOneEmergencyCubit>(context);

  void getOneEmergency({required BuildContext context, required String idEmergency}) async {
    emit(GetOneEmergencyLoadingState());

    await EmergencyDataSource.getOneEmergencie(idEmergency: idEmergency).then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        debugPrint('=== Error ====');
        emit(GetOneEmergencyErrorState(l.errMessage));
      }, (r) async {
        debugPrint('=== Success ====');

        await Preferences.setSaved(
          value: jsonEncode(r.toJson()),
          key: oneEmergencyKey,
        );
        oneEmergencyCache = r;

        emit(GetOneEmergencySuccessState());
      });
    });
  }
}
