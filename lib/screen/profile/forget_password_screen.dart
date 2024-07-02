import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/profile/manager/resetPasswordBloc/cubit/reset_password_cubit.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    final emailController = TextEditingController();

    return Scaffold(
      body: Form(
        key: form,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.changePasswordImage,
              ),
              30.ESH(),
              CustomTextFormField(
                controller: emailController,
                hintText: 'Enter Your Email'.tr,
              ),
              10.ESH(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(29)),
            ),
          ),
          onPressed: () {
            BlocProvider.of<ResetPasswordCubit>(context)
                .resetPassword(email: emailController.text);
            Navigator.pop(context);
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
    );
  }
}
