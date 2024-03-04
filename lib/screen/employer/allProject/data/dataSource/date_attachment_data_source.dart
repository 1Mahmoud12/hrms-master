import 'dart:convert';

import 'package:cnattendance/core/services/api/remote/errors/failures.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/add_attachments_params.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/change_date_params.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DateAttachmentDataSource {
  static Future<Either<Failure, String>> postUpdateDeadline({
    required ChangeDateParams changeDateParams,
  }) async {
    final uri = Uri.parse(EndPoints.updateProjectDeadlineUrl);
    debugPrint('Url ======> $uri ');

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $tokenCache'};

    try {
      // debugPrint('working');
      // var fcm = await FirebaseMessaging.instance.getToken();

      debugPrint('${changeDateParams.toJson()}');
      final response = await http.post(
        uri,
        headers: headers,
        body: changeDateParams.toJson(),
      );
      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());
      if (responseData['status'] == false) throw responseData['message'];
      final String responseJson = responseData['message'];

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  static Future<Either<Failure, String>> postDeleteAttachment({
    required String attachmentId,
  }) async {
    final uri = Uri.parse(EndPoints.deleteProjectsAttachments);
    debugPrint('Url ======> $uri ');

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $tokenCache'};

    try {
      // debugPrint('working');
      // var fcm = await FirebaseMessaging.instance.getToken();

      final response = await http.post(
        uri,
        headers: headers,
        body: {
          'attachmentId': attachmentId,
        },
      );
      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());
      if (responseData['status'] == false) throw responseData['message'];
      final String responseJson = responseData['message'];

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  static Future<Either<Failure, String>> postAddAttachment({
    required AttachmentParams attachmentParams,
  }) async {
    final uri = Uri.parse(EndPoints.addProjectsAttachmentUrl);
    debugPrint('Url ======> $uri ');

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $tokenCache'};

    try {
      // debugPrint('working');
      // var fcm = await FirebaseMessaging.instance.getToken();

      debugPrint('${attachmentParams.toJson()}');
      /*  final response = await http.post(
        uri,
        headers: headers,
        body: attachmentParams.toJson(),
      );*/
      final form = http.MultipartRequest(
        'Post', // Replace with your API endpoint
        uri,
      );
      form.fields.addAll({'projectid': attachmentParams.projectId});
      form.headers.addAll(headers);
      for (final file in attachmentParams.attachments) {
        final part = await http.MultipartFile.fromPath(
          'attachments[]', // Specify array key for multiple files
          file.path,
        );
        form.files.add(part);
      }
      final http.StreamedResponse responseStream = await form.send();
      print('responseStream ${responseStream.statusCode}');
/*
      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());
      if (responseData['status'] == false) throw responseData['message'];
      final String responseJson = responseData['message'];
      debugPrint(responseData['message']);
*/

      return Right(responseStream.reasonPhrase ?? 'Success');
    } catch (error) {
      debugPrint('Error == >$error');
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
