abstract class GetOneEmergencyState {}

class GetOneEmergencyInitial extends GetOneEmergencyState {}

// Get

class GetOneEmergencyLoadingState extends GetOneEmergencyState {}

class GetOneEmergencySuccessState extends GetOneEmergencyState {}

class GetOneEmergencyErrorState extends GetOneEmergencyState {
  final String error;

  GetOneEmergencyErrorState(this.error);
}
