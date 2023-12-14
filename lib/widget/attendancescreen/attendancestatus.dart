import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/attendancereportprovider.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttendanceStatus extends StatelessWidget {
  const AttendanceStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final status = Provider.of<AttendanceReportProvider>(context).todayReport;
    final double productionPercent = status['production_percent'] < 0 ? 0.0 : status['production_percent'];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10).w,
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Assets.checkIn),
                            5.ESW(),
                            Text(
                              'check in'.tr,
                              style: Styles.style14400.copyWith(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                        10.ESH(),
                        Text(
                          DateFormat('HH : mm').format(DateTime.now()),
                          style: Styles.style18700,
                        ),
                        10.ESH(),
                        Text(
                          'on time'.tr,
                          style: Styles.style12400.copyWith(color: AppColors.subTextColor),
                        ),
                      ],
                    ),
                  ),
                ),
                10.ESW(),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10).w,
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Assets.checkIn),
                            5.ESW(),
                            Text(
                              'check out'.tr,
                              style: Styles.style14400.copyWith(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                        10.ESH(),
                        Text(
                          DateFormat('HH : mm').format(DateTime.now()),
                          style: Styles.style18700,
                        ),
                        10.ESH(),
                        Text(
                          '${'Start'.tr} ${DateFormat('HH : mm').format(DateTime.now())}',
                          style: Styles.style12400.copyWith(color: AppColors.subTextColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            10.ESH(),
            /*Text(
              'checkin_out'.tr,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xff635F54)),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20.0),
              child: LinearPercentIndicator(
                animation: true,
                animationDuration: 1000,
                lineHeight: 30.0,
                padding: EdgeInsets.zero,
                percent: productionPercent,
                center: Text(
                  status['production_hour']!,
                  style: const TextStyle(color: AppColors.scaffoldBackGround),
                ),
                barRadius: const Radius.circular(20),
                backgroundColor: Colors.black,
                progressColor:
                    status['check_in_at'] != '-' && status['check_out_at'] == '-' ? HexColor('#EDE7B0').withOpacity(.5) : HexColor('#EDE7B0'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    status['check_in_at']!,
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    status['check_out_at']!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
