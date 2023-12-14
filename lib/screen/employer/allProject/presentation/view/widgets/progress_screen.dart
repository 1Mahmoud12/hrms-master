import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    final int progressRatio = argument['progressRatio'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Progress',
          style: Styles.styleHeader,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(context.screenWidth * .02),
        children: [
          ...List.generate(
            8,
            (index) => Container(
              margin: EdgeInsets.all(context.screenWidth * .02),
              padding: EdgeInsets.all(context.screenWidth * .02),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), color: AppColors.white),
              child: Row(
                children: [
                  Text(
                    '${index + 1} - first Step',
                    style: Styles.style16700.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    '10 %',
                    style: Styles.style14400,
                  ),
                  const Spacer(),
                  Text(
                    'done',
                    style: Styles.style14400.copyWith(color: AppColors.green),
                  ),
                ],
              ),
            ),
          ),
          ...List.generate(
            2,
            (index) => Container(
              margin: EdgeInsets.all(context.screenWidth * .02),
              padding: EdgeInsets.all(context.screenWidth * .02),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), color: AppColors.white),
              child: Row(
                children: [
                  Text(
                    '${(index + 1) + 8} - first Step',
                    style: Styles.style16700.copyWith(fontWeight: FontWeight.w500),
                  ),
                  /*const Spacer(),
                  Text(
                    '10 %',
                    style: Styles.style14400,
                  ),*/
                  const Spacer(),
                  Text(
                    'wait',
                    style: Styles.style14400,
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Completed $progressRatio %',
                style: Styles.style16700,
              ),
            ],
          )
        ],
      ),
    );
  }
}
