import 'package:cnattendance/core/component/empty_widget.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/data/model/all_elevators_model.dart';
import 'package:cnattendance/screen/employer/maintenance/data/model/periodic_model.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/elevatorsBloc/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/elevatorsBloc/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsMaintenanceWidget extends StatelessWidget {
  const DetailsMaintenanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    final Periodic onePeriodic = arguments['onePeriodic'];

    return BlocProvider(
      create: (context) => ElevatorsCubit()..getAllElevators(context: context, idPeriodic: onePeriodic.id!.toString()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            onePeriodic.name ?? 'N/A',
            style: Styles.styleHeader,
          ),
        ),
        body: BlocBuilder<ElevatorsCubit, ElevatorsState>(
          builder: (context, state) => state is ElevatorsLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is ElevatorsErrorState
                  ? ErrorWidget(state.error)
                  : state is ElevatorsSuccessState &&
                          ElevatorsCubit.of(context).allElevatorsModel != null &&
                          ElevatorsCubit.of(context).allElevatorsModel!.data != null &&
                          ElevatorsCubit.of(context).allElevatorsModel!.data!.elevators != null
                      ? ListView.separated(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          itemCount: int.parse(onePeriodic.numelevaters ?? '0'),
                          itemBuilder: (context, index) {
                            final Elevators detailsElevator = ElevatorsCubit.of(context).allElevatorsModel!.data!.elevators![index];
                            return InkWell(
                              onTap: () {
                                final arguments = {
                                  'elevators': detailsElevator,
                                };
                                Navigator.pushNamed(context, AppRoute.allDetailsElevator, arguments: arguments);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10.r)),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5.w),
                                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.grey)),
                                      child: SvgPicture.asset(Assets.maintenance),
                                    ),
                                    10.ESW(),
                                    Text(
                                      detailsElevator.name ?? '',
                                      style: Styles.style18700,
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.arrow_forward_ios_sharp),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                        )
                      : const EmptyWidget(),
        ),
      ),
    );
  }
}
