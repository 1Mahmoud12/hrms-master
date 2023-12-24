import 'dart:developer';

import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StaticContactFormScreen extends StatefulWidget {
  const StaticContactFormScreen({super.key});

  @override
  State<StaticContactFormScreen> createState() => _StaticContactFormScreenState();
}

class _StaticContactFormScreenState extends State<StaticContactFormScreen> {
  Future<void> contactform() async {
    EasyLoading.show(status: 'Submitting..', maskType: EasyLoadingMaskType.black);
    final uri = Uri.parse('https://hr.dar-bayat.com/api/guest-support/create');

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    log(uri.toString());
    final body = {'subject': subjectController.text, 'details': detailController.text};
    final response = await http.post(uri, headers: headers, body: body);

    print('logining = == $response');

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Submitted to Support')));
      subjectController.clear();
      detailController.clear();
      EasyLoading.dismiss();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Something went wrong')));
      EasyLoading.dismiss();
    }
  }

  int loading = 0;
  TextEditingController subjectController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Support',
          style: Styles.styleHeader,
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                20.ESH(),
                CustomTextFormField(
                  controller: subjectController,
                  hintText: 'Subject'.tr,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: detailController,
                  hintText: 'Description'.tr,
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.all(40),
                  child: CustomTextButton(
                      backgroundColor: AppColors.primaryColor,
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 15.sp, color: AppColors.white, fontWeight: FontWeight.w800),
                      ),
                      onPress: () {
                        if (subjectController.text != '' && detailController.text != '') {
                          contactform();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fill the form first')));
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
