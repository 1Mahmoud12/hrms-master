import 'package:cnattendance/Controller/ChatScreenViewController.dart';
import 'package:cnattendance/core/component/cache_image.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/Chat/userchat/chatui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreenView extends StatefulWidget {
  const ChatScreenView({super.key});

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  Future<String> getTeam() async {
    return 'Loaded';
  }

  final chatScreenController = Get.put(ChatViewScreenController());

  @override
  Widget build(BuildContext context) {
    String username;
    String role;
    String userImage;
    String depart;
    int id;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats'.tr,
          style: Styles.styleHeader,
        ),
      ),
      body: GetBuilder(
        init: chatScreenController,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return !chatScreenController.isLoading;
            },
            child: RefreshIndicator(
              onRefresh: () {
                return chatScreenController.getAllChatUsers();
              },
              child: ListView.builder(
                itemCount: chatScreenController.userdata.length,
                itemBuilder: (context, index) {
                  username = chatScreenController.userdata[index]['name'];
                  depart = chatScreenController.userdata[index]['name'];
                  id = chatScreenController.userdata[index]['id'];
                  role = chatScreenController.userdata[index]['role']['name'];
                  userImage = chatScreenController.userdata[index]['user_profile_img'];
                  if (userImage == 'uploads/user/avatar/') {
                    userImage = 'color';
                  } else {
                    userImage = userImage;
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14, bottom: 5),
                    child: userChatList(chatScreenController, username, depart, id, role, userImage),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget userChatList(ChatViewScreenController chatViewScreenController, String username, String depart, int id, String role, String userimage) {
  return ListTile(
    onTap: () {
      // Get.to(UserChatScreen(userid: id, Username: username));
      // Get.to(ChatUi(userid: id, Username: username));
      Get.to(ChatUi(userid: id, userName: username));
    },
    // contentPadding: EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
    ),
    tileColor: Colors.white,
    leading: CacheImage(
      imageUrl: userimage,
      width: 40,
      height: 40,
      circle: true,
    ),

    subtitle: Text(
      username,
      style: const TextStyle(color: Colors.black),
    ),
    title: Text(
      username,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ),
    trailing: IconButton(
      onPressed: () {
        // Get.to(UserChatScreen(userid: id, Username: username));
        // Get.to(ChatUi(userid: id, Username: username));
        // Get.to(ChatUi());
        Get.to(ChatUi(userid: id, userName: username));
      },
      icon: const Icon(
        Icons.arrow_right,
        color: Colors.black,
      ),
    ),
  );
}
