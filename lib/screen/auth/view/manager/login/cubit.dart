import 'package:cnattendance/Controller/StaticControllers/mainBlocHome/cubit.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/auth/data/dataSource/login_data_source.dart';
import 'package:cnattendance/screen/auth/data/model/login_model.dart';
import 'package:cnattendance/screen/auth/view/manager/login/state.dart';
import 'package:cnattendance/screen/employer/home_dashboard_screen.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit of(BuildContext context) => BlocProvider.of<LoginCubit>(context);

  void loginUser({required String userName, required String password, required BuildContext context}) async {
    emit(LoginLoadingState());

    await LoginDataSource.login(userName, password).then((value) async {
      value.fold((l) {
        debugPrint('====== Error ========');

        debugPrint(l.errMessage);
        showToast(l.errMessage);
        emit(LoginErrorState(l.errMessage));
      }, (r) async {
        await afterLogin(r, context);

        emit(LoginSuccessState());
      });
    });
  }

  Future<void> afterLogin(LoginModel r, BuildContext context) async {
    debugPrint('======== Success ========');
    tokenCache = r.data!.tokens!;
    Preferences.setSaved(value: r.data!.tokens, key: tokenCacheKey);
    if (r.data!.user!.roleId.toString() == RoleId.eleven.name.tr) {
      genderUser = RoleId.eleven.name.tr;
      await Preferences.setSaved(value: RoleId.eleven.name.tr, key: genderUserKey);
      MainBlocHomeCubit.of(context).changeToClient();
    } else if (r.data!.user!.roleId.toString() == RoleId.eight.name.tr) {
      genderUser = RoleId.eight.name.tr;
      await Preferences.setSaved(value: RoleId.eight.name.tr, key: genderUserKey);
      MainBlocHomeCubit.of(context).changeToCustomer();
    } else {
      genderUser = r.data!.user!.roleId.toString();
      await Preferences.setSaved(value: r.data!.user!.roleId.toString(), key: genderUserKey);
      MainBlocHomeCubit.of(context).changeToEmployer();
    }

    Navigator.of(context).pushNamedAndRemoveUntil(HomeDashboardScreen.routeName, (route) => false);

    debugPrint('Role Id Now ======> ${r.data!.user}${r.data!.user!.roleId == 4}');
    genderUser = r.data!.user!.roleId.toString();
  }
}
