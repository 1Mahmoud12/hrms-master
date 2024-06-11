abstract class EmergencieState {}

class EmergencieInitial extends EmergencieState {}

// Get


class EmergencieLoadingState extends EmergencieState {}

class EmergencieSuccessState extends EmergencieState {}
class EmergencieAddedState extends EmergencieState {}

class EmergencieErrorState extends EmergencieState {
  final String error;

  EmergencieErrorState(this.error);
}
