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
    GetAllChatUsers();
  }

  List userdata = [];

  Future<List> GetAllChatUsers() async {
    isLoading = true;
    //EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);

    final userid = userCache!.id;
    userdata = [];
    final baseUrl = 'https://hr.dar-bayat.com/api/users/chat/$userid';
    final url = Uri.parse(baseUrl);
    final res = await http.get(url);
    final jsonRes = jsonDecode(res.body);
    if (jsonRes['status'] == 'ok') {
      for (final i in jsonRes['data']) {
        userdata.add(i);
      }
      if (genderUser == RoleId.eight.name.tr) {
        final String username = userdata[0]['name'];

        final int id = userdata[0]['id'];

        Get.to(ChatUi(userid: id, userName: username));
      }
    }
    isLoading = false;
    //EasyLoading.dismiss();
    update();
    return userdata;
  }
}
