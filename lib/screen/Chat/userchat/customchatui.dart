import 'dart:io';

import 'package:cnattendance/Controller/UserChatController.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';

class CustomChatui extends StatelessWidget {
  CustomChatui({super.key});

  final ChatControl = Get.put(UserChatController());

  @override
  Widget build(BuildContext context) {
    File? selectedFile;
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // Return an AlertDialog or CupertinoAlertDialog for iOS-style dialog
          return AlertDialog(
            title: const Text('Select File type'),
            content: SizedBox(
              height: Get.height * 0.12,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Row(
                        children: [
                          Icon(Icons.image_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Image',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Row(
                        children: [
                          Icon(Icons.file_present_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'File',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }

    String chatgroup;
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: const Color(0XFFf7f7fc),
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: const Text('Chat'),
          elevation: 0,
        ),
        body: GetBuilder(
          init: ChatControl,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async {
                return !ChatControl.isLoading;
              },
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          MessageSendComponent(
                            'To protect users and maintain a high quality trading market, Binance conducts periodic reviews of all listed spot trading ',
                            '9:20',
                          ),
                          MessageRecievedComponent(
                            'To protect users and maintain a high quality trading market, Binance conducts periodic reviews ',
                            '12:4',
                          ),
                          SendDocumentToUser(),
                          ReceiveDocumentToUser(),
                        ],
                      ),
                    ),
                    _chatInput(ChatControl, 1, ChatControl.scrollController, _showDialog),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _chatInput(ChatControl, userid, _scrollController, Function _showDialog) {
  return Row(
    children: [
      //input field & buttons
      Expanded(
        child: Container(
          color: Colors.white,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //emoji button
                IconButton(
                  onPressed: () async {
                    _showDialog();
                    // ----------- Pick Image

                    // final ImagePicker picker = ImagePicker();
                    // // Picking multiple images
                    // final List<XFile> images =
                    //     await picker.pickMultiImage(imageQuality: 70);
                    // // uploading & sending image one by one
                    // for (var i in images) {
                    //   print('Image Path: ${i.path}');
                    //   log('Image Path: ${i.path}');
                    //   ChatControl.sendChatImage(File(i.path), userid);
                    // }
                  },
                  icon: const Icon(Icons.add, color: Colors.black, size: 25),
                ),

                Expanded(
                  child: TextField(
                    controller: ChatControl.selectedMessage,
                    // controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      // if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration:
                        const InputDecoration(hintText: 'Type Something...', hintStyle: TextStyle(color: Colors.black), border: InputBorder.none),
                  ),
                ),

                Transform.rotate(
                  angle: -45 * (3.14159265359 / 180),
                  child: IconButton(
                    onPressed: () async {
                      ChatControl.sendmessagetouser(userid);

                      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                    },
                    icon: const Icon(Icons.send, color: Color(0xFF635F54), size: 26),
                  ),
                ),

                //adding some space
                SizedBox(width: Get.width * .02),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget MessageSendComponent(message, time) {
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
              transform: GradientRotation(134 * 3.1415927 / 180.0), // Convert degrees to radians
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
                    child: Text(
                      '$time',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
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

Widget MessageRecievedComponent(message, time) {
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
            ),
          ),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Text(
                  '$time',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(
                      0XFFADB5BD,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget Getimgefromuser(recieveimage) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          width: Get.width * 0.5,
          height: Get.height * 0.3,
          decoration: const BoxDecoration(
            // color: Colors.white,
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: SizedBox(
                width: Get.width * 0.5,
                height: Get.height * 0.3,
                child: FullScreenWidget(
                  disposeLevel: DisposeLevel.Medium,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/placeholder-image.png', // Replace with your placeholder image asset path
                    image: recieveimage,
                    fit: BoxFit.fill,
                    imageErrorBuilder: (context, error, stackTrace) {
                      // This function is called when the image fails to load
                      // You can return a fallback widget here
                      return const Center(
                        child: Text('Image not available'),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget Getimgefromsend(recieveimage) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: Get.width * 0.5,
          height: Get.height * 0.3,
          decoration: const BoxDecoration(
            color: Color(0xFF635F54),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: SizedBox(
                width: Get.width * 0.5,
                height: Get.height * 0.3,
                child: FullScreenWidget(
                  disposeLevel: DisposeLevel.Medium,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/placeholder-image.png', // Replace with your placeholder image asset path
                    image: recieveimage,
                    fit: BoxFit.fill,
                    imageErrorBuilder: (context, error, stackTrace) {
                      // This function is called when the image fails to load
                      // You can return a fallback widget here
                      return const Center(
                        child: Text('Image not available'),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget SendDocumentToUser() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: Get.width * 0.6,
          height: Get.height * 0.13,
          decoration: const BoxDecoration(
            color: Color(0xFF635F54),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Document File',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.download_for_offline_outlined,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: Text(
                    '9:20',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget ReceiveDocumentToUser() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          width: Get.width * 0.6,
          height: Get.height * 0.13,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Document File',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.download_for_offline_outlined,
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: Text(
                    '9:20',
                    style: TextStyle(fontSize: 12, color: Color(0XFFADB5BD)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
