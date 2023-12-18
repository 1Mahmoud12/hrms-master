import 'dart:ui';

import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/model/auth.dart';
import 'package:cnattendance/screen/auth/view/manager/login/cubit.dart';
import 'package:cnattendance/screen/auth/view/manager/login/state.dart';
import 'package:cnattendance/screen/auth/view/presentation/signup_screen.dart';
import 'package:cnattendance/screen/dashboard/bottommenu/bottommenu.dart';
import 'package:cnattendance/screen/employer/ProjectsScreen/home_dashboard_screen.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    //_form.currentState!.dispose();
    super.dispose();
  }

  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  void validateValue() {
    final value = _form.currentState!.validate();

    if (value) {
      LoginCubit.of(context).loginUser(userName: _usernameController.text, password: _passwordController.text, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final cubit = LoginCubit.of(context);
          return Form(
            key: _form,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(context.screenWidth * .05),
              child: IgnorePointer(
                ignoring: cubit.isLoading,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Image.asset(
                          Assets.appLogo,
                          fit: BoxFit.cover,
                          height: context.screenHeight * .2,
                        ),
                      ),

                      Text(
                        'Login',
                        style: Styles.style16700,
                      ),

                      //textHeading('Username'),
                      //gaps(10),
                      CustomTextFormField(controller: _usernameController, hintText: 'Username'),

                      //  textHeading('Password'),
                      CustomTextFormField(
                        controller: _passwordController,
                        hintText: 'Password',
                        password: true,
                      ),
                      /*TextFormField(
                      obscureText: _obscureText,
                      style: const TextStyle(color: AppColors.textColor),
                      validator: (value) {
                        if (!validateField(value!)) {
                          return "Empty Field";
                        }

                        return null;
                      },
                      controller: _passwordController,
                      cursorColor: AppColors.textColor,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: AppColors.textColor),
                        labelStyle: const TextStyle(color: AppColors.textColor),
                        fillColor: AppColors.textColor,
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          borderSide: BorderSide(color: AppColors.textColor),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          borderSide: BorderSide(color: AppColors.textColor),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        suffixIcon: InkWell(
                          onTap: _toggle,
                          child: Icon(
                            _obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                            size: 15.0,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                    ),*/

                      button(),
                      CustomTextButton(
                        child: const Text('customer'),
                        onPress: () {
                          Preferences.setSaved(value: RoleId.customer.toString(), key: 'genderUser');
                          Navigator.of(context).pushNamedAndRemoveUntil(HomeDashboardScreen.routeName, (route) => false);
                        },
                      ),
                      CustomTextButton(
                        child: const Text('Mechanics'),
                        onPress: () {
                          Preferences.setSaved(value: RoleId.mechanics.toString(), key: 'genderUser');
                          Navigator.of(context).pushNamedAndRemoveUntil(HomeDashboardScreen.routeName, (route) => false);
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signup(),
                                ),
                              );
                            },
                            child: Text(
                              "Don't Have An Account ? Create Account",
                              textAlign: TextAlign.center,
                              style: Styles.style12400,
                            ),
                          ),
                        ],
                      ),
                      // Center(
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       openBrowserTab();
                      //     },
                      //     child: Text(
                      //         textAlign: TextAlign.left,
                      //         style: TextStyle(color:  AppColors.textColor),
                      //         'Forget Password'),
                      //   ),
                      // ),
                    ].paddingDirectional(top: context.screenHeight * .02),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void openBrowserTab() async {
    await FlutterWebBrowser.openWebPage(
      url: 'https://attendance.cyclonenepal.com/password/reset',
      customTabsOptions: const CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.dark,
        shareState: CustomTabsShareState.on,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: const SafariViewControllerOptions(
        barCollapsingEnabled: true,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }

  BoxDecoration backgroundDecoration() {
    return const BoxDecoration(
      image: DecorationImage(
        colorFilter: ColorFilter.mode(Colors.blueGrey, BlendMode.softLight),
        image: AssetImage(
          'assets/images/login.jpg',
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget gaps(double value) {
    return SizedBox(
      height: value,
    );
  }

  Widget textHeading(String value) {
    return Text(textAlign: TextAlign.left, style: Styles.style14400, value);
  }

  Widget button() {
    return SizedBox(
      width: context.screenWidth,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.r))),
        ),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          validateValue();
        },
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Login',
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
