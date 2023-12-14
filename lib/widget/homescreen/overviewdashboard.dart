import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/provider/dashboardprovider.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:cnattendance/widget/homescreen/cardoverview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OverviewDashboard extends StatelessWidget {
  const OverviewDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final _overview = Provider.of<DashboardProvider>(context).overviewList;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: AppColors.dividerColor,
            thickness: 2,
          ),
          8.ESH(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardoverviewSvgs(type: 'Presenet'.tr, value: _overview['present']!, svgvalue: Assets.attendance),
              CardoverviewSvgsandcolor(
                type: 'Holiday'.tr,
                value: _overview['holiday']!,
                svgValue: Assets.holiday,
                bgcolor: const Color(0xff9E91EF),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardoverviewSvgsandcolor(
                type: 'Leave'.tr,
                value: _overview['leave']!,
                svgValue: Assets.leave,
                bgcolor: const Color(0xff9E91EF),
              ),
              CardoverviewSvgsandcolor(
                type: 'Request'.tr,
                bgcolor: const Color(0xff4E95F6),
                value: _overview['request']!,
                svgValue: Assets.request,
              ),
            ],
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardoverviewSvgs(
                type: 'Projects'.tr,
                value: _overview['total_project']!,
                svgvalue: Svgconstants.projectsvgs,
              ),
              CardoverviewSvgs(
                type: 'Tasks'.tr,
                value: _overview['total_task']!,
                svgvalue: Svgconstants.taskssvg,
              )
            ],
          ),*/
        ],
      ),
    );
  }
}
