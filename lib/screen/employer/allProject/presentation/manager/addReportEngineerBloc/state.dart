abstract class AddReportEngineerState {}

class AddReportEngineerInitial extends AddReportEngineerState {}

class AddReportEngineerLoadingState extends AddReportEngineerState {}

class AddReportEngineerSuccessState extends AddReportEngineerState {}

class AddReportEngineerErrorState extends AddReportEngineerState {
  String error;

  AddReportEngineerErrorState(this.error);
}
