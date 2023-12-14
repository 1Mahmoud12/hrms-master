import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/model/leave.dart';
import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:cnattendance/utils/navigationservice.dart';
import 'package:cnattendance/widget/customalertdialog.dart';
import 'package:dropdown_button3/dropdown_button3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LeaveSheet extends StatefulWidget {
  const LeaveSheet({super.key});

  @override
  State<StatefulWidget> createState() => LeaveSheetState();
}

class LeaveSheetState extends State<LeaveSheet> {
  Leave? selectedValue;

  bool isLoading = false;

  TextEditingController endDate = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController startDate = TextEditingController();

  void issueLeave() async {
    if (endDate.text.isNotEmpty && startDate.text.isNotEmpty && reason.text.isNotEmpty && selectedValue != null) {
      try {
        showLoader();
        isLoading = true;
        final response =
            await Provider.of<LeaveProvider>(context, listen: false).issueLeave(startDate.text, endDate.text, reason.text, selectedValue!.id);

        if (!mounted) {
          return;
        }
        dismissLoader();
        Navigator.pop(context);
        isLoading = false;
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomAlertDialog(response.message),
            );
          },
        );
      } catch (e) {
        dismissLoader();
        isLoading = false;
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomAlertDialog(e.toString()),
            );
          },
        );
      }
    } else {
      NavigationService().showSnackBar('Leave Status', 'Field must not be empty');
    }
  }

  void dismissLoader() {
    setState(() {
      EasyLoading.dismiss();
    });
  }

  void showLoader() {
    setState(() {
      EasyLoading.show(status: 'Requesting...', maskType: EasyLoadingMaskType.black);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LeaveProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.scaffoldBackGround,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ApplyLeave'.tr,
                      style: Styles.styleHeader,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 1, // Spread radius
                        blurRadius: 10, // Blur radius
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'SelectLeaveType'.tr,
                              style: Styles.style14400,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: provider.leaveList
                          .where((element) => element.status)
                          .map(
                            (item) => DropdownMenuItem<Leave>(
                              value: item,
                              child: Text(
                                item.name,
                                style: Styles.style14400,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        selectedValue = value as Leave?;
                        if (selectedValue != null) {
                          setState(() {});
                        }
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20.w,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.grey,
                      buttonHeight: 50,
                      buttonWidth: 160,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: AppColors.fillColorTextFormField,
                      ),
                      buttonElevation: 0,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 200,
                      dropdownDecoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: AppColors.fillColorTextFormField,
                      ),
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                    ),
                  ),
                ),
                gaps(10),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 1, // Spread radius
                            blurRadius: 10, // Blur radius
                          ),
                        ],
                      ),
                      width: Get.width * 0.42,
                      child: TextField(
                        controller: startDate,
                        style: const TextStyle(color: Colors.black),
                        //editing controller of this TextField
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'StartDate'.tr,
                          hintStyle: const TextStyle(color: Colors.black),
                          prefixIcon: const Icon(Icons.calendar_month, color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white), // Set border color to white
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white), // Set border color to white
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white), // Set border color to white
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white), // Set border color to white
                          ),
                        ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            debugPrint(pickedDate.toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                            final String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
                            debugPrint(formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              startDate.text = formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 1, // Spread radius
                            blurRadius: 10, // Blur radius
                          ),
                        ],
                      ),
                      width: Get.width * 0.42,
                      child: TextField(
                        controller: endDate,
                        style: const TextStyle(color: Colors.black),
                        //editing controller of this TextField
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'EndDate'.tr,
                          hintStyle: const TextStyle(color: Colors.black),
                          prefixIcon: const Icon(Icons.calendar_month, color: Colors.black),
                          labelStyle: const TextStyle(color: Colors.black),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white), // Set border color to white
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white), // Set border color to white
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white), // Set border color to white
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white), // Set border color to white
                          ),
                        ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            debugPrint(pickedDate.toString()); //pickedDate output format => 2021-03-10 00:00:00.000
                            final String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
                            debugPrint(formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              endDate.text = formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ),
                    ),
                  ],
                ),
                gaps(10),
                gaps(10),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 1, // Spread radius
                        blurRadius: 10, // Blur radius
                      ),
                    ],
                  ),
                  child: CustomTextFormField(
                    controller: reason,
                    hintText: 'Reason',
                    maxLines: 5,
                  ),
                ),
                gaps(20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 5),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(29))),
                    ),
                    onPressed: () {
                      issueLeave();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'RequestLeave'.tr,
                        style: Styles.style18700.copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gaps(double value) {
    return SizedBox(
      height: value,
    );
  }
}
