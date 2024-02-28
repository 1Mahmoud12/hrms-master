import 'dart:convert';
import 'dart:io';

import 'package:cnattendance/data/source/network/connect.dart';
import 'package:cnattendance/data/source/network/model/leaveissue/IssueLeaveResponse.dart';
import 'package:cnattendance/data/source/network/model/tadadetail/tadadetailresponse.dart';
import 'package:cnattendance/data/source/network/model/tadalist/tadalistresponse.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../core/utils/constants.dart';

class TadaRepository {
  Future<TadaListResponse> getTadaList() async {
    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $tokenCache',
    };

    try {
      final response = await Connect().getResponse(EndPoints.TADA_LIST_URL, headers);
      debugPrint(response.body);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final tadaResponse = TadaListResponse.fromJson(responseData);

        return tadaResponse;
      } else {
        final errorMessage = responseData['message'];
        debugPrint(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }

  Future<TadaDetailResponse> getTadaDetail(String tadaId) async {
    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $tokenCache',
    };
    debugPrint(tokenCache);

    try {
      final int tadaIds = int.parse(tadaId);
      final response = await Connect().getResponse('${EndPoints.TADA_DETAIL_URL}/$tadaIds', headers);
      debugPrint(response.body);

      final responseData = json.decode(response.body);
      debugPrint('responseData -------------------');
      debugPrint('$responseData');
      if (response.statusCode == 200) {
        final tadaResponse = TadaDetailResponse.fromJson(responseData);

        return tadaResponse;
      } else {
        final errorMessage = responseData['message'];
        debugPrint(errorMessage);
        throw errorMessage;
      }
    } catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }

  Future<IssueLeaveResponse> createTada(
    String title,
    String description,
    String expenses,
    List<PlatformFile> fileList,
  ) async {
    final uri = Uri.parse(EndPoints.TADA_STORE_URL);
    debugPrint(EndPoints.TADA_STORE_URL);
    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Content-type': 'multipart/form-data',
      'Authorization': 'Bearer $tokenCache',
    };

    final requests = http.MultipartRequest('POST', uri);
    requests.headers.addAll(headers);

    requests.fields.addAll({
      'title': title,
      'description': description,
      'total_expense': expenses,
    });

    for (final filed in fileList) {
      final file = File(filed.path!);
      final stream = http.ByteStream(Stream.castFrom(file.openRead()));
      final length = await file.length();

      final multipartFile = http.MultipartFile(
        'attachments[]',
        stream,
        length,
        filename: filed.name,
      );
      requests.files.add(multipartFile);
    }
    final responseStream = await requests.send();

    final response = await http.Response.fromStream(responseStream);
    debugPrint(response.toString());
    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      final tadaResponse = IssueLeaveResponse.fromJson(responseData);
      return tadaResponse;
    } else {
      final errorMessage = responseData['message'];
      debugPrint(errorMessage);
      throw errorMessage;
    }
  }
}
