import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/maintenance_report.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/payments.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/products_used.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmergencyMalfunctionScreen extends StatefulWidget {
  const EmergencyMalfunctionScreen({super.key});

  @override
  State<EmergencyMalfunctionScreen> createState() =>
      _EmergencyMalfunctionScreenState();
}

class _EmergencyMalfunctionScreenState
    extends State<EmergencyMalfunctionScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;

    const String nameRequest = 'Malfunction Request';
    const String status = 'In Progress';
    const String location = 'Cairo';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          nameRequest,
          style: Styles.styleHeader,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .05),
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Maintenance Status',
                  style: Styles.style14400,
                ),
                Text(
                  status,
                  style: Styles.style14500.copyWith(
                    color: status == 'In Progress'
                        ? AppColors.green
                        : AppColors.subTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Details',
                  style: Styles.style14400,
                ),
                Text(
                  'Name',
                  style: Styles.style14400,
                ),
                Text(
                  args['name'] ?? 'N/A',
                  style:
                      Styles.style14400.copyWith(color: AppColors.primaryColor),
                ),
                Text(
                  'Description',
                  style: Styles.style14400,
                ),
                Text(
                  args['description'] ?? 'N/A',
                  style:
                      Styles.style14400.copyWith(color: AppColors.primaryColor),
                ),
                Text(
                  'location',
                  style: Styles.style14400,
                ),
                Row(
                  children: [
                    Text(
                      args['location'] ?? 'N/A',
                      style: Styles.style14400
                          .copyWith(color: AppColors.primaryColor),
                    ),
                    5.ESW(),
                    SvgPicture.asset(
                      Assets.location,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Attachment',
                  style: Styles.style14400,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Image.asset(Assets.attachment),
                ),
              ],
            ),
          ),
          const MaintenanceReport(),
          const ProductsUsed(),
          const PaymentsReportCustomer(),
          CustomTextButton(
            backgroundColor: AppColors.primaryColor,
            child: Text(
              'Confirm',
              style: Styles.style16700.copyWith(color: AppColors.white),
            ),
            onPress: () {
              showToast('message');
            },
          ),
        ].paddingDirectional(bottom: 10.h),
      ),
    );
  }
}
