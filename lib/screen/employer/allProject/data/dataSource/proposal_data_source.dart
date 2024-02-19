import 'dart:convert';

import 'package:cnattendance/core/services/api/remote/errors/failures.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/add_proposal.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/add_report_engineer_params.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/add_report_proposal_sales_params.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/all_proposals_model.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/proposal_one_model.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProposalDataSource {
  static Future<Either<Failure, AllProposalsModel>> getProposals() async {
    final uri = Uri.parse(EndPoints.allProposals);
    debugPrint(EndPoints.allProposals);

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
      final responseJson = AllProposalsModel.fromJson(responseData);

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  static Future<Either<Failure, ProposalOneModel>> getOneProposal({required int idProposal}) async {
    final uri = Uri.parse('${EndPoints.allProposals}/$idProposal');
    debugPrint('URL =======> ${EndPoints.allProposals}/$idProposal');

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $tokenCache'};

    try {
      // debugPrint('working');
      // var fcm = await FirebaseMessaging.instance.getToken();

      final response = await http.get(
        uri,
        headers: headers,
      );
      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());
      if (responseData['status'] == false) throw responseData['message'];
      final responseJson = ProposalOneModel.fromJson(responseData);

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  static Future<Either<Failure, AddProposalModel>> postReportEngineerProposal({
    required int formRequestId,
    required String cost,
    required String reportEngineer,
    String? reportId,
    String? reportSales,
  }) async {
    final uri = reportId == null ? Uri.parse(EndPoints.proposalEngineerStore) : Uri.parse('${EndPoints.proposalEngineerUpdate}/$reportId');
    debugPrint('Url ======> $uri ');

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $tokenCache'};

    try {
      // debugPrint('working');
      // var fcm = await FirebaseMessaging.instance.getToken();

      debugPrint(
          '${AddReportEngineerParams(formRequestId: formRequestId, reportSales: reportSales, reportTechnical: reportEngineer, cost: cost).toJson()}');
      final response = await http.post(
        uri,
        headers: headers,
        body: AddReportEngineerParams(formRequestId: formRequestId, reportSales: reportSales, reportTechnical: reportEngineer, cost: cost).toJson(),
      );
      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());
      if (responseData['status'] == false) throw responseData['message'];
      final responseJson = AddProposalModel.fromJson(responseData);

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }

  static Future<Either<Failure, AddProposalModel>> postReportSalesProposal({
    required int formRequestId,
    required String reportSales,
    String? reportId,
  }) async {
    final uri = reportId == null ? Uri.parse(EndPoints.proposalSalesStore) : Uri.parse('${EndPoints.proposalSalesUpdate}/$reportId');
    debugPrint('Url ======> $uri ');

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $tokenCache'};

    try {
      // debugPrint('working');
      // var fcm = await FirebaseMessaging.instance.getToken();

      final response = await http.post(
        uri,
        headers: headers,
        body: AddReportSalesParams(formRequestId: formRequestId, reportSales: reportSales).toJson(),
      );
      final responseData = json.decode(response.body);

      debugPrint(responseData.toString());
      if (responseData['status'] == false) throw responseData['message'];
      final responseJson = AddProposalModel.fromJson(responseData);

      return Right(responseJson);
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioException(error));
      }
      return left(ServerFailure(error.toString()));
    }
  }
}
