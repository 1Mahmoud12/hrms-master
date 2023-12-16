import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/item_show_modal_bottom_sheet.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFloatingActionButtonMaintenance extends StatelessWidget {
  const CustomFloatingActionButtonMaintenance({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.screenHeight * .69,
      left: context.screenWidth * .74,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              width: context.screenWidth * .97,
              decoration: BoxDecoration(color: AppColors.scaffoldBackGround, borderRadius: BorderRadius.circular(15.r)),
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
                      Navigator.pushNamed(context, AppRoute.detailsMaintenance, arguments: arguments);
                    },
                  ),
                  10.ESH(),
                  const Divider(),
                  ItemShowModalBottomSheet(
                    titleShowModalBottomSheet: 'Cancel',
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
          ),
          padding: EdgeInsets.all(15.w),
          child: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
