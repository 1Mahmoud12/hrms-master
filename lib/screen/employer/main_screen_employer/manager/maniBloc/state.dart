abstract class MainBlocHomeCustomerState {}

class MainBlocHomeCustomerInitial extends MainBlocHomeCustomerState {}

class MainBlocHomeCustomerLoadingState extends MainBlocHomeCustomerState {}

class MainBlocHomeCustomerSuccessState extends MainBlocHomeCustomerState {}

class MainBlocHomeCustomerErrorState extends MainBlocHomeCustomerState {
  String error;

  MainBlocHomeCustomerErrorState(this.error);
}

class ChangeObscureState extends MainBlocHomeCustomerState {}
