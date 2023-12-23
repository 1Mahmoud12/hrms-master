import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
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
            cubit.changeIndex(index: index);
            MainBlocMaintenanceCubit.of(context).changeView();
          },
          child: Container(
            constraints: BoxConstraints(maxWidth: context.screenWidth * .3),
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: cubit.indexList == index ? AppColors.primaryColor : AppColors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  index == 0
                      ? Assets.emergencyRequest
                      : index == 1
                          ? Assets.malfunctionRequest
                          : Assets.maintenancePeriodic,
                  width: context.screenWidth * .05,
                  colorFilter: ColorFilter.mode(cubit.indexList == index ? AppColors.white : AppColors.primaryColor, BlendMode.srcIn),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: context.screenWidth * .18),
                  child: Text(
                    cubit.maintenanceLabels[index],
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: cubit.indexList == index ? AppColors.white : AppColors.textColorTextFormField,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
