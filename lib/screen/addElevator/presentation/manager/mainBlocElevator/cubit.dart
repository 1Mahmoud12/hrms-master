import 'package:cnattendance/screen/addElevator/presentation/manager/mainBlocElevator/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ElevatorDropDown { Elevator_type, Elevator_Subtype, Order_Type }

class MainBlocElevatorCubit extends Cubit<MainBlocElevatorState> {
  MainBlocElevatorCubit() : super(MainBlocElevatorInitialState());

  static MainBlocElevatorCubit of(BuildContext context) => BlocProvider.of<MainBlocElevatorCubit>(context);

  String elevatorType = 'Elevator type';
  String elevatorSubtype = 'Elevator Subtype';
  String orderType = 'Order Type';

  final List<String> elevatorTypeList = [
    'A',
    'B',
    'C',
  ];
  final List<Map<String, dynamic>> elevator = [];

  void changeElevatorType({required String elevatorTypeSelected}) {
    elevatorType = elevatorTypeSelected;
    emit(ChangeIndexState());
  }

  void changeElevatorSubtype({required String elevatorSubTypeSelected}) {
    elevatorSubtype = elevatorSubTypeSelected;
    emit(ChangeIndexState());
  }

  void changeElevatorOrderType({required String elevatorOrderSelected}) {
    orderType = elevatorOrderSelected;
    emit(ChangeIndexState());
  }
}
