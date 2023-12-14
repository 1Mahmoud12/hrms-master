import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class AttendanceCardView extends StatelessWidget {
  final int index;
  final String date;
  final String day;
  final String start;
  final String end;

  const AttendanceCardView(this.index, this.date, this.day, this.start, this.end, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white12,
      shape: ButtonBorder(),
      child: Container(
        padding: const EdgeInsets.all(18),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${DateFormat('MMMM dd ,yyyy').format(DateTime.now())} | $day', style: Styles.style16700, textAlign: TextAlign.start),
            10.ESH(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    SvgPicture.asset(Assets.checkIn),
                    5.ESW(),
                    Text(start, style: Styles.style12400.copyWith(fontWeight: FontWeight.w300), textAlign: TextAlign.start),
                  ],
                ),),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        SvgPicture.asset(Assets.checkOut),
                        5.ESW(),
                        Text(end, style: Styles.style12400.copyWith(fontWeight: FontWeight.w300), textAlign: TextAlign.start),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
