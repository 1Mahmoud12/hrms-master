import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class TranslationController extends GetxController {
  String? selectedValue = 'English';
  // Define a list of items for the radio buttons.
  List<String> radioItems = [
    'English',
    'Arabic',
  ];

  void updateonchangevalue(value) {
    selectedValue = value;
    update();
  }

  void updatetranslation() {
    EasyLoading.show(status: ' Updating Language..', maskType: EasyLoadingMaskType.black);

    final String localvalue = selectedValue == 'English' ? 'en' : 'ar';
    final String localcountry = localvalue == 'en' ? 'US' : 'SA';
    final Locale newLocale = Locale(localvalue, localcountry);
    Get.updateLocale(newLocale);

    selectedValue = selectedValue;
    EasyLoading.dismiss();
    update();
  }

  void getCurrentLanguage() {
    final Locale? currentLocale = Get.locale;
    if (currentLocale != null && currentLocale.languageCode == 'en') {
      selectedValue = 'English';
      //return 'English';
    } else {
      selectedValue = 'Arabic';
    }
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentLanguage();
  }
}
// The argument type 'String' can't be assigned to the parameter type 'Locale'.A value of type 'Locale?' can't be assigned to a variable of type 'Locale'.
// Try changing the type of the variable, or casting the right-hand type to 'Locale'.
