import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/progressBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/progressBloc/state.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final modelProject = Get.find<ProjectDetailController>();

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
              child: BlocBuilder<ProgressCubit, ProgressState>(
                builder: (context, state) => PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections(modelProject),
                  ),
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

  List<PieChartSectionData> showingSections(ProjectDetailController modelProject) {
    double remaining = 0;
    return List.generate(modelProject.project.value.tasks.length + 1, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(blurRadius: 2)];
      remaining += (i != modelProject.project.value.tasks.length) ? double.parse(ProgressCubit.of(context).steps[i]['value']) : 0;
      return (i != modelProject.project.value.tasks.length)
          ? PieChartSectionData(
              color: modelProject.project.value.tasks[i].status == 'Cancelled' ? AppColors.primaryColor : AppColors.cBackGroundIconButton,
              value: double.parse('${modelProject.project.value.tasks[i].progress ?? '0'}'),
              title: '${ProgressCubit.of(context).steps[i]['value']}%',
              radius: radius,
              borderSide: const BorderSide(color: AppColors.white),
              badgeWidget: Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(20.r)),
                child: Text(
                  modelProject.project.value.tasks[i].name!,
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: AppColors.white),
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
                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20.r)),
                child: Text(
                  'Not Selected',
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: AppColors.white),
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
    });
  }
}
