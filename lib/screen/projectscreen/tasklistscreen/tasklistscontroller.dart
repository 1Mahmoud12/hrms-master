import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/tasklistresponse/tasklistresponse.dart';
import 'package:cnattendance/model/task.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TaskListController extends GetxController {
  final taskList = <Task>[].obs;
  final filteredList = <Task>[].obs;
  final selected = 'All'.obs;

  void filterList() {
    filteredList.clear();
    if (selected.value == 'All') {
      filteredList.addAll(taskList);
    } else {
      for (final project in taskList) {
        if (project.status == selected.value) {
          filteredList.add(project);
        }
      }
    }
  }

  Future<String> getTaskList() async {
    final uri = Uri.parse(EndPoints.TASK_LIST_URL);

    final Preferences preferences = Preferences();
    final String token = preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    try {
      EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
      final response = await http.get(
        uri,
        headers: headers,
      );
      debugPrint(response.body);
      EasyLoading.dismiss();

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        taskList.clear();
        final taskResponse = tasklistresponse.fromJson(responseData);

        for (final task in taskResponse.data) {
          taskList.add(
            Task(
              task.task_id,
              task.task_name,
              task.project_name,
              task.start_date,
              task.end_date,
              task.status,
            ),
          );
        }

        filterList();
        return 'loaded';
      } else {
        final errorMessage = responseData['message'];
        print(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  void onInit() {
    getTaskList();
    super.onInit();
  }
}
