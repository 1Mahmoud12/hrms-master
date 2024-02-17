import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/addMaintenance/presentation/manager/mainBlocMaintenanceContract/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBlocMaintenanceContractCubit extends Cubit<MainBlocMaintenanceContractState> {
  MainBlocMaintenanceContractCubit() : super(MainBlocMaintenanceContractInitial());

  static MainBlocMaintenanceContractCubit of(BuildContext context) => BlocProvider.of<MainBlocMaintenanceContractCubit>(context);

  void changeState() {
    addressController.text = locationCache;
    emit(SelectLocationState());
  }

  // toggle switch
  int indexList = 0;
  TextEditingController addressController = TextEditingController();
  TextEditingController nameContract = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController initialStatusElevator = TextEditingController();
  TextEditingController installationDate = TextEditingController();
  TextEditingController maximumLoad = TextEditingController();
  TextEditingController numberStops = TextEditingController();
  TextEditingController modelElevator = TextEditingController();

  List<String> maintenanceLabels = ['Emergency maintenance request', 'Malfunction maintenance', 'Request periodic maintenance'];

  void changeIndex({required int index}) {
    indexList = index;
    emit(ChangeIndexState());
  }

  bool checkBox = false;

  void changeCheckBox() {
    checkBox = !checkBox;
    emit(ChangeCheckBoxState());
  }
}
