import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:cnattendance/screen/leavescreen/components/leavesheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LeaveRequestButton extends StatelessWidget {
  const LeaveRequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    final leaveProvider = Provider.of<LeaveProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ToggleSwitch(
          cornerRadius: 20,
          activeBgColor: const [AppColors.primaryColor],
          activeFgColor: Colors.white,
          inactiveFgColor: AppColors.primaryColor,
          inactiveBgColor: AppColors.greyWhite,
          minWidth: Get.width * 0.4,
          minHeight: 34,
          initialLabelIndex: leaveProvider.indexReason,
          totalSwitches: 2,
          onToggle: (index) {
            leaveProvider.indexReason = index!;
            leaveProvider.toggle(index);
            index == 0
                ? showModalBottomSheet(
                    elevation: 0,
                    context: context,
                    useRootNavigator: true,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: const LeaveSheet(),
                      );
                    },)
                : showModalBottomSheet(
                    elevation: 0,
                    context: context,
                    useRootNavigator: true,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: const LeaveSheet(),
                      );
                    },);
          },
          labels: leaveProvider.leaveReason,
        ),
      ],
    );
  }
}
/* ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
                elevation: 0,
                context: context,
                useRootNavigator: true,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Leavesheet(),
                  );
                });
          },
          child: Text(
            'Issue_Leave'.tr,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xff635F54),
            ),
          ),
          style: ButtonStyle(
            // Define the button's width
            minimumSize: MaterialStateProperty.all(Size(Get.width * 0.4, 35)), // Adjust the width as needed

            // Define the button's shape and border radius
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0), // Adjust the border radius as needed
                side: BorderSide(width: 2, color: Color(0xff635F54)), // Adjust the border color as needed
              ),
            ),

            // Define the button's background color
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xffcfcdcb)), // Adjust the background color as needed

            // Define the text color when the button is pressed
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
                elevation: 0,
                context: context,
                useRootNavigator: true,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Leavesheet(),
                  );
                });
          },
          child: Text(
            'Early_Leave'.tr,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xff635F54),
            ),
          ),
          style: ButtonStyle(
            // Define the button's width
            minimumSize: MaterialStateProperty.all(Size(Get.width * 0.4, 35)), // Adjust the width as needed

            // Define the button's shape and border radius
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0), // Adjust the border radius as needed
                side: BorderSide(width: 2, color: Color(0xff635F54)), // Adjust the border color as needed
              ),
            ),

            // Define the button's background color
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xffcfcdcb)), // Adjust the background color as needed

            // Define the text color when the button is pressed
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),*/
