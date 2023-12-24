import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/progressBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/progressBloc/state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
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
                    sections: showingSections(),
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

  List<PieChartSectionData> showingSections() {
    double remaining = 0;
    return List.generate(ProgressCubit.of(context).steps.length + 1, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(blurRadius: 2)];
      remaining += (i != ProgressCubit.of(context).steps.length) ? double.parse(ProgressCubit.of(context).steps[i]['value']) : 0;
      return (i != ProgressCubit.of(context).steps.length)
          ? PieChartSectionData(
              color: ProgressCubit.of(context).steps[i]['chooseStatus'] == 'Finished' ? AppColors.primaryColor : AppColors.cBackGroundIconButton,
              value: double.parse(ProgressCubit.of(context).steps[i]['value']),
              title: '${ProgressCubit.of(context).steps[i]['value']}%',
              radius: radius,
              borderSide: const BorderSide(color: AppColors.white),
              badgeWidget: Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(20.r)),
                child: Text(
                  ProgressCubit.of(context).steps[i]['nameStep'],
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
              badgePositionPercentageOffset: 1.7,
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
