import 'dart:convert';

import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/Chat/userchat/chatui.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatViewScreenController extends GetxController {
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getAllChatUsers();
  }

  List userdata = [];

  void goTo() {
    if (userdata.isNotEmpty && genderUser == RoleId.eight.name.tr) {
      final String username = userdata[0]['name'];

      final int id = userdata[0]['id'];

      Get.to(ChatUi(userid: id, userName: username));
    }
  }

  Future<List> getAllChatUsers() async {
    isLoading = true;
    //EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);

    final userid = userCache!.id;
    userdata = [];
    final baseUrl = 'https://hr.dar-bayat.com/api/users/chat/$userid';
    final url = Uri.parse(baseUrl);
    final res = await http.get(url);
    final jsonRes = jsonDecode(res.body);
    if (jsonRes['status'] == 'ok' && jsonRes['data'] != null) {
      if (genderUser == RoleId.eight.name.tr) {
        userdata.add(jsonRes['data'].first);
      } else {
        for (int i = 0; i < (jsonRes['data'] ?? []).length; i++) {
          userdata.add(i);
        }
      }
    }
    isLoading = false;
    //EasyLoading.dismiss();
    update();
    return userdata;
  }
}
