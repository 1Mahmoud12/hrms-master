import 'dart:io';

import 'package:dio/dio.dart';

class AttachmentParams {
  final String projectId;
  final List<File> attachments;

  AttachmentParams({required this.projectId, required this.attachments});

  Future<Map<String, Object>> toJson() async {
    final Map<String, Object> listFiles = {};

    listFiles.addAll({
      'projectid': projectId,
    });
    for (int i = 0; i < attachments.length; i++) {
      listFiles.addAll({
        'attachments': '${[await MultipartFile.fromFile(attachments[i].path)]}'
      });
    }

    return listFiles;
  }
}
