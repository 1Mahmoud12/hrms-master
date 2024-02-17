import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemToggle extends StatelessWidget {
  final int index;

  const ItemToggle({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBlocMaintenanceCubit, MainBlocMaintenanceState>(
      builder: (context, state) {
        final cubit = MainBlocMaintenanceCubit.of(context);

        return InkWell(
          onTap: () {
            final arguments = {
              'nameEmergency': cubit.maintenanceLabels[index],
            };
            Navigator.pushNamed(
              context,
              index == 0 || index == 1 ? AppRoute.emergencyScreenItems : AppRoute.periodicMaintenanceScreenItems,
              arguments: arguments,
            );
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: index == 0
                  ? AppColors.emergencyRequestColor
                  : index == 1
                      ? AppColors.malfunctionRequestColor
                      : AppColors.periodicMaintenanceColor,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: index == 0
                        ? AppColors.emergencyRequestIconColor
                        : index == 1
                            ? AppColors.malfunctionRequestIconColor
                            : AppColors.periodicMaintenanceIconColor,
                  ),
                  child: SvgPicture.asset(
                    index == 0
                        ? Assets.emergencyRequest
                        : index == 1
                            ? Assets.malfunctionRequest
                            : Assets.maintenancePeriodic,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    cubit.maintenanceLabels[index],
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(Assets.arrowIOS),
              ],
            ),
          ),
        );
      },
    );
  }
}
