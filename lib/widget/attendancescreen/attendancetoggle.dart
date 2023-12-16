import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/model/month.dart';
import 'package:cnattendance/provider/attendancereportprovider.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:dropdown_button3/dropdown_button3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AttendanceToggle extends StatefulWidget {
  const AttendanceToggle({super.key});

  @override
  State<StatefulWidget> createState() => AttendanceToggleState();
}

class AttendanceToggleState extends State<AttendanceToggle> {
  bool initial = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AttendanceReportProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 8, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Attenance_history'.tr,
            style: Styles.style16700,
          ),
          Consumer(
            builder: (context, value, child) {
              return DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  items: (provider.month)
                      .map(
                        (item) => DropdownMenuItem<Month>(
                          value: item,
                          child: Text(
                            item.name,
                            style: Styles.style12400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  value: provider.month[provider.selectedMonth],
                  onChanged: (value) {
                    debugPrint(value.toString());
                    setState(() {
                      provider.selectedMonth = (value! as Month).index;
                      provider.getAttendanceReport();
                    });
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: context.screenWidth * .05,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.black,
                  iconDisabledColor: Colors.grey,
                  buttonHeight: 40,
                  buttonWidth: 110,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color(0xffFFFFFF),
                  ),
                  buttonElevation: 0,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 200,
                  dropdownDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color(0xffFFFFFF),
                  ),
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
