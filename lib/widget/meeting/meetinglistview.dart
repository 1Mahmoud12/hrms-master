import 'package:cnattendance/provider/meetingprovider.dart';
import 'package:cnattendance/widget/meeting/meetingcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MeetingListView extends StatefulWidget {
  const MeetingListView({super.key});

  @override
  State<StatefulWidget> createState() => MeetingListViewState();
}

class MeetingListViewState extends State<MeetingListView> {
  late ScrollController _controller;
  bool isLoading = false;

  void _loadMore() async {
    if (!isLoading) {
      if (_controller.position.maxScrollExtent == _controller.position.pixels) {
        isLoading = true;
        await Provider.of<MeetingProvider>(context, listen: false).getMeetingList();
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
    final items = Provider.of<MeetingProvider>(context).meetingList;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, i) {
            return MeetingCard(
              items[i].id,
              items[i].title,
              items[i].venue,
              items[i].meetingDate,
              items[i].participator,
            );
          },),
    );
  }
}
