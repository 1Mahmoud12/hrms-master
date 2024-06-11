import 'package:cnattendance/screen/employer/maintenance/data/dataSource/report_data_source.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/reportBloc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportBloc extends Cubit<ReportState> {
  ReportBloc() : super(ReportInitialState());

  static ReportBloc of(BuildContext context) =>
      BlocProvider.of<ReportBloc>(context);

  TextEditingController maintenanceEngineerController = TextEditingController();
  TextEditingController reportDateController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController detailsReportController = TextEditingController();

  void updateReportMechanics({
    required String maintenanceEngineer,
    required String reportDate,
    required String customerName,
    required String phone,
    required String address,
    required String detailsReport,
  }) {
    maintenanceEngineerController.text = maintenanceEngineer;
    reportDateController.text = reportDate;
    customerNameController.text = customerName;
    phoneController.text = phone;
    addressController.text = address;
    detailsReportController.text = detailsReport;
    emit(EditReportState());
  }

  void getOneReport({
    required BuildContext context,
    required String idReport,
  }) async {
    emit(ReportLoadingState());

    await ReportDataSource.getOneReport(idReport: idReport).then(
      (value) async {
        value.fold((l) {
          debugPrint(l.errMessage);
          showToast(l.errMessage);
          debugPrint('=== Error ====');
          emit(ReportErrorState(l.errMessage));
        }, (success) async {
          debugPrint('=== Success ====');

          // await Preferences.setSaved(value: jsonEncode(success.toJson()), key: allPeridicsKey);
          // oneElevatorModel = success;

          emit(ReportSuccessState());
        });
      },
    );
  }


  void addReport({
    required String emergencyId,
    required String description,
    required String price,
    required String status, 
    required String product, 
  }) async {
    emit(ReportLoadingState());

    try {
      await ReportDataSource.addReport(
        emergencyId: emergencyId,
        description: description,
        price: price,
        status: status,
        product: product,
      );
      emit(ReportSuccessState());
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
      emit(ReportErrorState(error.toString()));
    }
  }


}
