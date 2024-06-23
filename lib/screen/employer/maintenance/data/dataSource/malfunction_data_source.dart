import 'dart:convert';
import 'dart:io';
import 'package:cnattendance/core/services/api/remote/errors/failures.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/data/model/emergencies_model.dart';
import 'package:cnattendance/screen/employer/maintenance/data/model/malfunction_model.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class MalfunctionDataSource {
  static Future<Either<Failure, MalfunctionModel>> getAllMalfunctions() async {
    final uri = Uri.parse(EndPoints.getMalfunction);
    debugPrint(EndPoints.getMalfunction);

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
      final responseJson = MalfunctionModel.fromJson(responseData);

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  static Future<Either<Failure, MalfunctionModel>> addMalfunction({
    required String name,
    required String description,
    required String location,
    required File imageFile,
  }) async {
    final uri = Uri.parse(EndPoints.addMalfunction);

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
        final responseJson = MalfunctionModel.fromJson(responseDataDecoded);
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

  static Future<Either<Failure, MalfunctionModel>> uploadPayment({
    required String malfunctionId,
    required File imageFile,
  }) async {
    final uri = Uri.parse(EndPoints.uploadMalfunctionPayment);

    final Map<String, String> headers = {
      'Authorization': 'Bearer $tokenCache',
    };

    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll(headers);

    request.fields['malfunction_id'] = malfunctionId;

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
        final responseJson = MalfunctionModel.fromJson(responseDataDecoded);
        return Right(responseJson);
      } else {
        final responseDataDecoded = json.decode(responseData.body);
        final result = responseDataDecoded['message'];
        print('res=========>$result');
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
