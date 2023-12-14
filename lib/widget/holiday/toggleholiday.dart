import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/holidayprovider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleHoliday extends StatelessWidget {
  const ToggleHoliday({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HolidayProvider>(context);
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: AppColors.greyWhite,
        ),
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: ToggleSwitch(
            cornerRadius: 20,
            activeBgColor: const [AppColors.primaryColor],
            activeFgColor: Colors.white,
            inactiveFgColor: AppColors.primaryColor,
            inactiveBgColor: AppColors.greyWhite,
            minWidth: Get.width * 0.4,
            minHeight: 34,
            initialLabelIndex: provider.toggleValue,
            totalSwitches: 2,
            onToggle: (index) {
              provider.toggleValue = index!;
              provider.holidayListFilter();
            },
            customTextStyles: [
              Styles.style16700.copyWith(color: provider.toggleValue == 0 ? AppColors.white : AppColors.primaryColor),
              Styles.style16700.copyWith(color: provider.toggleValue == 0 ? AppColors.primaryColor : AppColors.white),
            ],
            labels: ['upcoming'.tr, 'past'.tr],
          ),
        ),
      ),
    );
  }
}
