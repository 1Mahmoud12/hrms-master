import 'package:cnattendance/provider/attendancereportprovider.dart';
import 'package:cnattendance/widget/attendancescreen/attendancecardview.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ReportListView extends StatelessWidget {
  const ReportListView({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceList = Provider.of<AttendanceReportProvider>(context).attendanceReport;
    if (attendanceList.isNotEmpty) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20).w,
          child: Column(
            children: [
              //attendanceReportTitle(),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: attendanceList.length,
                itemBuilder: (ctx, i) {
                  return AttendanceCardView(
                    i,
                    attendanceList[i].attendanceDate,
                    attendanceList[i].weekDay,
                    attendanceList[i].checkIn,
                    attendanceList[i].checkOut,
                  );
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return Visibility(
        visible: Provider.of<AttendanceReportProvider>(context).isLoading,
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  Widget attendanceReportTitle() {
    return Card(
      elevation: 0,
      color: Colors.black38,
      shape: ButtonBorder(),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text('Date'.tr, style: const TextStyle(fontSize: 15, color: Colors.white), textAlign: TextAlign.start),
            ),
            Expanded(
              child: Text('Day'.tr, style: const TextStyle(fontSize: 15, color: Colors.white), textAlign: TextAlign.start),
            ),
            Expanded(
              child: Text('Start_time'.tr, style: const TextStyle(fontSize: 15, color: Colors.white), textAlign: TextAlign.start),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Text('End_time'.tr, style: const TextStyle(fontSize: 15, color: Colors.white), textAlign: TextAlign.start),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
