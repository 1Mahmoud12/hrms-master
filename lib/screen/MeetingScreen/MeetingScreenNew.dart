import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/meetingprovider.dart';
import 'package:cnattendance/widget/meeting/meetinglistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MeetingScreenNew extends StatefulWidget {
  const MeetingScreenNew({super.key});

  @override
  State<StatefulWidget> createState() => MeetingState();
}

class MeetingState extends State<MeetingScreenNew> {
  bool initial = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (initial) {
      getMeetingList();
      initial = false;
    }
    super.didChangeDependencies();
  }

  Future<String> getMeetingList() async {
    isLoading = true;
    EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
    await Provider.of<MeetingProvider>(context, listen: false).getMeetingList();
    isLoading = false;
    EasyLoading.dismiss();
    setState(() {});

    return 'Loaded';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Meetings'.tr,
            style: Styles.styleHeader,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () {
            Provider.of<MeetingProvider>(context, listen: false).page = 1;
            return getMeetingList();
          },
          // child: Container(),
          child: const MeetingListView(),
        ),
      ),
    );
  }
}
