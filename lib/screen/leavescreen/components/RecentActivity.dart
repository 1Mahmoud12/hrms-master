import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecentActivity extends StatelessWidget {
  final String name;
  final String status;
  final String date;
  final String from;
  final String to;

  const RecentActivity({
    super.key,
    required this.name,
    required this.to,
    required this.from,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: Get.width * 0.88,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xfffff8f8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgPicture.asset(Assets.sickLeave),
              10.ESW(),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Approved',
                        style: Styles.style12400.copyWith(color: AppColors.green),
                        children: [
                          TextSpan(
                              text: ' at ${DateFormat('hh-mm a, MMMM dd yyyy').format(DateTime.parse(date))}',
                              style: Styles.style12400.copyWith(color: AppColors.subTextColor),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
