import 'package:cnattendance/screen/employer/maintenance/presentation/manager/reportBloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportBloc extends Cubit<ReportState> {
  ReportBloc() : super(ReportInitialState());

  static ReportBloc of(BuildContext context) => BlocProvider.of<ReportBloc>(context);

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
}
