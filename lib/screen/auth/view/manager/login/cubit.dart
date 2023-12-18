import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/auth/data/dataSource/login_data_source.dart';
import 'package:cnattendance/screen/auth/view/manager/login/state.dart';
import 'package:cnattendance/screen/dashboard/bottommenu/bottommenu.dart';
import 'package:cnattendance/screen/employer/ProjectsScreen/home_dashboard_screen.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit of(BuildContext context) => BlocProvider.of<LoginCubit>(context);
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void loginUser({required String userName, required String password, required BuildContext context}) async {
    debugPrint("loginUser");
    _isLoading = true;
    EasyLoading.show(status: 'Signing in..', maskType: EasyLoadingMaskType.black);
    emit(LoginLoadingState());

    Navigator.of(context).pushNamedAndRemoveUntil(HomeDashboardScreen.routeName, (route) => false);
    Preferences.setSaved(value: RoleId.customer.toString(), key: 'genderUser');
    final response = LoginDataSource.login(userName, password);

    if (context.mounted) return;

    Navigator.of(context).pushNamedAndRemoveUntil(HomeDashboardScreen.routeName, (route) => false);
    response.then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);

        emit(LoginErrorState(l.errMessage));
      }, (r) {
        if (r.data.user.roleId == '4') {
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(MenuScreen.routeName, (route) => false);
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(r.message)));
        debugPrint("a22dsdssd ${r.data.user.roleId}${r.data.user.roleId == '4'}");

        emit(LoginSuccessState());
      });
    });

    /* setState(() {
      _isLoading = false;
      EasyLoading.dismiss();
    });*/
  }
}
