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
              backgroundColor: AppColors.scaffoldBackGround,
              titlePadding: const EdgeInsets.only(top: 10).w,
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
              title: Center(
                child: Text(
                  'Select Request',
                  style: Styles.style18700.copyWith(color: AppColors.primaryColor),
                ),
              ),
              content: Container(
                width: context.screenWidth * .99,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ItemShowModalBottomSheet(
                      titleShowModalBottomSheet: 'Emergency maintenance request',
                      onPress: () {
                        final arguments = {
                          'nameStatus': 'Emergency maintenance request',
                        };
                        Navigator.pushNamed(context, AppRoute.detailsMaintenance, arguments: arguments);
                      },
                    ),
                    ItemShowModalBottomSheet(
                      titleShowModalBottomSheet: 'Malfunction maintenance',
                      onPress: () {
                        final arguments = {
                          'nameStatus': 'Malfunction maintenance',
                        };
                        Navigator.pushNamed(context, AppRoute.detailsMaintenance, arguments: arguments);
                      },
                    ),
                    ItemShowModalBottomSheet(
                      titleShowModalBottomSheet: 'Request periodic maintenance',
                      onPress: () {
                        final arguments = {
                          'nameStatus': 'Request periodic maintenance',
                        };
                        Navigator.pushNamed(context, AppRoute.addMaintenanceContract, arguments: arguments);
                      },
                    ),
                    10.ESH(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Center(
        child: Container(
          width: context.screenWidth * .64,
          decoration: BoxDecoration(
              //shape: BoxShape.circle,
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20.r)),
          padding: EdgeInsets.all(15.w),
          child: Row(
            children: [
              SvgPicture.asset(Assets.addMaintenance),
              5.ESW(),
              Text(
                'Maintenance Request',
                style: Styles.style16700.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
