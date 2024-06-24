abstract class ReportEmergencieState {}

// get one report emergency
class ReportEmergencieInitialState extends ReportEmergencieState {}

class ReportEmergencieLoadingState extends ReportEmergencieState {}

class ReportEmergencieSuccessState extends ReportEmergencieState {}

class ReportEmergencieErrorState extends ReportEmergencieState {
  final String error;

  ReportEmergencieErrorState(this.error);
}


// add one report emergency
class AddReportEmergencieLoadingState extends ReportEmergencieState {}

class AddReportEmergencieSuccessState extends ReportEmergencieState {}

class AddReportEmergencieErrorState extends ReportEmergencieState {
  final String error;

  AddReportEmergencieErrorState(this.error);
}

//class EditReportState extends ReportEmergencieState {}
