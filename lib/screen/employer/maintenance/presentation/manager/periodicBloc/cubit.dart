import 'dart:convert';

import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/employer/maintenance/data/dataSource/periodic_data_source.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/periodicBloc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeriodicCubit extends Cubit<PeriodicState> {
  PeriodicCubit() : super(PeriodicInitial());

  static PeriodicCubit of(BuildContext context) => BlocProvider.of<PeriodicCubit>(context);

  void getAllProposals({required BuildContext context}) async {
    emit(PeriodicLoadingState());

    //  Navigator.of(context).pushNamedAndRemoveUntil(HomeDashboardScreen.routeName, (route) => false);
    // Preferences.setSaved(value: RoleId.eight.name.tr, key: 'genderUser');
    //if (context.mounted) return;

    await PeriodicDataSource.getAllPeriodic().then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        debugPrint('Errrrrrrorrrrrrr');
        emit(PeriodicErrorState(l.errMessage));
      }, (r) async {
        await Preferences.setSaved(value: jsonEncode(r.toJson()), key: allPeridicsKey);
        allPeridicsCache = r;

        emit(PeriodicSuccessState());
      });
    });

    /* setState(() {
      _isLoading = false;
      EasyLoading.dismiss();
    });*/
  }
}
