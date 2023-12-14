import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cnattendance/Controller/UserChatController.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UserChatScreen extends StatelessWidget {
  int userid;
  String Username;
  UserChatScreen({super.key, required this.userid, required this.Username});

  Future<String> getTeam() async {
    return 'Loaded';
  }

  final UserChatCont = Get.put(UserChatController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        // backgroundColor: Color.fromARGB(255, 224, 222, 222),
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: Text(
            Username,
          ),
          elevation: 0,
        ),
        body: GetBuilder(
            init: UserChatCont,
            builder: (context) {
              return SafeArea(
                child: Container(
                  color: const Color(0XFFf7f7fc),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.78,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.78,
                                width: Get.width * 1,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('ChatSystem')
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final messages = snapshot.data!.docs;
                                      print('my idd ${UserChatCont.userid}');
                                      print(messages);
                                      return ListView.builder(
                                        itemCount: messages.length,
                                        itemBuilder: (context, index) {
                                          final message = messages[index].data()!
                                              as Map<String, dynamic>;
                                          final senderId = message['sendfrom'];
                                          final text = message['message'];

                                          if (UserChatCont.userid == senderId) {
                                            return MessageSendComponent(text);
                                          } else {
                                            return MessageRecievedComponent(
                                                text,);
                                          }
                                        },
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                              ),
                              // MessageRecievedComponent(),
                              // MessageSendComponent(),
                              // MessageRecievedComponent(),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.add,
                                    color: Color(0XFFADB5BD),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: Get.width * 0.75,
                                child: TextField(
                                  controller: UserChatCont.message,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color(0XFFF7F7FC),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0XFFF7F7FC)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(
                                              0XFFF7F7FC,),), // Set border color to match fillColor
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(
                                              0XFFF7F7FC,),), // Set border color to match fillColor
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    UserChatCont.sendmessagetouser(userid);
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: Color(0xFF635F54),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },),
      ),
    );
  }
}

Widget MessageSendComponent(message) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: Get.width * 0.5,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset(-33.96, 0.0),
                end: FractionalOffset(0.9616, 0.0),
                colors: [Color(0xFFEDE7B0), Color(0xFF635F54)],
                stops: [0.0, 1.0],
                transform: GradientRotation(
                    134 * 3.1415927 / 180.0,), // Convert degrees to radians
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 10),
                    child: Text(
                      '9.19 . Read',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget MessageRecievedComponent(message) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          width: Get.width * 0.5,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Text(
                  '9.19',
                  style: TextStyle(color: Color(0XFFADB5BD)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
