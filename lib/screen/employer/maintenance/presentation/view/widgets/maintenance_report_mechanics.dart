import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/products_need_mechanics.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MaintenanceReportMechanics extends StatelessWidget {
  const MaintenanceReportMechanics({super.key});

  @override
  Widget build(BuildContext context) {
    const String status = 'In Progress';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maintenance Report',
          style: Styles.styleHeader,
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: CustomTextButton(
            onPress: () {},
            backgroundColor: AppColors.primaryColor,
            child: Text(
              'submit',
              style: Styles.style14400.copyWith(color: AppColors.white),
            ),
          ),
        )
      ],
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Maintenance Status',
                  style: Styles.style14400,
                ),
                Text(
                  status,
                  style: Styles.style14500
                      .copyWith(color: status == 'In Progress' ? AppColors.green : AppColors.subTextColor, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Maintenance Report',
                      style: Styles.style14400,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(onTap: () {}, child: SvgPicture.asset(Assets.edit)),
                    ),
                  ],
                ),
                Text(
                  '''
Lorem mollit cupidatat irure aborum magna nulla duis ullamco cillum dolor Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ex enim, euismod non consequat a, eg''',
                  style: Styles.style14400.copyWith(color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
          const ProductsNeed(),
        ].paddingDirectional(bottom: 10.h),
      ),
    );
  }
}
