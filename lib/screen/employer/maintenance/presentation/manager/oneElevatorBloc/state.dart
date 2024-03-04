abstract class OneElevatorState {}

class OneElevatorInitial extends OneElevatorState {}

// Get

class OneElevatorLoadingState extends OneElevatorState {}

class OneElevatorSuccessState extends OneElevatorState {}

class OneElevatorErrorState extends OneElevatorState {
  final String error;

  OneElevatorErrorState(this.error);
}
