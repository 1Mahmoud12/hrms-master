import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/overViewProjectBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/overViewProjectBloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> statusProject(BuildContext context, OverViewProjectCubit cubit) {
  return showDialog(
    context: context,
    builder: (context) => BlocProvider(
      create: (context) => OverViewProjectCubit(),
      child: BlocBuilder<OverViewProjectCubit, OverViewState>(
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
                      value: cubit.status == 'In Progress',
                      onChanged: (value) {
                        OverViewProjectCubit.of(context).changeStatus(newStatus: 'In Progress');
                        cubit.changeStatus(newStatus: 'In Progress');
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Pending'),
                  const Spacer(),
                  BlocBuilder<OverViewProjectCubit, OverViewState>(
                    builder: (context, state) => Checkbox(
                      value: cubit.status == 'Pending',
                      onChanged: (value) {
                        OverViewProjectCubit.of(context).changeStatus(newStatus: 'Pending');
                        cubit.changeStatus(newStatus: 'Pending');
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('Finished'),
                  const Spacer(),
                  BlocBuilder<OverViewProjectCubit, OverViewState>(
                    builder: (context, state) => Checkbox(
                      value: cubit.status == 'Finished',
                      onChanged: (value) {
                        OverViewProjectCubit.of(context).changeStatus(newStatus: 'Finished');
                        cubit.changeStatus(newStatus: 'Finished');
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
    ),
  );
}
