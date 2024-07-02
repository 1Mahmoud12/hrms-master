import 'dart:convert';

import 'package:cnattendance/core/services/api/remote/errors/failures.dart';
import 'package:cnattendance/core/utils/constants.dart';

import 'package:cnattendance/utils/endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ResetPasswordDataSource {
  Future<Either<Failure, String>> resetPassword(String email) async {
    final url = Uri.parse(EndPoints.getEmergencie);
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokenCache',
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          'email': email,
        }),
      );
      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());

      if (responseData['status'] == false) {
        return const Right('Success request');
      } else {
        return left(
          ServerFailure(
            'Failed to send password reset request: ${response.body}',
          ),
        );
      }
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
