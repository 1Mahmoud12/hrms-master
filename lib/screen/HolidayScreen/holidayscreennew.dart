import 'dart:io';

import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/holidayprovider.dart';
import 'package:cnattendance/widget/holiday/holidaycardview.dart';
import 'package:cnattendance/widget/holiday/toggleholiday.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HolidayScreenNew extends StatelessWidget {
  static const routeName = '/holidays';

  const HolidayScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HolidayProvider(),
      child: const Holiday(),
    );
  }
}

class Holiday extends StatefulWidget {
  const Holiday({super.key});

  @override
  State<StatefulWidget> createState() => HolidayState();
}

class HolidayState extends State<Holiday> {
  bool inital = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (inital) {
      loadHolidays();
      inital = false;
    }
    super.didChangeDependencies();
  }

  Future<String> loadHolidays() async {
    setState(() async {
      isLoading = true;
      EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
      await Provider.of<HolidayProvider>(context, listen: false).getHolidays();
      isLoading = false;
      EasyLoading.dismiss();
    });

    return 'loaded';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Platform.isAndroid
                  ? const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),),
          title: Text(
            'Holiday'.tr,
            style: Styles.styleHeader,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () {
            return loadHolidays();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ToggleHoliday(),
                      HolidayCardView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
