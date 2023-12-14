import 'package:cnattendance/provider/holidayprovider.dart';
import 'package:cnattendance/widget/holiday/holidaycardview.dart';
import 'package:cnattendance/widget/holiday/toggleholiday.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class HolidayScreen extends StatelessWidget {
  static const routeName = '/holidays';

  const HolidayScreen({super.key});

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
      child: Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text('Holidays'),
          ),
          body: RefreshIndicator(
            onRefresh: () {
              return loadHolidays();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                child: const Column(
                  children: [ToggleHoliday(), HolidayCardView()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
