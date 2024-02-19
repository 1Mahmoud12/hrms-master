import 'dart:convert';

import 'package:cnattendance/core/services/api/remote/errors/failures.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/addMaintenance/data/model/mainteanace_periodic_params.dart';
import 'package:cnattendance/screen/addMaintenance/data/model/success_maintenance_contract_periodic.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddMaintenancePeriodicDataSource {
  static Future<Either<Failure, SuccessMaintenanceContractModel>> addMaintenancePeriodic(
    String city,
    String name,
    String customerId,
    String location,
    String numElevators,
    String model,
    String numberStops,
    String maximumLoad,
    String installDate,
    String statusElevator,
    String availableCompany,
  ) async {
    final uri = Uri.parse(EndPoints.addPeridics);
    debugPrint(EndPoints.addPeridics);

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $tokenCache'};

    try {
      // debugPrint('working');
      // var fcm = await FirebaseMessaging.instance.getToken();
      debugPrint(
        MaintenancePeriodicParams(
          city: city,
          name: name,
          customerId: customerId,
          location: location,
          numElevators: numElevators,
          model: model,
          numberStops: numberStops,
          maximumLoad: maximumLoad,
          installDate: installDate,
          statusElevator: statusElevator,
          availableCompany: availableCompany,
        ).toJson().toString(),
      );
      final response = await http.post(
        uri,
        headers: headers,
        body: MaintenancePeriodicParams(
          city: city,
          name: name,
          customerId: customerId,
          location: location,
          numElevators: numElevators,
          model: model,
          numberStops: numberStops,
          maximumLoad: maximumLoad,
          installDate: installDate,
          statusElevator: statusElevator,
          availableCompany: availableCompany,
        ).toJson(),
      );
      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());
      debugPrint(headers.toString());
      if (responseData['success'] == false) throw responseData['message'];
      final responseJson = SuccessMaintenanceContractModel.fromJson(responseData);

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
