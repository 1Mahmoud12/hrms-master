import 'package:cnattendance/screen/employer/allProject/data/dataSource/proposal_data_source.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/addReportEngineerBloc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddReportEngineerCubit extends Cubit<AddReportEngineerState> {
  AddReportEngineerCubit() : super(AddReportEngineerInitial());

  static AddReportEngineerCubit of(BuildContext context) => BlocProvider.of<AddReportEngineerCubit>(context);
  TextEditingController reportEngineer = TextEditingController();
  TextEditingController reportSales = TextEditingController();
  TextEditingController costReportEngineer = TextEditingController();

  void postReportEngineer({required int formRequestId, required String cost, required String reportTechnical, required BuildContext context}) async {
    emit(AddReportEngineerLoadingState());

    await ProposalDataSource.postReportEngineerProposal(cost: cost, formRequestId: formRequestId, reportTechnical: reportTechnical)
        .then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        emit(AddReportEngineerErrorState(l.errMessage));
      }, (r) async {
        showToast(r.message ?? '');
        emit(AddReportEngineerSuccessState());
      });
    });
  }

  void postReportSales({required int formRequestId, required String reportTechnical, required BuildContext context}) async {
    emit(AddReportEngineerLoadingState());

    await ProposalDataSource.postReportSalesProposal(formRequestId: formRequestId, reportTechnical: reportTechnical).then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        emit(AddReportEngineerErrorState(l.errMessage));
      }, (r) async {
        showToast(r.message ?? '');
        emit(AddReportEngineerSuccessState());
      });
    });
  }

  @override
  Future<void> close() {
    reportEngineer.dispose();
    reportSales.dispose();
    costReportEngineer.dispose();
    debugPrint('============= Closing =====================');
    return super.close();
  }
}
