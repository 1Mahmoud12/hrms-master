import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/projectdetail/ProjectDetailResponse.dart';
import 'package:cnattendance/model/attachment.dart';
import 'package:cnattendance/model/member.dart';
import 'package:cnattendance/model/project.dart';
import 'package:cnattendance/model/task.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailController extends GetxController {
  Rx<Project> project = Project(
    0,
    '',
    '',
    '',
    '',
    '',
    0,
    0,
    [],
    [],
    [],
    '',
    '',
  ).obs;

  RxList memberImages = [].obs;
  RxList leaderImages = [].obs;

  Future<String> getProjectOverview() async {
    final uri = Uri.parse(
      "${EndPoints.PROJECT_DETAIL_URL}/${Get.arguments["id"]}",
    );

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

      EasyLoading.dismiss();
      debugPrint(response.body);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final projectResponse = ProjectDetailResponse.fromJson(responseData);

        final List<Member> members = [];
        memberImages.clear();
        for (final member in projectResponse.data.assigned_member) {
          members.add(Member(member.id, member.name, member.avatar, post: member.post));
          memberImages.add(member.avatar);
        }

        final List<Member> leaders = [];
        leaderImages.clear();
        for (final member in projectResponse.data.project_leader) {
          leaders.add(Member(member.id, member.name, member.avatar, post: member.post));
          leaderImages.add(member.avatar);
        }

        final List<Attachment> attachments = [];
        for (final attachment in projectResponse.data.attachments) {
          if (attachment.type == 'image') {
            attachments.add(Attachment(attachment.id, attachment.attachment_url, 'image'));
          } else {
            attachments.add(Attachment(attachment.id, attachment.attachment_url, 'file'));
          }
        }

        final Project response = Project(
          projectResponse.data.id,
          projectResponse.data.name,
          projectResponse.data.description,
          projectResponse.data.startDate,
          projectResponse.data.priority,
          projectResponse.data.status,
          projectResponse.data.progress_percent,
          projectResponse.data.assigned_task_count,
          members,
          leaders,
          attachments,
          projectResponse.data.deadline,
          projectResponse.data.cover_pic,
        );

        final List<Task> taskList = [];
        for (final task in projectResponse.data.assigned_task_detail) {
          taskList.add(
            Task(
              task.task_id,
              task.task_name,
              projectResponse.data.name,
              task.start_date,
              task.deadline,
              task.status,
              //    members: task.assigned_member.map((e) => Member(e.id, e.name, e.avatar)).toList(),
            ),
          );
        }

        response.tasks.addAll(taskList);
        project.value = response;
        return 'Loaded';
      } else {
        final errorMessage = responseData['message'];
        debugPrint(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }

  @override
  void onInit() {
    getProjectOverview();
    super.onInit();
  }

  Future<void> launchUrls(String _url) async {
    if (!await launchUrl(Uri.parse(_url), mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }
}
