import 'package:cnattendance/provider/noticeprovider.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:cnattendance/widget/notice/noticecard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NoticeList extends StatefulWidget {
  const NoticeList({super.key});

  @override
  State<StatefulWidget> createState() => NoticeListState();
}

class NoticeListState extends State<NoticeList> {
  late ScrollController _controller;
  bool isLoading = false;

  void _loadMore() async {
    if (!isLoading) {
      if (_controller.position.maxScrollExtent == _controller.position.pixels) {
        isLoading = true;
        await Provider.of<NoticeProvider>(context, listen: false).getNotice();
        isLoading = false;
      }
    }
  }

  @override
  void initState() {
    _controller = ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<NoticeProvider>(context).notificationList;
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Image.asset('assets/images/no-results.png'),
            ),
            Text(
              'NoDataFound'.tr,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.separated(
            separatorBuilder: (context, index) => 10.ESH(),
            physics: const AlwaysScrollableScrollPhysics(),
            primary: false,
            controller: _controller,
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return NoticeCard(
                  id: items[index].id,
                  name: items[index].title,
                  month: items[index].month,
                  day: items[index].day.toString(),
                  desc: items[index].description,);
            },),
      );
    }
  }
}
