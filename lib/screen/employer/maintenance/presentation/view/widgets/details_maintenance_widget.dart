import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/data/model/periodic_model.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsMaintenanceWidget extends StatelessWidget {
  const DetailsMaintenanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    final Periodic onePeriodic = arguments['onePeriodic'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          onePeriodic.name ?? 'N/A',
          style: Styles.styleHeader,
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 30.h),
        itemCount: int.parse(onePeriodic.numelevaters ?? '0'),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            final arguments = {
              'location': onePeriodic.createdAt ?? '',
              'startDate': (onePeriodic.updatedAt ?? DateTime.now().toString()).substring(0, 10),
              'nameElevator': 'Elevator ${index + 1}',
            };
            Navigator.pushNamed(context, AppRoute.allDetailsElevator, arguments: arguments);
          },
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.grey)),
                  child: SvgPicture.asset(Assets.maintenance),
                ),
                10.ESW(),
                Text(
                  'Elevator ${index + 1}',
                  style: Styles.style18700,
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios_sharp),
              ],
            ),
          ),
        ),
        separatorBuilder: (context, index) => 15.ESH(),
      ),
    );
  }
}
