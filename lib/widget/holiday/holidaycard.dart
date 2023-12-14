import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HolidayCard extends StatelessWidget {
  final int id;
  final String name;
  final String month;
  final String day;
  final String desc;

  const HolidayCard({super.key, required this.id, required this.name, required this.month, required this.day, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.cBorderSVG)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(Assets.calender),
                ),),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      softWrap: true,
                      name,
                      style: Styles.style18700,
                    ),
                    2.ESH(),
                    Row(
                      children: [
                        Text(
                          '$day ',
                          style: Styles.style14500,
                        ),
                        Text(
                          month,
                          style: Styles.style14500,
                        ),
                      ],
                    ),
                    /* 5.ESH(),
                    Text(
                      desc,
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      style: TextStyle(color: Color(0xff000000), fontSize: 12),
                    ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
