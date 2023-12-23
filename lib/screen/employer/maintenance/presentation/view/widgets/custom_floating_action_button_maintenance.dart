import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/item_show_modal_bottom_sheet.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomFloatingActionButtonMaintenance extends StatelessWidget {
  const CustomFloatingActionButtonMaintenance({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Theme(
            data: ThemeData(useMaterial3: false),
            child: AlertDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: AppColors.scaffoldBackGround,
              titlePadding: const EdgeInsets.only(top: 10).w,
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
              title: Center(
                child: Text(
                  'Select Maintenance Type',
                  style: Styles.style18700.copyWith(color: Colors.black),
                ),
              ),
              content: Container(
                width: context.screenWidth * .92,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                child: Row(
                  children: [
                    ItemShowModalBottomSheet(
                      titleShowModalBottomSheet: 'Emergency request',
                      onPress: () {
                        final arguments = {
                          'nameStatus': 'Emergency maintenance request',
                        };
                        Navigator.pushNamed(context, AppRoute.detailsMaintenance, arguments: arguments);
                      },
                      assetName: Assets.emergencyRequest,
                    ),
                    ItemShowModalBottomSheet(
                      titleShowModalBottomSheet: 'Malfunction request',
                      onPress: () {
                        final arguments = {
                          'nameStatus': 'Malfunction maintenance',
                        };
                        Navigator.pushNamed(context, AppRoute.detailsMaintenance, arguments: arguments);
                      },
                      assetName: Assets.malfunctionRequest,
                    ),
                    ItemShowModalBottomSheet(
                      titleShowModalBottomSheet: 'periodic maintenance',
                      onPress: () {
                        final arguments = {
                          'nameStatus': 'Request periodic maintenance',
                        };
                        Navigator.pushNamed(context, AppRoute.addMaintenanceContract, arguments: arguments);
                      },
                      assetName: Assets.maintenancePeriodic,
                    ),
                    10.ESH(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: context.screenWidth * .09),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
            ),
            padding: EdgeInsets.all(15.w),
            child: SvgPicture.asset(Assets.addMaintenance),
          ),
        ),
      ),
    );
  }
}
