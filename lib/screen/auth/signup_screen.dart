import 'package:cnattendance/Controller/SignupController.dart';
import 'package:cnattendance/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final Signupcontrol = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();

    return Scaffold(
      body: GetBuilder(
          init: Signupcontrol,
          builder: (context) {
            return Form(
              key: _form,
              child: Container(
                decoration: const BoxDecoration(color: Color(0xff635F54)),
                child: SingleChildScrollView(
                  child: Container(
                    height: Get.height * 1,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,),
                          ),
                        ),
                        customTextfield(
                          'Enter Name',
                          'Name',
                          Signupcontrol.usernameController,
                          const Icon(Icons.person, color: Colors.white),
                        ),
                        customTextfield(
                          'Enter Email',
                          'Email',
                          Signupcontrol.emailcontroller,
                          const Icon(Icons.email_outlined, color: Colors.white),
                        ),
                        customTextfield(
                          'Enter Phone Number',
                          'Phone Number',
                          Signupcontrol.phonecontroller,
                          const Icon(Icons.phone, color: Colors.white),
                        ),
                        TextFormField(
                          obscureText: Signupcontrol.obscureText,
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (!Signupcontrol.validateField(value!)) {
                              return 'Empty Field';
                            }
                            return null;
                          },
                          controller: Signupcontrol.passwordController,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            labelText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(Icons.lock, color: Colors.white),
                            labelStyle: const TextStyle(color: Colors.white),
                            fillColor: Colors.white24,
                            filled: true,
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),),),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            suffixIcon: InkWell(
                              onTap: Signupcontrol.toggle,
                              child: Icon(
                                Signupcontrol.obscureText
                                    ? FontAwesomeIcons.eye
                                    // ignore: dead_code
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: Get.width * 0.9,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: HexColor('#cfcdcb'),
                              padding: EdgeInsets.zero,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),),
                            ),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              // validateValue();
                              if (_form.currentState!.validate()) {
                                Signupcontrol.signupUser();
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Color(0xff635F54), fontSize: 18,),
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
              ),
            );
          },),
    );
  }

  Widget customTextfield(String hinttext, String labeltext,
      TextEditingController controller, Icon icon,) {
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
                bottomRight: Radius.circular(10),),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),),),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),),),
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
