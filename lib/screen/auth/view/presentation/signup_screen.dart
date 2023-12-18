import 'package:cnattendance/Controller/SignupController.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/auth/view/presentation/login_screen.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final Signupcontrol = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: GetBuilder(
        init: Signupcontrol,
        builder: (context) {
          return Form(
            key: _form,
            child: SingleChildScrollView(
              child: Container(
                height: Get.height * 1,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    60.ESH(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        'Sign Up',
                        style: Styles.styleHeader,
                      ),
                    ),
                    CustomTextFormField(
                      hintText: 'Name',
                      controller: Signupcontrol.usernameController,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    CustomTextFormField(
                      hintText: 'Email',
                      controller: Signupcontrol.emailcontroller,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                      ),
                    ),
                    CustomTextFormField(
                      hintText: 'Phone Number',
                      controller: Signupcontrol.phonecontroller,
                      prefixIcon: const Icon(
                        Icons.phone,
                      ),
                    ),
                    CustomTextFormField(
                      controller: Signupcontrol.passwordController,
                      hintText: 'Enter Password',
                      password: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0).w,
                        child: SvgPicture.asset(
                          Assets.look,
                        ),
                      ),
                    ),
                    30.ESH(),
                    SizedBox(
                      width: Get.width * 0.9,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.white,
                          padding: EdgeInsets.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          // validateValue();
                          if (_form.currentState!.validate()) {
                            Signupcontrol.signupUser();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(20.0.w),
                          child: Text(
                            'Register',
                            style: Styles.style16700.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.off(const LoginScreen());
                          },
                          child: const Text(
                            'Already Have An Account ? Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget customTextfield(
    String hinttext,
    String labeltext,
    TextEditingController controller,
    Icon icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          prefixIcon: icon,
          labelStyle: const TextStyle(color: Colors.white),
          fillColor: Colors.white24,
          filled: true,
          hintText: hinttext,
          labelText: labeltext,
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        validator: (value) {
          if (!Signupcontrol.validateField(value!)) {
            return 'Empty Field';
          }
          return null;
        },
      ),
    );
  }
}
