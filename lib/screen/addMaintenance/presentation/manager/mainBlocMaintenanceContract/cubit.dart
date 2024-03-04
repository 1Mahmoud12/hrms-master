import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/addMaintenance/data/dataSource/add_maintenance_periodic_data_source.dart';
import 'package:cnattendance/screen/addMaintenance/presentation/manager/mainBlocMaintenanceContract/state.dart';
import 'package:cnattendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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

  LatLng? currentLocation;

  Future<void> _getLocation() async {
    final location = Location();
    debugPrint('object');
    try {
      if (currentLocation == null) {
        await location.getLocation().then((value) {
          currentLocation = LatLng(value.latitude!, value.longitude!);
        });
      }
    } catch (error) {
      Utils.showToast(title: 'Please allow us to detect location', state: UtilState.warning);
    }
  }

  Future<void> addPeriodic({
    required BuildContext context,
  }) async {
    emit(AddPeriodicLoadingState());

    //  Navigator.of(context).pushNamedAndRemoveUntil(HomeDashboardScreen.routeName, (route) => false);
    //if (context.mounted) return;
    await _getLocation();
    await AddMaintenancePeriodicDataSource.addMaintenancePeriodic(
      cityController.text,
      nameContract.text,
      userCache!.id!.toString(),
      '${currentLocation!.longitude} ${currentLocation!.latitude}',
      numberController.text,
      modelElevator.text,
      numberStops.text,
      maximumLoad.text,
      installationDate.text,
      initialStatusElevator.text,
      checkBox == false ? '0' : '1',
    ).then((value) async {
      value.fold((error) {
        debugPrint('========= Error ========');

        debugPrint(error.errMessage);
        Utils.showToast(title: error.errMessage, state: UtilState.error);
        emit(AddPeriodicErrorState(error.errMessage));
      }, (success) async {
        emit(AddPeriodicSuccessState());
        Navigator.pushReplacementNamed(context, AppRoute.periodicMaintenanceScreenItems);
        nameContract.clear();
        cityController.clear();
        numberController.clear();
        modelElevator.clear();
        numberStops.clear();
        maximumLoad.clear();
        installationDate.clear();
        initialStatusElevator.clear();

        debugPrint('========= Success ========');
        Utils.showToast(title: success.message ?? '', state: UtilState.success);
      });
    });

    /* setState(() {
      _isLoading = false;
      EasyLoading.dismiss();
    });*/
  }

  @override
  Future<void> close() {
    nameContract.dispose();
    cityController.dispose();
    numberController.dispose();
    modelElevator.dispose();
    numberStops.dispose();
    maximumLoad.dispose();
    installationDate.dispose();
    initialStatusElevator.dispose();
    return super.close();
  }
}
