import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/changepasswordprovider.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/navigationservice.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => ChangePasswordProvider(), child: const ChangePassword());
  }
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<StatefulWidget> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _form.currentState!.dispose();
    super.dispose();
  }

  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  void changePassword() async {
    final validate = _form.currentState!.validate();

    if (validate) {
      setState(() {
        EasyLoading.show(status: 'Please wait..', maskType: EasyLoadingMaskType.clear);
      });

      try {
        final response = await Provider.of<ChangePasswordProvider>(context, listen: false)
            .changePassword(_oldPasswordController.text, _newPasswordController.text, _confirmPasswordController.text);

        if (!mounted) {
          return;
        }
        if (response.statusCode == 200) {
          Navigator.pop(context);
          NavigationService().showSnackBar('Password Alert', response.message);
        } else {
          NavigationService().showSnackBar('Password Alert', response.message);
        }
      } catch (e) {
        NavigationService().showSnackBar('Password Alert', e.toString());
      }

      setState(() {
        EasyLoading.dismiss();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change_password'.tr,
          style: Styles.styleHeader,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        // child: TextButton(
        //   style: TextButton.styleFrom(
        //       backgroundColor: HexColor("#036eb7"),
        //       shape: ButtonBorder(),
        //       fixedSize: Size(double.maxFinite, 55)),
        //   onPressed: () {
        //     changePassword();
        //   },
        //   child: Text(
        //     'Change Password',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),

        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(29))),
          ),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            changePassword();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0).h,
            child: Text(
              'Continue'.tr,
              style: Styles.style16700.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ),
      body: Form(
        key: _form,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.changePasswordImage,
                ),
                10.ESH(),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Create Your New Password '.tr,
                    style: Styles.styleHeader,
                    textAlign: TextAlign.start,
                  ),
                ),
                10.ESH(),
                CustomTextFormField(
                  controller: _oldPasswordController,
                  hintText: 'oldPassword',
                  password: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0).w,
                    child: SvgPicture.asset(
                      Assets.look,
                    ),
                  ),
                ),
                10.ESH(),
                CustomTextFormField(
                  controller: _newPasswordController,
                  hintText: 'NewPassword',
                  password: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0).w,
                    child: SvgPicture.asset(
                      Assets.look,
                    ),
                  ),
                ),
                10.ESH(),
                CustomTextFormField(
                  controller: _confirmPasswordController,
                  hintText: 'ConfirmPassword',
                  password: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0).w,
                    child: SvgPicture.asset(
                      Assets.look,
                    ),
                  ),
                ),
                10.ESH(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Forgot Password?'.tr,
                    style: Styles.style14500.copyWith(color: AppColors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
