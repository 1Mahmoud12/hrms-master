import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/notificationprovider.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:cnattendance/widget/notification/notificationlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationProvider(),
      child: const Notification(),
    );
  }
}

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<StatefulWidget> createState() => NotificationState();
}

class NotificationState extends State<Notification> {
  bool initial = true;

  Future<String> getNotification() async {
    await Provider.of<NotificationProvider>(context, listen: false).getNotification();

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
    final provider = Provider.of<NotificationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'notification'.tr,
          style: Styles.styleHeader,
        ),

        // backgroundColor: Color(0xffcfcdcb),
      ),
      // backgroundColor: Color(0xffcfcdcb),
      body: RefreshIndicator(
        onRefresh: () {
          Provider.of<NotificationProvider>(context, listen: false).page = 1;
          return getNotification();
        },
        child: ListView(
          children: const [
            /*Center(
              child: ToggleSwitch(
                cornerRadius: 20,
                activeBgColor: const [AppColors.primaryColor],
                activeFgColor: Colors.white,
                inactiveFgColor: AppColors.primaryColor,
                inactiveBgColor: AppColors.greyWhite,
                minWidth: Get.width * 0.4,
                minHeight: 34,
                initialLabelIndex: provider.indexList,
                totalSwitches: 3,
                animate: true,
                animationDuration: 500,
                onToggle: (index) {
                  provider.indexList = index!;
                  provider.toggle(index);
                },
                customTextStyles: [
                  Styles.style14500.copyWith(color: provider.indexList == 0 ? AppColors.white : AppColors.primaryColor),
                  Styles.style14500.copyWith(color: provider.indexList == 1 ? AppColors.white : AppColors.primaryColor),
                  Styles.style14500.copyWith(color: provider.indexList == 2 ? AppColors.white : AppColors.primaryColor),
                ],
                labels: provider.selectLabel,
              ),
            ),*/
            SizedBox(
              height: 10,
            ),
            NotificationList(),
          ],
        ),
      ),
    );
  }
}
