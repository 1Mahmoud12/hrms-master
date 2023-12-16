import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:cnattendance/screen/leavescreen/components/Leaverequestbutton.dart';
import 'package:cnattendance/screen/profile/NotificationScreen.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:cnattendance/widget/leavescreen/leave_list_dashboard.dart';
import 'package:cnattendance/widget/leavescreen/leave_list_detail_dashboard.dart';
import 'package:cnattendance/widget/leavescreen/toggleleavetime.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class LeaveScreenNew extends StatefulWidget {
  const LeaveScreenNew({super.key});

  @override
  State<LeaveScreenNew> createState() => _LeaveScreenNewState();
}

class _LeaveScreenNewState extends State<LeaveScreenNew> {
  bool init = true;
  bool isVisible = false;

  @override
  void didChangeDependencies() {
    if (init) {
      initialState();
      init = false;
    }
    super.didChangeDependencies();
  }

  Future<String> initialState() async {
    final leaveProvider = Provider.of<LeaveProvider>(context, listen: false);
    final leaveData = await leaveProvider.getLeaveType();

    if (!mounted) {
      return 'Loaded';
    }
    if (leaveData.statusCode != 200) {
      showToast(leaveData.message);
    }

    getLeaveDetailList();
    return 'Loaded';
  }

  void getLeaveDetailList() async {
    final leaveProvider = Provider.of<LeaveProvider>(context, listen: false);
    final detailResponse = await leaveProvider.getLeaveTypeDetail();

    if (!mounted) {
      return;
    }
    if (detailResponse.statusCode == 200) {
      isVisible = true;
      if (detailResponse.data.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(padding: EdgeInsets.all(20), content: Text('No data found')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(padding: const EdgeInsets.all(20), content: Text(detailResponse.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Container(),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: InkWell(
                onTap: () {
                  pushNewScreen(context,
                      screen: const NotificationScreen(), withNavBar: false, pageTransitionAnimation: PageTransitionAnimation.fade);
                },
                child: SvgPicture.asset(Assets.notification),
              ),
            ),
          ],
          title: Text(
            'Leave'.tr,
            style: Styles.styleHeader,
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return initialState();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'submit request'.tr,
                      style: Styles.style16700.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const LeaveRequestButton(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Leave_Summary'.tr,
                      style: Styles.style16700.copyWith(fontWeight: FontWeight.w600),
                    ),
                    10.ESH(),
                    const LeaveListDashboard(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Recent_activity'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const ToggleLeaveTime(),
                    const SizedBox(
                      height: 20,
                    ),
                    const LeaveListDetailsDashboard(),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
