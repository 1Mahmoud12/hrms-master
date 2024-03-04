import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cnattendance/Controller/NotificationController.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class UserChatController extends GetxController {
  late int userid;
  bool isLoading = false;
  final ScrollController scrollController = ScrollController();
  final notification = Get.put(NotificationController());

  @override
  void onInit() {
    super.onInit();
    getcurrentuserid();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  TextEditingController message = TextEditingController();
  static FirebaseStorage storage = FirebaseStorage.instance;

  void getcurrentuserid() async {
    userid = userCache!.id!;
    update();
  }

  void sendmessagetouser(id) async {
    final int myuserid = userCache!.id!;
    final DateTime now = DateTime.now();
    final String formattedDate = '${now.year}-${now.month}-${now.day}';
    final String formattedTime = '${now.hour}:${now.minute}:${now.second}';
    debugPrint('no messgae');
    if (message.text.isNotEmpty) {
      final usermessage = message.text;
      final String chatgroup = myuserid > id ? '${myuserid}to$id' : '${id}to$myuserid';

      final CollectionReference usersdata = FirebaseFirestore.instance.collection('ChatSystem');

      usersdata.add({
        'sendfrom': myuserid,
        'sento': id,
        'chat_group': chatgroup,
        'message': usermessage,
        'timestamp': now,
        'date': formattedDate,
        'time': formattedTime,
        'status': 'Read',
        'is_image': false,
        'image_link': null,
        'is_file': false,
        'file_link': null,
      }).then(
        (value) {
          debugPrint('done');
          message.clear();
          notification.SendChatNotification(usermessage, id);
        },
        // ignore: invalid_return_type_for_catch_error
      ).catchError((e) => debugPrint('$e'));
    }
  }

  static int getuniquenumber() {
    // Get the current timestamp in milliseconds
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    // Generate a random number
    final int random = Random().nextInt(9999); // Adjust the range as needed
    // Combine the timestamp and random number to create a unique number
    final int uniqueNumber = timestamp * 10000 + random;
    return uniqueNumber;
  }

  Future<void> sendChatfile(selectedFile, id) async {
    final filepath = selectedFile!.path.split('/').last;
    isLoading = true;
    String? downloadUrl;
    EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);

    final String chatgroup = userCache!.id! > id ? '${userCache!.id}to$id' : '${id}to${userCache!.id}';

    final uniquenumber = UserChatController.getuniquenumber();

    final Reference storageRef = FirebaseStorage.instance.ref().child('files/$chatgroup/$uniquenumber$filepath');

    final task = storageRef.putFile(selectedFile!);
    await task.whenComplete(() async {
      // Get the download URL after upload is complete
      downloadUrl = await storageRef.getDownloadURL();
    });

    debugPrint('path $filepath');
    InsertDataInChatSystem(id, downloadUrl, 'file', filepath);

    isLoading = false;
    EasyLoading.dismiss();
  }

  Future<void> sendChatImage(File file, id) async {
    isLoading = true;
    EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);

    final String chatgroup = userCache!.id! > id ? '${userCache!.id}to$id' : '${id}to${userCache!.id}';

    //getting image file extension
    final ext = file.path.split('.').last;
    final uniquenumber = UserChatController.getuniquenumber();

    //storage file ref with path
    final ref = storage.ref().child('images/$chatgroup/$uniquenumber${DateTime.now().millisecondsSinceEpoch}.$ext');

    // //uploading image
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {});
    final imageUrl = await ref.getDownloadURL();

    InsertDataInChatSystem(id, imageUrl, 'image');

    isLoading = false;
    EasyLoading.dismiss();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getallusermessages(chatgroup) {
    return FirebaseFirestore.instance.collection('ChatSystem').where('chat_group', isEqualTo: '$chatgroup').orderBy('timestamp').snapshots();
  }

  void InsertDataInChatSystem(id, fileurl, attactmenttype, [filname = '']) async {
    final String chatgroup = userCache!.id! > id ? '${userCache!.id}to$id' : '${id}to${userCache!.id}';

    final DateTime now = DateTime.now();
    final String formattedDate = '${now.year}-${now.month}-${now.day}';
    final String formattedTime = '${now.hour}:${now.minute}:${now.second}';

    final CollectionReference usersdata = FirebaseFirestore.instance.collection('ChatSystem');

    if (attactmenttype == 'file') {
      usersdata.add({
        'sendfrom': userCache!.id,
        'sento': id,
        'chat_group': chatgroup,
        'timestamp': now,
        'date': formattedDate,
        'time': formattedTime,
        'status': 'Read',
        'is_image': false,
        'image_link': null,
        'is_file': true,
        'file_link': fileurl,
        'file_name': filname,
      }).then(
        (value) {
          notification.SendChatNotification('You Have recieved An Attachment', id);
          debugPrint('done');
        },
        // ignore: invalid_return_type_for_catch_error
      ).catchError((e) => debugPrint('$e'));
    } else if (attactmenttype == 'image') {
      usersdata.add({
        'sendfrom': userCache!.id,
        'sento': id,
        'chat_group': chatgroup,
        'timestamp': now,
        'date': formattedDate,
        'time': formattedTime,
        'status': 'Read',
        'is_image': true,
        'image_link': fileurl,
        'is_file': false,
        'file_link': null,
      }).then(
        (value) {
          notification.SendChatNotification('You Have recieved An Attachment', id);
          debugPrint('done');
        },
        // ignore: invalid_return_type_for_catch_error
      ).catchError((e) => debugPrint('$e'));
    }
  }

  Future<void> downloadDocument(document, filename) async {
    isLoading = true;
    EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);

    //You can download a single file
    //TODO: DOWNLoad Files

    /*FileDownloader.downloadFile(
      url: document,
      name: filename,
      onProgress: (fileName, double progress) {
        debugPrint('FILE fileName HAS PROGRESS $progress');
      },
      onDownloadCompleted: (String path) {
        debugPrint('FILE DOWNLOADED TO PATH: $path');
        Get.snackbar('Download File', 'File Download Successfully');
      },
      onDownloadError: (String error) {
        debugPrint('DOWNLOAD ERROR: $error');
      },
    );*/

    isLoading = false;
    EasyLoading.dismiss();
  }
}
