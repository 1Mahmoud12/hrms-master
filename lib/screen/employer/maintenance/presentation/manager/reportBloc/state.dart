abstract class ReportState {}

class ReportInitialState extends ReportState {}
class ReportLoadingState extends ReportState {}
class ReportSuccessState extends ReportState {}
class ReportErrorState extends ReportState {
   final String error;

  ReportErrorState(this.error);
}

class EditReportState extends ReportState {}
