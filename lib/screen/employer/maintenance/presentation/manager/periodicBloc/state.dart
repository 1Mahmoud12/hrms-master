abstract class PeriodicState {}

class PeriodicInitial extends PeriodicState {}

// Get

class PeriodicLoadingState extends PeriodicState {}

class PeriodicSuccessState extends PeriodicState {}

class PeriodicErrorState extends PeriodicState {
  final String error;

  PeriodicErrorState(this.error);
}
