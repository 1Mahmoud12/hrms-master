import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/header_details_contract.dart';
import 'package:flutter/material.dart';

class DetailsMaintenanceWidget extends StatelessWidget {
  const DetailsMaintenanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    final String nameMaintenanceReport = arguments['nameMaintenanceReport'];
    final String location = arguments['location'];
    final String date = arguments['startDate'];
    final int numberElevators = arguments['numberElevators'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          nameMaintenanceReport,
          style: Styles.styleHeader,
        ),
      ),
      body: ListView(
        children: [
          HeaderDetailsContract(startDate: date, endDate: '2 Dec 2024', location: location, numberElevators: numberElevators),
        ],
      ),
    );
  }
}
