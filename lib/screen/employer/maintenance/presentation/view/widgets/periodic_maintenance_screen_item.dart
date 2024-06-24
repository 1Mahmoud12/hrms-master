import 'package:cnattendance/Controller/StaticControllers/mainBlocHome/cubit.dart';
import 'package:cnattendance/core/component/empty_widget.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/periodicBloc/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/periodicBloc/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/custom_floating_action_button_maintenance.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/periodic_maintenance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class PeriodicMaintenanceScreenItems extends StatelessWidget {
  const PeriodicMaintenanceScreenItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Periodic Maintenance'.tr,
          style: Styles.styleHeader,
        ),
      ),
      body: BlocProvider(
        create: (context) => PeriodicCubit()..getAllProposals(context: context),
        child: BlocBuilder<PeriodicCubit, PeriodicState>(
          builder: (context, state) => state is PeriodicLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is PeriodicErrorState
                  ? ErrorWidget(state.error)
                  : state is PeriodicSuccessState &&
                          allPeridicsCache != null &&
                          allPeridicsCache!.data != null &&
                          allPeridicsCache!.data!.periodic != null
                      ? ListView.builder(
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              final arguments = {
                                'onePeriodic': allPeridicsCache!.data!.periodic![index],
                              };
                              Navigator.pushNamed(context, AppRoute.detailsMaintenanceWidget, arguments: arguments);
                            },
                            child: PeriodicMaintenance(periodic: allPeridicsCache!.data!.periodic![index]),
                          ),
                          itemCount: allPeridicsCache!.data!.periodic!.length,
                        )
                      : const EmptyWidget(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: MainBlocHomeCubit.of(context).indexList == 1 && genderUser == RoleId.eight.name.tr
          ? CustomFloatingActionButtonMaintenance(
              onTap: () {
                final arguments = {
                  'nameStatus': 'Request periodic maintenance'.tr,
                };
                Navigator.pushNamed(context, AppRoute.addMaintenanceContract, arguments: arguments);
              },
            )
          : Container(),
    );
  }
}
