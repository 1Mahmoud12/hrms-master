import 'package:bloc/bloc.dart';
import 'package:cnattendance/screen/profile/dataSource/reset_password_data_source.dart';
import 'package:cnattendance/screen/profile/manager/resetPasswordBloc/cubit/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(RestPasswordInitial());
  Future<void> resetPassword({required String email}) async {
    try {
      emit(RestPasswordInitial());
      ResetPasswordDataSource().resetPassword(email);
      emit(RestPasswordInitial());
    } catch (e) {
      emit(RestPasswordError());
    }
  }
}
