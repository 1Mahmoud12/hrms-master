import 'dart:convert';
import 'dart:io';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/leaveissue/IssueLeaveResponse.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;

class RequestController extends GetxController {
  final descriptionController = TextEditingController();
  RxList<PlatformFile> fileList = <PlatformFile>[].obs;

  // void onFileClicked() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   final platformFile = result?.files.single;
  //   if (platformFile != null) {
  //     fileList.add(platformFile);
  //   }
  // }
  void onFileClicked() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    final platformFile = result?.files.single;
    if (platformFile != null) {
      fileList.clear(); // Clear the existing files
      fileList.add(platformFile); // Add the new file
    }
  }

  void removeItem(int index) {
    fileList.removeAt(index);
  }

  Future<IssueLeaveResponse> issueLeave(
    String from,
    String to,
    String reason,
    int leaveId,
  ) async {
    final uri = Uri.parse(EndPoints.USER_REQUEST_STORE);
    EasyLoading.show(
      status: ' Please Wait..',
      maskType: EasyLoadingMaskType.black,
    );

    // if(fileList.isEmpty){

    // }

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers1 = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    try {
      // final response = await https.post(uri, headers: headers1, body: {
      //   'leave_from': from,
      //   'leave_to': to,
      //   'leave_type_id': leaveId.toString(),
      //   'reasons': reason,
      // });

      final requests = https.MultipartRequest('POST', uri);
      requests.headers.addAll(headers1);

      requests.fields.addAll({
        'leave_from': from,
        'leave_to': to,
        'leave_type_id': leaveId.toString(),
        'reasons': reason,
      });

      for (final filed in fileList) {
        final file = File(filed.path!);
        final stream = https.ByteStream(Stream.castFrom(file.openRead()));
        final length = await file.length();

        final multipartFile = https.MultipartFile(
          'attachment',
          stream,
          length,
          filename: filed.name,
        );
        requests.files.add(multipartFile);
      }
      final responseStream = await requests.send();

      final response = await https.Response.fromStream(responseStream);
      debugPrint(response.toString());
      descriptionController.clear();

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

        final responseJson = IssueLeaveResponse.fromJson(responseData);

        fileList.clear();
        Get.snackbar('Successfully', 'Thank You for Submitted');

        debugPrint(responseJson.toString());
        return responseJson;
      } else {
        EasyLoading.dismiss();

        final errorMessage = responseData['message'];
        Get.snackbar('title', '$errorMessage');
        throw errorMessage;
      }
    } catch (error) {
      Get.snackbar('Error', 'Something Went Wrong');
      EasyLoading.dismiss();

      debugPrint(error.toString());
      rethrow;
    }
  }
}
