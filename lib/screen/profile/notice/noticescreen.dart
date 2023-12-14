import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/noticeprovider.dart';
import 'package:cnattendance/widget/notice/noticelist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NoticeProvider(),
      child: const Notice(),
    );
  }
}

class Notice extends StatefulWidget {
  const Notice({super.key});

  @override
  State<StatefulWidget> createState() => NoticeState();
}

class NoticeState extends State<Notice> {
  bool initial = true;

  Future<String> getNotification() async {
    await Provider.of<NoticeProvider>(context, listen: false).getNotice();

    return 'Loaded';
  }

  @override
  void didChangeDependencies() {
    if (initial) {
      getNotification();
      initial = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Noticses'.tr,
            style: Styles.styleHeader,
          ),

          // backgroundColor: Color(0xffcfcdcb),
        ),
        body: RefreshIndicator(
            onRefresh: () {
              Provider.of<NoticeProvider>(context, listen: false).page = 1;
              return getNotification();
            },
            child: const NoticeList(),),);
  }
}
