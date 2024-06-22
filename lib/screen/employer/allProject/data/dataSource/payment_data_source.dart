import 'dart:convert';

import 'package:cnattendance/core/services/api/remote/errors/failures.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/payment_model.dart';

class AllPaymentsDataSource {
  static Future<Either<Failure, PaymentsProjectModel>> getPayment(String idProject) async {
    final uri = Uri.parse('${EndPoints.getPayment}/$idProject');
    debugPrint(EndPoints.getPayment);

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $tokenCache'};
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
      final responseJson = PaymentsProjectModel.fromJson(responseData);

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }



}
