import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleLeaveTime extends StatelessWidget {
  const ToggleLeaveTime({super.key});

  @override
  Widget build(BuildContext context, [bool mounted = true]) {
    final provider = Provider.of<LeaveProvider>(context);

    void onToggleChanged() async {
      final detailResponse = await provider.getLeaveTypeDetail();

      if (!mounted) return;
      if (detailResponse.statusCode == 200) {
        if (detailResponse.data.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(padding: EdgeInsets.all(20), content: Text('No data found')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(padding: const EdgeInsets.all(20), content: Text(detailResponse.message)));
      }
    }

    return Container(
      // width: Get.width * 0.8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: AppColors.scaffoldBackGround,
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: ToggleSwitch(
          cornerRadius: 20,
          activeBgColor: const [AppColors.primaryColor],
          activeFgColor: AppColors.white,
          inactiveFgColor: AppColors.primaryColor,
          inactiveBgColor: AppColors.white,
          minWidth: Get.width * 0.4,
          minHeight: 34,
          initialLabelIndex: provider.selectedMonth == 0 ? 1 : 0,
          totalSwitches: 2,
          onToggle: (index) {
            if (index == 0) {
              final DateTime now = DateTime.now();
              provider.setMonth(now.month);
              onToggleChanged();
            } else {
              provider.setMonth(0);
              onToggleChanged();
            }
          },
          labels: ['This_month'.tr, 'This_year'.tr],
        ),
      ),
    );
  }
}
