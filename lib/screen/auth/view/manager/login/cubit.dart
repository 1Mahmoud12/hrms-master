import 'package:cnattendance/Controller/StaticControllers/mainBlocHome/cubit.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/auth/data/dataSource/login_data_source.dart';
import 'package:cnattendance/screen/auth/view/manager/login/state.dart';
import 'package:cnattendance/screen/employer/home_dashboard_screen.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit of(BuildContext context) => BlocProvider.of<LoginCubit>(context);

//  bool _isLoading = false;

//  bool get isLoading => _isLoading;

  void loginUser({required String userName, required String password, required BuildContext context}) async {
    emit(LoginLoadingState());

    //  Navigator.of(context).pushNamedAndRemoveUntil(HomeDashboardScreen.routeName, (route) => false);
    Preferences.setSaved(value: RoleId.eight.name.tr, key: 'genderUser');
    //if (context.mounted) return;

    await LoginDataSource.login(userName, password).then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        debugPrint('Errrrrrrorrrrrrr');
        emit(LoginErrorState(l.errMessage));
      }, (r) async {
        if (r.data!.user!.roleId.toString() == RoleId.twelve.name.tr) {
          genderUser = RoleId.twelve.name.tr;
          await Preferences.setSaved(value: RoleId.twelve.name.tr, key: 'genderUser');
          MainBlocHomeCubit.of(context).changeToClient();
        } else if (r.data!.user!.roleId.toString() == RoleId.eight.name.tr) {
          genderUser = RoleId.eight.name.tr;
          await Preferences.setSaved(value: RoleId.eight.name.tr, key: 'genderUser');
          MainBlocHomeCubit.of(context).changeToCustomer();
        } else {
          genderUser = r.data!.user!.roleId.toString();
          await Preferences.setSaved(value: r.data!.user!.roleId.toString(), key: 'genderUser');
          MainBlocHomeCubit.of(context).changeToEmployer();
        }

        Navigator.of(context).pushNamedAndRemoveUntil(HomeDashboardScreen.routeName, (route) => false);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(r.message!)));
        debugPrint('Role Id Now ======> ${r.data!.user}${r.data!.user!.roleId == 4}');
        genderUser = r.data!.user!.roleId.toString();

        emit(LoginSuccessState());
      });
    });

    /* setState(() {
      _isLoading = false;
      EasyLoading.dismiss();
    });*/
  }
}
