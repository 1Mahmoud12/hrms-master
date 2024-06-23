abstract class MalfunctionState {}

class MalfunctionInitial extends MalfunctionState {}

// Get

class MalfunctionLoadingState extends MalfunctionState {}

class MalfunctionSuccessState extends MalfunctionState {}

class MalfunctionAddedState extends MalfunctionState {}
class MalfunctionPaymentAddedState extends MalfunctionState {}

class MalfunctionErrorState extends MalfunctionState {
  final String error;

  MalfunctionErrorState(this.error);
}
