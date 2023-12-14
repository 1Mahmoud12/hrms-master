import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/login/Loginresponse.dart';
import 'package:cnattendance/screen/dashboard/bottommenu/bottommenu.dart';
import 'package:cnattendance/screen/employer/ProjectsScreen/home_dashboard_screen.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  bool obscureText = true;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();

  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  void toggle() {
    obscureText = !obscureText;
    update();
  }

  void signupUser() async {
    try {
      EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
      final uri = Uri.parse(Constant.SIGNUP_URL);
      final response = await http.post(
        uri,
        body: {'name': usernameController.text, 'email': emailcontroller.text, 'password': phonecontroller.text, 'phone': phonecontroller.text},
      );
      final responsedata = json.decode(response.body);
      debugPrint('response data ==>>>>$responsedata');
      if (responsedata['status'] == true) {
        final Preferences preferences = Preferences();
        final responseJson = Loginresponse.fromJson(responsedata);
        await preferences.saveUser(responseJson.data);

        usernameController.clear();
        emailcontroller.clear();
        phonecontroller.clear();
        passwordController.clear();

        debugPrint('asaassasjjdsd${responseJson.data.user.roleId}');
        if (responseJson.data.user.roleId == '4') {
          Get.offAll(HomeDashboardScreen());

          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     HomeDashboardScreen.routeName, (route) => false);
        } else {
          Get.offAll(MenuScreen());
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil(MenuScreen.routeName, (route) => false);
        }
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text("Authenticated")));
        Get.snackbar('Success', 'Authenticated', backgroundColor: const Color(0xffcfcdcb));
        // Get.off(LoginScreen());
      } else if (responsedata['status'] == 'warning') {
        final dataMap = responsedata['message'] as Map<String, dynamic>;
        dataMap.forEach((key, value) {
          if (value is List) {
            for (final item in value) {
              Get.snackbar('Oops', item, backgroundColor: Colors.grey);
            }
          }
        });
      } else {
        Get.snackbar('Error', 'An Error Occured', backgroundColor: Colors.red);
      }
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();

      debugPrint(e.toString());
    }
  }
}
