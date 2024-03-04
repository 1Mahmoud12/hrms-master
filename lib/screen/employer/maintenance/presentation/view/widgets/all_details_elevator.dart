import 'package:cnattendance/core/component/empty_widget.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/data/model/all_elevators_model.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/oneElevatorBloc/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/oneElevatorBloc/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/header_details_contract.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllDetailsElevator extends StatelessWidget {
  const AllDetailsElevator({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = context.getArguments;
    final Elevators detailsElevators = argument['elevators'];
    String location = '';
    allPeridicsCache!.data!.periodic?.forEach((element) {
      if (element.id == detailsElevators.peridicId) location = element.location!;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          detailsElevators.name ?? '',
          style: Styles.styleHeader,
        ),
      ),
      body: BlocProvider(
        create: (context) => OneElevatorCubit()..getAllOneElevator(context: context, idElevator: detailsElevators.id!.toString()),
        child: BlocBuilder<OneElevatorCubit, OneElevatorState>(
          builder: (context, state) => state is OneElevatorLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is OneElevatorErrorState
                  ? ErrorWidget(state.error)
                  : state is OneElevatorSuccessState &&
                          OneElevatorCubit.of(context).oneElevatorModel != null &&
                          OneElevatorCubit.of(context).oneElevatorModel!.data != null &&
                          OneElevatorCubit.of(context).oneElevatorModel!.data != null
                      ? ListView(
                          children: [
                            HeaderDetailsContract(
                              startDate: detailsElevators.updatedAt ?? '',
                              endDate: '2 Dec 2024',
                              location: location,
                              reports: OneElevatorCubit.of(context).oneElevatorModel!.data!.reports,
                            ),
                          ],
                        )
                      : const EmptyWidget(),
        ),
      ),
    );
  }
}
