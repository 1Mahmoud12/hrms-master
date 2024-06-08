// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/model/project.dart';
import 'package:cnattendance/provider/projectdashboardcontroller.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key, required this.index});
  final int index;

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final int index = widget.index;
    final model = Get.put(ProjectDashboardController());
    final Project project = model.projectList[index];
    final double valueSliderWidget = project.progress.toDouble();

    return AspectRatio(
      aspectRatio: 1.7,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  // badgePositionPercentageOffset: remaining == 0
                  //     ? 1
                  //     : remaining < 50 && remaining >= 20
                  //         ? 1.7
                  //         : remaining >= 50 && remaining <= 70
                  //             ? 1.5
                  //             : 1,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(
                      color: AppColors.primaryColor,
                      value: valueSliderWidget,
                      title: '$valueSliderWidget%',
                      radius: 50,
                      borderSide: const BorderSide(color: AppColors.white),
                      badgeWidget: Container(
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          valueSliderWidget.toString(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        shadows: [Shadow(blurRadius: 2)],
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.grey,
                      value: 100 - valueSliderWidget,
                      title: '',
                      radius: 50,
                      borderSide: const BorderSide(color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(
    ProjectDetailController modelProject,
  ) {
    double remaining = 0;
    return List.generate(
      modelProject.project.value.tasks.length + 1,
      (i) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        const shadows = [Shadow(blurRadius: 2)];
        remaining += (i != modelProject.project.value.tasks.length)
            ? double.parse(
                '${modelProject.project.value.tasks[i].progress ?? '0'}',
              )
            : 0;
        return (i != modelProject.project.value.tasks.length)
            ? PieChartSectionData(
                color: modelProject.project.value.tasks[i].status == 'Cancelled'
                    ? AppColors.primaryColor
                    : AppColors.cBackGroundIconButton,
                value: double.parse(
                  '${modelProject.project.value.tasks[i].progress ?? '0'}',
                ),
                title:
                    '${modelProject.project.value.tasks[i].progress ?? '0'}%',
                radius: radius,
                borderSide: const BorderSide(color: AppColors.white),
                badgeWidget: Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    modelProject.project.value.tasks[i].name!,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
                badgePositionPercentageOffset: remaining == 0
                    ? 1
                    : remaining < 50 && remaining >= 20
                        ? 1.7
                        : remaining >= 50 && remaining <= 70
                            ? 1.5
                            : 1,
                titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  shadows: shadows,
                ),
              )
            : PieChartSectionData(
                color: Colors.grey,
                value: 100 - remaining,
                title: '${100 - remaining}%',
                radius: radius,
                borderSide: const BorderSide(color: AppColors.white),
                badgeWidget: Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Not Selected',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
                badgePositionPercentageOffset: 2,
                titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  shadows: shadows,
                ),
              );
      },
    );
  }
}
