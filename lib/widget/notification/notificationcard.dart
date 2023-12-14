import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final int id;
  final String name;
  final DateTime date;

  final String desc;

  const NotificationCard({super.key, required this.id, required this.name, required this.date, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 0,
      color: AppColors.scaffoldBackGround,
      child: Padding(
        padding: const EdgeInsets.all(8.0).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.cBorderSVG)),
                    child: SvgPicture.asset(Assets.creditNotification),),
                10.ESW(),
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
                              '${DateFormat("MM/dd/yyyy . h:mm a").format(date)} ',
                              style: Styles.style14500.copyWith(color: AppColors.subTextColor),
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
            10.ESH(),
            Text(
              '''Your Request have been successfully approvedBy Eman Saber''',
              style: Styles.style14400.copyWith(color: AppColors.subTextColor),
            ),
            10.ESH(),
            const Divider(
              color: AppColors.dividerColor,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
