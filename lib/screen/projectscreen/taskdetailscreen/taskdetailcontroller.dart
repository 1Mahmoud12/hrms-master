import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/checkliststatustoggle/CheckListStatusToggleResponse.dart';
import 'package:cnattendance/data/source/network/model/taskdetail/taskdetail.dart';
import 'package:cnattendance/model/checklist.dart';
import 'package:cnattendance/model/member.dart';
import 'package:cnattendance/model/task.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../model/attachment.dart';

class TaskDetailController extends GetxController {
  Rx<Task> taskDetail = Task.all(0, '', '', '', '', '', '', '', 0, 0, false, [], [], []).obs;

  RxList memberImages = [].obs;
  RxList leaderImages = [].obs;

  Future<TaskDetailResponse> getTaskOverview() async {
    debugPrint("id ha ${Get.arguments["id"]}");

    final uri = Uri.parse(
      "${EndPoints.TASK_DETAIL_URL}/${Get.arguments["id"]}",
    );

    final Preferences preferences = Preferences();
    final String token = preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    // debugPrint(token);
    // debugPrint("wapis id ha ha ${Get.arguments["id"]}");

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
        debugPrint('1st chala');
        final taskResponse = TaskDetailResponse.fromJson(responseData);

        debugPrint('2nd chala');

        final List<Member> members = [];
        memberImages.clear();
        for (final member in taskResponse.data.assigned_member) {
          members.add(
            Member(member.id, member.name, member.avatar, post: member.post),
          );
          memberImages.add(member.avatar);
        }

        final List<Checklist> checkLists = [];
        for (final checkList in taskResponse.data.checklists) {
          checkLists.add(
            Checklist(
              checkList.id,
              checkList.task_id,
              checkList.name,
              checkList.is_completed,
            ),
          );
        }

        final List<Attachment> attachments = [];
        for (final attachment in taskResponse.data.attachments) {
          if (attachment.type == 'image') {
            attachments.add(Attachment(0, attachment.attachment_url, 'image'));
          } else {
            attachments.add(Attachment(0, attachment.attachment_url, 'file'));
          }
        }

        final task = Task.all(
          taskResponse.data.task_id,
          taskResponse.data.task_name,
          taskResponse.data.project_name,
          taskResponse.data.description,
          taskResponse.data.start_date,
          taskResponse.data.deadline,
          taskResponse.data.priority,
          taskResponse.data.status,
          taskResponse.data.task_progress_percent,
          taskResponse.data.task_comments.length,
          taskResponse.data.has_checklist,
          members,
          checkLists,
          attachments,
        );

        taskDetail.value = task;
        return taskResponse;
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

  Future<bool> checkListToggle(String checkListId) async {
    final uri = Uri.parse('${EndPoints.UPDATE_CHECKLIST_TOGGLE_URL}/$checkListId');

    final Preferences preferences = Preferences();
    final String token = preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    debugPrint(uri.toString());
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
        final taskResponse = CheckListStatusToggleResponse.fromJson(responseData);

        return true;
      } else {
        final errorMessage = responseData['message'];
        debugPrint(errorMessage);
        return false;
      }
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }

  Future<bool> checkListTaskToggle(String taskId) async {
    final uri = Uri.parse('${EndPoints.UPDATE_TASK_TOGGLE_URL}/$taskId');

    final Preferences preferences = Preferences();
    final String token = preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    debugPrint(uri.toString());
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
        Get.back();
        showToast('Task completed');
        return true;
      } else {
        final errorMessage = responseData['message'];
        debugPrint(errorMessage);
        return false;
      }
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }

  Future<void> launchUrls(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void onInit() {
    getTaskOverview();
    super.onInit();
  }
}
