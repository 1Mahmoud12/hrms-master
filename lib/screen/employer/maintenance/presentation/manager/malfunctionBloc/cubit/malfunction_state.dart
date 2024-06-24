abstract class MalfunctionState {}

class MalfunctionInitial extends MalfunctionState {}

// Get

class MalfunctionLoadingState extends MalfunctionState {}

class MalfunctionSuccessState extends MalfunctionState {}
// Add malfunction
class MalfunctionAddedState extends MalfunctionState {}


// add payment
class MalfunctionPaymentAddedState extends MalfunctionState {}

// get one malfunction
class GetOneMalfunctionLoadingState extends MalfunctionState {}

class GetOneMalfunctionSuccessState extends MalfunctionState {}

class GetOneMalfunctionErrorState extends MalfunctionState {
  final String error;

  GetOneMalfunctionErrorState(this.error);
}






class MalfunctionErrorState extends MalfunctionState {
  final String error;

  MalfunctionErrorState(this.error);
}
