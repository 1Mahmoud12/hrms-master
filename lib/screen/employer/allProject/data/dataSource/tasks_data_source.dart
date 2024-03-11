import 'dart:convert';

import 'package:cnattendance/core/services/api/remote/errors/failures.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/add_task_params.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TasksDataSource {
  static Future<Either<Failure, String>> postAddTasks({
    required AddTaskParams addTaskParams,
  }) async {
    final uri = Uri.parse(EndPoints.createTasks);
    debugPrint('Url ======> $uri ');

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $tokenCache'};

    try {
      // debugPrint('working');
      // var fcm = await FirebaseMessaging.instance.getToken();

      debugPrint('${addTaskParams.toJson()}');
      final response = await http.post(
        uri,
        headers: headers,
        body: addTaskParams.toJson(),
      );
      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());
      if (responseData['status'] == false) throw responseData['message'];
      final String responseJson = responseData['message'];

      return Right(responseJson);
    } catch (error) {
      debugPrint('==== Error =$error');
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  static Future<Either<Failure, String>> postEditTasks({
    required AddTaskParams addTaskParams,
    required String idTask,
  }) async {
    final uri = Uri.parse('${EndPoints.editTasks}/$idTask');
    debugPrint('Url ======> $uri ');

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $tokenCache'};

    try {
      // debugPrint('working');
      // var fcm = await FirebaseMessaging.instance.getToken();

      debugPrint('${addTaskParams.toJson()}');
      final response = await http.post(
        uri,
        headers: headers,
        body: addTaskParams.toJson(),
      );
      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());
      if (responseData['status'] == false) throw responseData['message'];
      final String responseJson = responseData['message'];

      return Right(responseJson);
    } catch (error) {
      debugPrint('==== Error =$error');
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
