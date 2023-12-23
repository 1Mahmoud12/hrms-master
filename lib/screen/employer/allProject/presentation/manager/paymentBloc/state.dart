abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

// Attachment
class PickFileLoadingState extends PaymentState {}

class PickFileSuccessState extends PaymentState {}

class PickFileErrorState extends PaymentState {}

class ChangeIndexState extends PaymentState {}
