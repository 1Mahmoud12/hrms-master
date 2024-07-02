abstract class ResetPasswordState {}

class RestPasswordInitial extends ResetPasswordState {}

class RestPasswordLoading extends ResetPasswordState {}

class RestPasswordSuccess extends ResetPasswordState {}

class RestPasswordError extends ResetPasswordState {
  final String error;

RestPasswordError(this.error);

 
}
