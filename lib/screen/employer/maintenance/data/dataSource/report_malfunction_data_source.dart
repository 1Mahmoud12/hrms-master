import 'dart:convert';

import 'package:cnattendance/core/services/api/remote/errors/failures.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/data/model/one_report_malfunction_model.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportMalfunctionDataSource {
  static Future<Either<Failure, OneReportMalfunctionModel>> getOneReport({
    required String idReport,
  }) async {
    final uri = Uri.parse('${EndPoints.getOneReportMalF}$idReport');
    debugPrint('${EndPoints.getOneReportMalF}$idReport');

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $tokenCache',
    };
    debugPrint(headers.toString());
    try {
      // debugPrint('working');
      // var fcm = await FirebaseMessaging.instance.getToken();

      final response = await http.get(
        uri,
        headers: headers,
      );
      debugPrint(response.body);
      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());
      if (responseData['status'] == false) throw responseData['message'];
      final responseJson = OneReportMalfunctionModel.fromJson(responseData);

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  static Future<Either<Failure, OneReportMalfunctionModel>> addReport({
    required String malfunctionId,
    required String description,
    required String price,
    required String status,
    required String product,
  }) async {
    final uri = Uri.parse(EndPoints.addReportMalF);

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $tokenCache',
    };

    final Map<String, String> body = {
      'malfunction_id': malfunctionId,
      'description': description,
      'price': price,
      'status': status,
      'product': product,
    };

    debugPrint(headers.toString());
    debugPrint(json.encode(body));
    try {
      final response = await http.post(uri, headers: headers, body: body);

      debugPrint(response.body);
      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());
      if (responseData['status'] == false) throw responseData['message'];
      final responseJson = OneReportMalfunctionModel.fromJson(responseData);
      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
