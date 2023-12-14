import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/provider/dashboardprovider.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:cnattendance/widget/homescreen/bar_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class WeeklyReportChart extends StatefulWidget {
  const WeeklyReportChart({super.key});

  @override
  State<StatefulWidget> createState() => WeeklyReportChartState();
}

class WeeklyReportChartState extends State<WeeklyReportChart> {
  int touchedGroupIndex = -1;

  bool initial = true;

  @override
  void didChangeDependencies() {
    if (initial) {
      Provider.of<DashboardProvider>(context, listen: false).buildgraph();
      initial = false;
    }
    super.didChangeDependencies();
  }

  final List<String> weeks = ['first week', 'second week', 'third week', 'forth week'];
  String selectedWeek = 'first week';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          elevation: 0,
          shape: ButtonBorder(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //makeTransactionsIcon(),
                    //18.ESW(),
                    Text(
                      'weekly_report'.tr,
                      style: TextStyle(color: AppColors.textColor, fontSize: 20.sp, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Container(
                      height: 30.h,
                      width: MediaQuery.of(context).size.width * .3,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), border: Border.all(color: AppColors.primaryColor)),
                      child: DropdownButton<String>(
                        underline: Container(),
                        value: selectedWeek,
                        onChanged: (String? newValue) {
                          setState(() {});
                          selectedWeek = newValue!;
                        },
                        isExpanded: true,
                        padding: EdgeInsets.zero,
                        borderRadius: BorderRadius.circular(25.r),
                        icon: const Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AppColors.primaryColor,
                        ),
                        iconSize: 20.w,
                        items: weeks.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Container(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 10.0).w,
                              child: Text(
                                item,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                              ),
                            ),),
                          );
                        }).toList(),
                      ),
                    ),
                    // const Text(
                    //   'Reports',
                    //   style: TextStyle(color: Colors.white, fontSize: 16),
                    // ),
                  ],
                ),
                20.ESH(),
                /*BarChart(
                    BarChartData(
                      maxY: 13,
                      barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.grey,
                            getTooltipItem: (_a, _b, _c, _d) => null,
                          ),
                          touchCallback: (FlTouchEvent event, response) {
                            if (response == null || response.spot == null) {
                              setState(() {
                                touchedGroupIndex = -1;
                                provider.showingBarGroups = List.of(provider.rawBarGroups);
                              });
                              return;
                            }

                            touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                            setState(() {
                              if (!event.isInterestedForInteractions) {
                                touchedGroupIndex = -1;
                                provider.showingBarGroups = List.of(provider.rawBarGroups);
                                return;
                              }
                              provider.showingBarGroups = List.of(provider.rawBarGroups);
                              if (touchedGroupIndex != -1) {
                                var sum = 0.0;
                                for (var rod in provider.showingBarGroups[touchedGroupIndex].barRods) {
                                  sum += rod.toY;
                                }
                                final avg = sum / provider.showingBarGroups[touchedGroupIndex].barRods.length;

                                provider.showingBarGroups[touchedGroupIndex] = provider.showingBarGroups[touchedGroupIndex].copyWith(
                                  barRods: provider.showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                                    return rod.copyWith(toY: avg);
                                  }).toList(),
                                );
                              }
                            });
                          }),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                            getTitlesWidget: bottomTitles,
                            reservedSize: 42,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            interval: 1,
                            getTitlesWidget: leftTitles,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: provider.showingBarGroups,
                      gridData: FlGridData(
                        // show: false,
                        horizontalInterval: 2,
                        verticalInterval: 2,
                      ),
                    ),
                  )*/
                const Expanded(
                  child: BarChartSample2(
                      leftBarColor: AppColors.unSelectedCharData, rightBarColor: AppColors.unSelectedCharData, avgColor: AppColors.selectedCharData,),
                ),
                10.ESH(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text;
    if (value == 0) {
      text = '1Hr';
    } else if (value == 2) {
      text = '2Hr';
    } else if (value == 4) {
      text = '4Hr';
    } else if (value == 6) {
      text = '6Hr';
    } else if (value == 8) {
      text = '8Hr';
    } else if (value == 10) {
      text = '10Hr';
    } else if (value == 12) {
      text = '12Hr';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final List<String> titles = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2, //margin top
      child: text,
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 15,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 25,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 15,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
