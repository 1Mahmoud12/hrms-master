import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/projectdashboard/ProjectDashboardResponse.dart';
import 'package:cnattendance/model/member.dart';
import 'package:cnattendance/model/project.dart';
import 'package:cnattendance/model/task.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectDashboardController extends GetxController {
  RxMap<String, int> overview = {
    'progress': 0,
    'total_task': 0,
    'task_completed': 0,
  }.obs;

  RxList taskList = [].obs;
  RxList projectList = [].obs;

  Future<String> getProjectOverview() async {
    final uri =
        Uri.parse('${Constant.PROJECT_DASHBOARD_URL}?tasks=10&projects=3');

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      debugPrint(response.body);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final projectResponse = ProjectDashboardResponse.fromJson(responseData);

        taskList.clear();
        projectList.clear();

        overview.value['progress'] =
            projectResponse.data.progress.progress_in_percent;
        overview.value['total_task'] =
            projectResponse.data.progress.total_task_assigned;
        overview.value['task_completed'] =
            projectResponse.data.progress.total_task_completed;

        for (final task in projectResponse.data.assigned_task) {
          taskList.add(Task(task.task_id, task.task_name, task.project_name,
              task.start_date, task.end_date, task.status,),);
        }

        final List<Member> members = [];
        for (final project in projectResponse.data.projects) {
          for (final member in project.assigned_member) {
            members.add(Member(member.id, member.name, member.avatar));
          }


          projectList.add(Project(
              project.id,
              project.project_name,
              '',
              project.start_date,
              project.priority,
              project.status,
              project.project_progress_percent,
              project.assigned_task_count,
              members,
              [],[],),);
        }

        return 'Loaded';
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
    getProjectOverview();
    super.onInit();
  }
}
