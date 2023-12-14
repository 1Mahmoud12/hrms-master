import 'dart:convert';
import 'dart:io';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/leaveissue/IssueLeaveResponse.dart';
import 'package:cnattendance/data/source/network/model/tadadetail/tadadetailresponse.dart';
import 'package:cnattendance/model/attachment.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class EditTadaController extends GetxController {
  RxList<PlatformFile> fileList = <PlatformFile>[].obs;
  RxList<Attachment> attachmentList = <Attachment>[].obs;

  String id = '';

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final expensesController = TextEditingController();

  final key = GlobalKey<FormState>();

  void onFileClicked() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    final platformFile = result?.files.single;
    if (platformFile != null) {
      fileList.add(platformFile);
    }
  }

  void checkForm() {
    if (key.currentState!.validate()) {
      editTada();
    }
  }

  Future<String> getTadaDetail() async {
    final uri =
        Uri.parse("${Constant.TADA_DETAIL_URL}/${Get.arguments["tadaId"]}");

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    try {
      EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
      final response = await http.get(
        uri,
        headers: headers,
      );
      debugPrint(response.body);

      final responseData = json.decode(response.body);
      EasyLoading.dismiss();

      if (response.statusCode == 200) {
        final tadaResponse = TadaDetailResponse.fromJson(responseData);

        final data = tadaResponse.data;
        final attachments = <Attachment>[];
        for (final attachment in data.attachments.image) {
          attachments.add(Attachment(attachment.id, attachment.url, 'image'));
        }
        for (final attachment in data.attachments.file) {
          attachments.add(Attachment(attachment.id, attachment.url, 'file'));
        }

        titleController.text = parse(data.title).body!.text;
        descriptionController.text = parse(data.description).body!.text;
        expensesController.text = data.total_expense.toString();
        attachmentList.value = attachments;

        return 'Loaded';
      } else {
        final errorMessage = responseData['message'];
        print(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      print(e);
      showToast(e.toString());
      rethrow;
    }
  }

  Future<String> editTada() async {
    try {
      final uri = Uri.parse(Constant.TADA_UPDATE_URL);

      final Preferences preferences = Preferences();
      final String token = await preferences.getToken();

      final Map<String, String> headers = {
        'Accept': 'application/json; charset=UTF-8',
        'Content-type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      };
      final requests = http.MultipartRequest('POST', uri);
      requests.headers.addAll(headers);

      requests.fields.addAll({
        'title': titleController.text,
        'description': descriptionController.text,
        'total_expense': expensesController.text,
        'tada_id': id,
      });

      for (final filed in fileList) {
        final file = File(filed.path!);
        final stream = http.ByteStream(Stream.castFrom(file.openRead()));
        final length = await file.length();

        final multipartFile = http.MultipartFile(
            'attachments[]', stream, length,
            filename: filed.name,);
        requests.files.add(multipartFile);
      }

      EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
      final responseStream = await requests.send();

      final response = await http.Response.fromStream(responseStream);

      EasyLoading.dismiss();
      debugPrint(response.toString());
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        final tadaResponse = IssueLeaveResponse.fromJson(responseData);
        showToast('Tada has been updated');
        Get.back();
        return 'Loaded';
      } else {
        final errorMessage = responseData['message'];
        print(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      showToast(e.toString());
      return 'Failed';
    }
  }

  void removeItem(int index) {
    fileList.removeAt(index);
  }

  Future<void> removeAttachment(int id, int index) async {
    final uri = Uri.parse('${Constant.TADA_DELETE_ATTACHMENT_URL}/$id');

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

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
        final tadaResponse = IssueLeaveResponse.fromJson(responseData);

        attachmentList.removeAt(index);
      } else {
        EasyLoading.dismiss();
        final errorMessage = responseData['message'];
        print(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  void onInit() {
    getTadaDetail();
    id = Get.arguments['tadaId'];
    super.onInit();
  }

  Future<void> launchUrls(String _url) async {
    if (!await launchUrl(Uri.parse(_url),
        mode: LaunchMode.externalApplication,)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> launchFile(String _url) async {
    if (!await launchUrl(Uri.file(_url))) {
      throw Exception('Could not launch $_url');
    }
  }
}
