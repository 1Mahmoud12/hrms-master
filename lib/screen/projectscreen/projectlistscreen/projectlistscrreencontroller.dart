import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/projectlist/projectlistresponse.dart';
import 'package:cnattendance/model/member.dart';
import 'package:cnattendance/model/project.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailscreen.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectListScreenController extends GetxController {
  final projectList = <Project>[].obs;
  final filteredList = <Project>[].obs;
  final selected = 'All'.obs;

  Future<String> getProjectOverview() async {
    final uri = Uri.parse(Constant.PROJECT_LIST_URL);

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    try {
      EasyLoading.show(status: 'Loading',maskType: EasyLoadingMaskType.black);
      final response = await http.get(
        uri,
        headers: headers,
      );
      debugPrint(response.body);
      EasyLoading.dismiss();

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final projectResponse = ProjectListResponse.fromJson(responseData);
        projectList.clear();

        for (final project in projectResponse.data) {
          final List<Member> members = [];
          for (final member in project.assigned_member) {
            members.add(Member(member.id, member.name, member.avatar));
          }

          final List<Member> leaders = [];
          for (final member in project.project_leader) {
            leaders.add(Member(member.id, member.name, member.avatar));
          }

          projectList.add(Project(
              project.id,
              project.name,
              project.description,
              project.start_date,
              project.priority,
              project.status,
              project.progress_percent,
              project.assigned_task_count,
              members,
              leaders,[],),);
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

  void filterList(){
    filteredList.clear();
    if(selected.value == 'All'){
      filteredList.addAll(projectList);
    }else{
      for(final project in projectList){
        if(project.status == selected.value){
          filteredList.add(project);
        }
      }
    }

  }

  void onProjectClicked(Project value) {
    Get.to(const ProjectDetailScreen(), arguments: {'id': value.id});
  }

  @override
  void onInit() {
    getProjectOverview();
    super.onInit();
  }
}
