import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:cnattendance/screen/leavescreen/components/LeaveSummary.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class LeaveListDashboard extends StatelessWidget {
  const LeaveListDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final leaveData = Provider.of<LeaveProvider>(context);
    final leaves = leaveData.leaveList;
    if (leaves.isNotEmpty) {
      return SizedBox(
        height: context.screenHeight * .35,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ChangeNotifierProvider.value(
                    value: leaves[0],
                    // child: LeaveRow(leaves[i].id, leaves[i].name,
                    //     leaves[i].allocated, leaves[i].total),
                    child: LeaveSummary(
                      maintxt: leaves[0].name,
                      allocated: leaves[0].allocated,
                      used: leaves[0].total,
                      borderColor: const Color(0xff3085FE),
                      colorBackGround: const Color(0xff3085FE).withOpacity(.2),
                      svgName: Assets.unPaidLeave,
                    ),
                  ),
                ),
                Expanded(
                  child: ChangeNotifierProvider.value(
                    value: leaves[1],
                    // child: LeaveRow(leaves[i].id, leaves[i].name,
                    //     leaves[i].allocated, leaves[i].total),
                    child: LeaveSummary(
                      maintxt: leaves[1].name,
                      allocated: leaves[1].allocated,
                      used: leaves[1].total,
                      borderColor: const Color(0xffA3D139),
                      colorBackGround: const Color(0xffA3D139).withOpacity(.2),
                      svgName: Assets.sickLeave,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ChangeNotifierProvider.value(
                    value: leaves[2],
                    // child: LeaveRow(leaves[i].id, leaves[i].name,
                    //     leaves[i].allocated, leaves[i].total),
                    child: LeaveSummary(
                      maintxt: leaves[2].name,
                      allocated: leaves[2].allocated,
                      used: leaves[2].total,
                      borderColor: const Color(0xff30BEB6),
                      colorBackGround: const Color(0xff30BEB6).withOpacity(.2),
                      svgName: Assets.paidLeave,
                    ),
                  ),
                ),
                Expanded(
                  child: ChangeNotifierProvider.value(
                    value: leaves[3],
                    // child: LeaveRow(leaves[i].id, leaves[i].name,
                    //     leaves[i].allocated, leaves[i].total),
                    child: LeaveSummary(
                      maintxt: leaves[3].name,
                      allocated: leaves[3].allocated,
                      used: leaves[3].total,
                      borderColor: const Color(0xffFF7F74),
                      colorBackGround: const Color(0xffFF7F74).withOpacity(.2),
                      svgName: Assets.casualLeave,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: CircularProgressIndicator(),
      );
    }
  }
}
/* SizedBox(
        height: context.screenHeight * .32,
        child: GridView.count(
          // padding: EdgeInsets.all(20),
          /*gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2 / 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10)*/
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          children: [



          ],
        ),
      )
(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: leaves.length,
        // padding: EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.2 / 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),children: [],
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: leaves[i],
          // child: LeaveRow(leaves[i].id, leaves[i].name,
          //     leaves[i].allocated, leaves[i].total),
          child: LeaveSummary(
            maintxt: leaves[i].name,
            allocated: leaves[i].allocated,
            used: leaves[i].total,
          ),
        ),
      )
* */
