import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatViewScreenController extends GetxController {
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    GetAllChatUsers();
  }

  List userdata = [];

  Future<List> GetAllChatUsers() async {
    isLoading = true;
    EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);

    final Preferences preferences = Preferences();
    final user = await preferences.getUser();
    final userid = user.id;
    userdata = [];
    final baseUrl = 'https://hr.dar-bayat.com/api/users/chat/$userid';
    final url = Uri.parse(baseUrl);
    final res = await http.get(url);
    final jsonRes = jsonDecode(res.body);
    if (jsonRes['status'] == 'ok') {
      for (final i in jsonRes['data']) {
        userdata.add(i);
      }
    }
    isLoading = false;
    EasyLoading.dismiss();
    update();
    return userdata;
  }
}
