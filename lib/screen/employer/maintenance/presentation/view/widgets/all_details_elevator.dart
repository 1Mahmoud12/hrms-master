import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/header_details_contract.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';

class AllDetailsElevator extends StatelessWidget {
  const AllDetailsElevator({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = context.getArguments;
    final String date = argument['startDate'];
    final String location = argument['location'];
    final String name = argument['nameElevator'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: Styles.styleHeader,
        ),
      ),
      body: ListView(
        children: [
          HeaderDetailsContract(
            startDate: date,
            endDate: '2 Dec 2024',
            location: location,
          ),
        ],
      ),
    );
  }
}
