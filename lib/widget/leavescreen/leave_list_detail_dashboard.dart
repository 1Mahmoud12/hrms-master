import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:cnattendance/screen/leavescreen/components/RecentActivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaveListDetailsDashboard extends StatelessWidget {
  const LeaveListDetailsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<LeaveProvider>(context);
    final leaves = leaveData.leaveDetailList;
    if (leaves.isNotEmpty) {
      return ListView.builder(
        // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: leaves.length,
        itemBuilder: (ctx, i) {
          return RecentActivity(
            name: leaves[i].name,
            from: leaves[i].leave_from,
            to: leaves[i].leave_to,
            status: leaves[i].status,
            date: leaves[i].requested_date,
          );
        },
      );
    } else {
      return const SizedBox(
        height: 50,
      );
    }
  }
}
