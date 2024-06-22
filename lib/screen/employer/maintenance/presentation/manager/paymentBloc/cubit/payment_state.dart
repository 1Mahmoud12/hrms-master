abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

// Get

class PaymentLoadingState extends PaymentState {}

class PaymentSuccessState extends PaymentState {}

class PaymentAddedState extends PaymentState {}

class PaymentErrorState extends PaymentState {
  final String error;

  PaymentErrorState(this.error);
}
