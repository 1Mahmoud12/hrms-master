import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/overViewProjectBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/overViewProjectBloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> statusProject(BuildContext context, OverViewProjectCubit cubit, String projectId) {
  return showDialog(
    context: context,
    builder: (context) => BlocBuilder<OverViewProjectCubit, OverViewState>(
      builder: (context, state) => AlertDialog(
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.r))),
        backgroundColor: AppColors.scaffoldBackGround,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text('In Progress'),
                const Spacer(),
                BlocBuilder<OverViewProjectCubit, OverViewState>(
                  builder: (context, state) => Checkbox(
                    value: OverViewProjectCubit.of(context).status == 'In Progress',
                    onChanged: (value) {
                      OverViewProjectCubit.of(context).changeStatus(newStatus: 'In Progress', projectId: projectId);

                      //  cubit.changeStatus(newStatus: 'in progress', projectId: projectId);
                    },
                    activeColor: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Not Started'),
                const Spacer(),
                BlocBuilder<OverViewProjectCubit, OverViewState>(
                  builder: (context, state) => Checkbox(
                    value: OverViewProjectCubit.of(context).status == 'Not Started',
                    onChanged: (value) {
                      OverViewProjectCubit.of(context).changeStatus(newStatus: 'Not Started', projectId: projectId);
                      // cubit.changeStatus(newStatus: 'not started', projectId: projectId);
                    },
                    activeColor: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('On Hold'),
                const Spacer(),
                BlocBuilder<OverViewProjectCubit, OverViewState>(
                  builder: (context, state) => Checkbox(
                    value: OverViewProjectCubit.of(context).status == 'On Hold',
                    onChanged: (value) {
                      OverViewProjectCubit.of(context).changeStatus(newStatus: 'On Hold', projectId: projectId);

                      //    cubit.changeStatus(newStatus: 'on hold', projectId: projectId);
                    },
                    activeColor: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Cancelled'),
                const Spacer(),
                BlocBuilder<OverViewProjectCubit, OverViewState>(
                  builder: (context, state) {
                    return Checkbox(
                      value: OverViewProjectCubit.of(context).status == 'Cancelled',
                      onChanged: (value) {
                        OverViewProjectCubit.of(context).changeStatus(newStatus: 'Cancelled', projectId: projectId);

                        //   cubit.changeStatus(newStatus: 'cancelled', projectId: projectId);
                      },
                      activeColor: AppColors.primaryColor,
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('Completed'),
                const Spacer(),
                BlocBuilder<OverViewProjectCubit, OverViewState>(
                  builder: (context, state) => Checkbox(
                    value: OverViewProjectCubit.of(context).status == 'Completed',
                    onChanged: (value) {
                      OverViewProjectCubit.of(context).changeStatus(newStatus: 'Completed', projectId: projectId);

                      //   cubit.changeStatus(newStatus: 'completed', projectId: projectId);
                    },
                    activeColor: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
