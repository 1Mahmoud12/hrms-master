import 'package:cnattendance/screen/employer/main_screen_employer/manager/maniBloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBlocHomeCustomerCubit extends Cubit<MainBlocHomeCustomerState> {
  MainBlocHomeCustomerCubit() : super(MainBlocHomeCustomerInitial());

  static MainBlocHomeCustomerCubit of(BuildContext context) => BlocProvider.of<MainBlocHomeCustomerCubit>(context);

  bool isExpandedKnows = false;
  void changeState() {
    isExpandedKnows = !isExpandedKnows;
    debugPrint('ChangeObscureState');
    emit(ChangeObscureState());
  }
}
