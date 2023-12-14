import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/leavecalendarprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class LeaveCalendarView extends StatefulWidget {
  const LeaveCalendarView({super.key});

  @override
  State<StatefulWidget> createState() => LeaveCalendarState();
}

class LeaveCalendarState extends State<LeaveCalendarView> {
  final _current = DateTime.now();
  var _selected = DateTime.now();
  final currentMonth = DateTime.now().month;
  final nextMonth = DateTime.now().month + 1;

  void getLeaveByDate(DateTime value) async {
    final outputFormat = DateFormat('yyyy-MM-dd');
    final outputDate = outputFormat.format(value);
    await Provider.of<LeaveCalendarProvider>(context, listen: false).getLeavesByDay(outputDate);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LeaveCalendarProvider>(context);
    return Card(
      elevation: 10,
      color: AppColors.white,
      child: Column(
        children: [
          TableCalendar(
            headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(color: AppColors.colorNumber),
                formatButtonTextStyle: TextStyle(
                  color: Colors.transparent,
                ),
                formatButtonDecoration: BoxDecoration(color: Colors.transparent),
                leftChevronIcon: Icon(
                  Icons.arrow_left,
                  color: Colors.black,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_right,
                  color: Colors.black,
                ),),
            calendarStyle: CalendarStyle(
                defaultTextStyle: TextStyle(color: AppColors.colorNumber, fontSize: 14.sp, fontWeight: FontWeight.w500),
                weekendTextStyle: TextStyle(color: AppColors.colorNumber, fontSize: 14.sp, fontWeight: FontWeight.w500),
                todayDecoration: const BoxDecoration(
                  color: AppColors.colorNumberToday,
                  shape: BoxShape.circle,
                ),
                todayTextStyle: const TextStyle(color: AppColors.colorNumber),
                selectedDecoration: const BoxDecoration(
                  color: AppColors.colorNumber,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: AppColors.colorNumberToday, fontSize: 14.sp, fontWeight: FontWeight.w500),),
            eventLoader: (day) {
              final inputDate = day;
              final outputFormat = DateFormat('yyyy-MM-dd');
              final outputDate = outputFormat.format(inputDate);
              if (provider.employeeLeaveList.containsKey(outputDate)) {
                return provider.employeeLeaveList[outputDate] ?? [];
              } else {
                return [];
              }
            },
            currentDay: _current,
            firstDay: DateTime.utc(_current.year, currentMonth),
            lastDay: DateTime.utc(_current.add(const Duration(days: 60)).year, nextMonth, 30),
            focusedDay: _selected,
            selectedDayPredicate: (day) {
              return isSameDay(_selected, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selected = selectedDay;
                getLeaveByDate(_selected);
              });
            },
          ),
          const Divider(
            color: AppColors.dividerColor,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 110.w,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(AppColors.white),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          side: const BorderSide(color: AppColors.cBorderButton), // Adjust the border color as needed
                        ),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: Styles.style14500,
                    ),),
              ),
              SizedBox(
                width: 110.w,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(AppColors.primaryColor),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          side: const BorderSide(color: AppColors.primaryColor), // Adjust the border color as needed
                        ),
                      ),
                    ),
                    child: Container(
                      child: Text(
                        'Apply',
                        style: Styles.style14500.copyWith(color: AppColors.white),
                      ),
                    ),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
