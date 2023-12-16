import 'dart:convert';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/supportlistresponse/supportlistresponse.dart';
import 'package:cnattendance/model/support.dart';
import 'package:cnattendance/screen/profile/supportdetailscreen.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SupportListController extends GetxController {
  RxList<Support> supportList = <Support>[].obs;
  final filteredList = <Support>[].obs;

  final selected = 'All'.obs;
  final indexSelected = 0.obs;
  final List<String> filterLabel = [
    'All'.tr,
    'Pending'.tr,
    'In_progress'.tr,
    'Solved'.tr,
  ];

  Future<void> getSupportList() async {
    final uri = Uri.parse('${EndPoints.SUPPORT_LIST_URL}?per_page=50&page=1');

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {'Accept': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
      EasyLoading.show(status: 'Loading....', maskType: EasyLoadingMaskType.black);
      final response = await http.get(uri, headers: headers);
      debugPrint(response.body);
      EasyLoading.dismiss();

      final responseData = json.decode(response.body);
      print(responseData);

      if (response.statusCode == 200) {
        final supportResponse = supportlistresponse.fromJson(responseData);
        final list = <Support>[];
        for (final support in supportResponse.data.data) {
          print('----support.query_date');
          print(support.query_date);

          // final date = new DateFormat('MMMM dd yyyy').parse(support.query_date);

          final date = support.query_date;
          final String inputDate = date;
          final DateFormat inputDateFormat = DateFormat('MMM dd yyyy');
          final DateTime dateTime = inputDateFormat.parse(inputDate);
          final String formattedDate = DateFormat('E-MM-yyyy').format(dateTime);
          final String formatteddateDay = DateFormat('E').format(dateTime);

          print('----date');
          print(date);
          list.add(
            Support(
              support.title,
              support.description,
              support.query_date,
              support.status,
              support.requested_department,
              formatteddateDay,
              formattedDate,
              support.updated_by,
              support.updated_at,
            ),
          );
        }

        supportList.value = list;
        filterList();
      } else {
        final errorMessage = responseData['message'];
        throw errorMessage;
      }
    } catch (e) {
      EasyLoading.dismiss();
      rethrow;
    }
  }

  void filterList() {
    filteredList.clear();

    if (selected.value == 'All') {
      indexSelected.value = 0;
      filteredList.addAll(supportList);
    } else {
      for (final support in supportList) {
        if (support.status == selected.value) {
          support.status == 'Pending'
              ? indexSelected.value = 1
              : support.status == 'In Progress'
                  ? indexSelected.value = 2
                  : indexSelected.value = 3;
          filteredList.add(support);
        }
      }
    }
  }

  @override
  Future<void> onInit() async {
    await getSupportList();
    super.onInit();
  }

  void onSupportClicked(Support support) {
    Get.to(SupportDetailScreen(support), transition: Transition.cupertino);
  }
}
