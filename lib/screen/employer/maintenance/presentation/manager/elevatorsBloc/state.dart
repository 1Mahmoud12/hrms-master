abstract class ElevatorsState {}

class ElevatorsInitial extends ElevatorsState {}

// Get

class ElevatorsLoadingState extends ElevatorsState {}

class ElevatorsSuccessState extends ElevatorsState {}

class ElevatorsErrorState extends ElevatorsState {
  final String error;

  ElevatorsErrorState(this.error);
}
