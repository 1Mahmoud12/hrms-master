import 'package:cnattendance/Controller/StaticControllers/mainBlocHome/cubit.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/custom_floating_action_button_maintenance.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/periodic_maintenance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeriodicMaintenanceScreenItems extends StatelessWidget {
  const PeriodicMaintenanceScreenItems({super.key});

  @override
  Widget build(BuildContext context) {
    const String nameMaintenanceReport = 'Name Contract';
    const String location = 'Cairo';
    const int numberElevators = 15;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Periodic Maintenance',
          style: Styles.styleHeader,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            final arguments = {
              'nameMaintenanceReport': nameMaintenanceReport,
              'startDate': '24 Aug',
              'location': location,
              'numberElevators': numberElevators,
            };
            Navigator.pushNamed(context, AppRoute.detailsMaintenanceWidget, arguments: arguments);
          },
          child: PeriodicMaintenance(nameMaintenanceReport: nameMaintenanceReport, numberElevators: numberElevators.toString()),
        ),
        itemCount: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: MainBlocHomeCubit.of(context).indexList == 1 && genderUser == RoleId.eight.name.tr
          ? CustomFloatingActionButtonMaintenance(
              onTap: () {
                final arguments = {
                  'nameStatus': 'Request periodic maintenance',
                };
                Navigator.pushNamed(context, AppRoute.addMaintenanceContract, arguments: arguments);
              },
            )
          : Container(),
    );
  }
}
