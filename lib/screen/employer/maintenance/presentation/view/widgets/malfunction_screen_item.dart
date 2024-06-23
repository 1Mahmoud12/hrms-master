import 'package:cnattendance/Controller/StaticControllers/mainBlocHome/cubit.dart';
import 'package:cnattendance/core/component/empty_widget.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/malfunctionBloc/cubit/malfunction_cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/malfunctionBloc/cubit/malfunction_state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/custom_floating_action_button_maintenance.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/malfunction_request.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MalFunctionScreenItems extends StatelessWidget {
  const MalFunctionScreenItems({super.key});

  @override
  Widget build(BuildContext context) {
    const String nameMaintenanceReport = 'Name Contract';
    const String location = 'Cairo';
    const int numberElevators = 15;
    final arguments = context.getArguments;
    final String nameEmergency = arguments['nameEmergency'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          nameEmergency,
          style: Styles.styleHeader,
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            MalfunctionCubit()..getAllProposals(context: context),
        child: BlocBuilder<MalfunctionCubit, MalfunctionState>(
          builder: (context, state) => state is MalfunctionLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is MalfunctionErrorState
                  ? ErrorWidget(state.error)
                  : state is MalfunctionSuccessState &&
                          allMalfunctionCache != null &&
                          allMalfunctionCache!.data != null &&
                          allMalfunctionCache!.data!.malfunction != null
                      ? ListView.builder(
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              final arguments = {
                                'nameMaintenanceReport': nameMaintenanceReport,
                                'startDate': '24 Aug',
                                'location': location,
                                'numberElevators': numberElevators,
                                'status': index > 4
                                    ? Malfunction.In_Progress.name
                                    : Malfunction.Pending.name,
                                'index': index,
                                'malfuncion_id': allMalfunctionCache!
                                    .data!.malfunction![index].id,
                              };
                              if (genderUser == RoleId.eight.name.tr) {
                                Navigator.pushNamed(
                                  context,
                                  AppRoute.maintenanceReportMechanics,
                                  arguments: arguments,
                                );
                              } else if (genderUser == RoleId.nine.name.tr) {
                                Navigator.pushNamed(
                                  context,
                                  AppRoute.maintenanceReportMechanics,
                                  arguments: arguments,
                                );
                              } else {
                                Navigator.pushNamed(
                                  context,
                                  AppRoute.maintenanceReportTechnical,
                                  arguments: arguments,
                                );
                              }
                            },
                            child: MalfunctionRequest(
                              nameMaintenanceReport: allMalfunctionCache!
                                  .data!.malfunction![index].name!,
                              date: allMalfunctionCache!
                                  .data!.malfunction![index].createdAt!,
                              status: index > 4
                                  ? Malfunction.In_Progress.name
                                  : Malfunction.Pending.name,
                            ),
                          ),
                          itemCount:
                              allMalfunctionCache!.data!.malfunction!.length,
                          shrinkWrap: true,
                        )
                      : const EmptyWidget(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: MainBlocHomeCubit.of(context).indexList == 1 &&
              genderUser == RoleId.eight.name.tr
          ? CustomFloatingActionButtonMaintenance(
              onTap: () {
                final arguments = {
                  'nameStatus': 'Malfunction maintenance',
                  
                };
                Navigator.pushNamed(
                  context,
                  AppRoute.addMafunctionRequest,
                  arguments: arguments,
                );
              },
            )
          : Container(),
    );
  }
}
