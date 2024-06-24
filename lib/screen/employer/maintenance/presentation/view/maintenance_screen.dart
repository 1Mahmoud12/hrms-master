import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/item_toggle.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* const String nameMaintenanceReport = 'Name Contract';
    const String location = 'Cairo';
    const int numberElevators = 15;*/
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maintenance'.tr,
          style: TextStyle(color: AppColors.textColor, fontSize: 20.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: BlocBuilder<MainBlocMaintenanceCubit, MainBlocMaintenanceState>(
        builder: (context, state) => SingleChildScrollView(
          padding: EdgeInsets.all(context.screenWidth * .04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image.asset(Assets.backgroundMaintenance),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0, left: 16),
                      child: Column(
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              'RAK\nMaintenance',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.sp,
                                fontWeight: FontWeight.w700,
                                //height: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                22.ESH(),
                Text(
                  'Maintenance Type'.tr,
                  style: Styles.styleHeader.copyWith(
                    color: const Color(0xFF0A256C),
                  ),
                ),
                const ItemToggle(index: 0),
                const ItemToggle(index: 1),
                const ItemToggle(index: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
