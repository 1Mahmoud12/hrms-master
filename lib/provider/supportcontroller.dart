import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/support/SupportResponse.dart';
import 'package:cnattendance/model/department.dart';
import 'package:cnattendance/screen/profile/supportlistscreen.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/widget/customalertdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SupportController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  RxInt selectedval = 0.obs;
  Rx<Department> selected = Department('0', '').obs;

  RxList<Department> departments = <Department>[].obs;
  RxList getAllDepartment = [].obs;

  final form = GlobalKey<FormState>();

  void onSubmitClicked(department) {
    if (form.currentState!.validate()) {
      if (selected.value.id != '0') {
        debugPrint(titleController.text);
        sendSupportMessage(
          titleController.text,
          descriptionController.text,
          department,
        );
      } else {
        showToast('Please select a department');
      }
    }
  }

  Future<SupportResponse> sendSupportMessage(
    String title,
    String description,
    int department,
  ) async {
    final uri = Uri.parse(EndPoints.SUPPORT_URL);

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    print(selected.value.name);
    try {
      EasyLoading.show(
        status: 'Submitting, Please Wait...',
        maskType: EasyLoadingMaskType.black,
      );
      final response = await http.post(
        uri,
        headers: headers,
        body: {
          'title': title,
          'description': description,
          'department_id': department.toString(),
        },
      );
      debugPrint(response.body);

      final responseData = json.decode(response.body);

      EasyLoading.dismiss();

      if (response.statusCode == 200) {
        final supportResponse = SupportResponse.fromJson(responseData);

        titleController.clear();
        descriptionController.clear();

        Get.dialog(
          Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            height: 500,
            child: Center(child: CustomAlertDialog(supportResponse.message)),
          ),
          barrierDismissible: false,
        );
        return supportResponse;
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      EasyLoading.dismiss();
      rethrow;
    }
  }

  Future<void> getDepartments() async {
    final uri = Uri.parse(EndPoints.DEPARTMENT_LIST_URL);

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    getAllDepartment.clear();
    try {
      final response = await http.get(uri, headers: headers);
      // debugPrint(response.body.toString());

      final responseData = jsonDecode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        // print('-----------------------------111111111-----');
        // final departmentResponse = jsonDecode(responseData);
        // departmentlistresponse.fromJson(responseData);

        // print('-----------------------------****-----');
        // print(responseData);

        for (final department in responseData['data']) {
          // print("1 $department");
          getAllDepartment.add(department);
          // departments.add(Department(department.id, department.dept_name));
        }
        // print('A gaya');
        // print(Getalldepartment);
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      EasyLoading.dismiss();
      rethrow;
    }
  }

  void showList() {
    Get.to(const SupportListScreen(), transition: Transition.cupertino);
  }

  @override
  void onInit() {
    getDepartments();
    super.onInit();
  }
}
