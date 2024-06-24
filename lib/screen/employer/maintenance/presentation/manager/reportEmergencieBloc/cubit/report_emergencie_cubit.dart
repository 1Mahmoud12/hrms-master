import 'package:bloc/bloc.dart';
import 'package:cnattendance/screen/employer/maintenance/data/dataSource/report_emergencie_data_source.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/reportEmergencieBloc/cubit/report_emergencie_state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ReportEmergencieCubit extends Cubit<ReportEmergencieState> {
  ReportEmergencieCubit() : super(ReportEmergencieInitialState());

  static ReportEmergencieCubit of(BuildContext context) =>
      BlocProvider.of<ReportEmergencieCubit>(context);

  String selectedStatus = '';
  String selectedProduct = '';
  TextEditingController maintenanceEngineerController = TextEditingController();
  TextEditingController reportDateController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController detailsReportController = TextEditingController();

  void getOneReportEmergency({
    required BuildContext context,
    required String idReport,
  }) async {
    emit(ReportEmergencieLoadingState());

    await ReportEmergencieDataSource.getOneReport(idReport: idReport).then(
      (value) async {
        value.fold((l) {
          debugPrint(l.errMessage);
          showToast(l.errMessage);
          debugPrint('=== Error ====');
          emit(ReportEmergencieErrorState(l.errMessage));
        }, (success) async {
          debugPrint('=== Success ====');

          // await Preferences.setSaved(value: jsonEncode(success.toJson()), key: allPeridicsKey);
          // oneElevatorModel = success;

          emit(ReportEmergencieSuccessState());
        });
      },
    );
  }

  void addReport({
    required String malfunctionId,
    required String description,
    required String price,
    required String status,
    required String product,
  }) async {
    emit(AddReportEmergencieLoadingState());

    try {
      await ReportEmergencieDataSource.addReport(
        emrgencieId: malfunctionId,
        description: description,
        price: price,
        status: status,
        product: product,
      );
      emit(AddReportEmergencieSuccessState());
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
      emit(AddReportEmergencieErrorState(error.toString()));
    }
  }



}
