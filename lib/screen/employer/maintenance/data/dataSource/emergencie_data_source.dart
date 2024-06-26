import 'dart:convert';
import 'dart:io';

import 'package:cnattendance/core/services/api/remote/errors/failures.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/data/model/emergencies_model.dart';
import 'package:cnattendance/screen/employer/maintenance/data/model/one_emergency_model.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class EmergencyDataSource {
  static Future<Either<Failure, EmergenciesModel>> getAllEmergencies() async {
    final uri = Uri.parse(EndPoints.getEmergencie);
    debugPrint(EndPoints.getEmergencie);

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $tokenCache',
    };
    debugPrint(headers.toString());
    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      debugPrint(response.body);
      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());
      if (responseData['status'] == false) throw responseData['message'];
      final responseJson = EmergenciesModel.fromJson(responseData);

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  static Future<Either<Failure, OneEmergencyModel>> getOneEmergencie({
    required String idEmergency,
  }) async {
    final uri = Uri.parse('${EndPoints.getOneEmergencie}$idEmergency');
    debugPrint('${EndPoints.getOneEmergencie}$idEmergency');

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
      final responseJson = OneEmergencyModel.fromJson(responseData);

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  static Future<Either<Failure, EmergenciesModel>> addEmergency({
    required String name,
    required String description,
    required String location,
    required File imageFile,
  }) async {
    final uri = Uri.parse(EndPoints.addEmergencie);

    final Map<String, String> headers = {
      'Authorization': 'Bearer $tokenCache',
    };

    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);

    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['location'] = location;

    final stream = http.ByteStream(imageFile.openRead());
    final length = await imageFile.length();
    final multipartFile = http.MultipartFile(
      'img',
      stream,
      length,
      filename: basename(imageFile.path),
    );

    request.files.add(multipartFile);

    try {
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 201) {
        final responseDataDecoded = json.decode(responseData.body);
        final responseJson = EmergenciesModel.fromJson(responseDataDecoded);
        return Right(responseJson);
      } else {
        final responseDataDecoded = json.decode(responseData.body);
        return Left(ServerFailure(responseDataDecoded['message']));
      }
    } catch (error) {
      if (error is DioException) {
        return Left(ServerFailure.fromDioException(error));
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
