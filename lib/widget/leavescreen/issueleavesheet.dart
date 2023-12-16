import 'package:cnattendance/model/leave.dart';
import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:cnattendance/utils/navigationservice.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:cnattendance/widget/customalertdialog.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:dropdown_button3/dropdown_button3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class IssueLeaveSheet extends StatefulWidget {
  const IssueLeaveSheet({super.key});

  @override
  State<StatefulWidget> createState() => IssueLeaveSheetState();
}

class IssueLeaveSheetState extends State<IssueLeaveSheet> {
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
        final response = await Provider.of<LeaveProvider>(context, listen: false).issueLeave(
          startDate.text,
          endDate.text,
          reason.text,
          selectedValue!.id,
        );

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
      EasyLoading.show(
        status: 'Requesting...',
        maskType: EasyLoadingMaskType.black,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LeaveProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Container(
        decoration: RadialDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Apply Leave',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Select Leave Type',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
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
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
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
                  ),
                ),
              ),
              gaps(10),
              TextField(
                controller: startDate,
                style: const TextStyle(color: Colors.white),
                //editing controller of this TextField
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Select Start Date',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.calendar_month, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white24,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
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
                    print(
                      pickedDate,
                    ); //pickedDate output format => 2021-03-10 00:00:00.000
                    final String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
                    print(
                      formattedDate,
                    ); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      startDate.text = formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ),
              gaps(10),
              TextField(
                controller: endDate,
                style: const TextStyle(color: Colors.white),
                //editing controller of this TextField
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Select End Date',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.calendar_month, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white24,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
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
                    print(
                      pickedDate,
                    ); //pickedDate output format => 2021-03-10 00:00:00.000
                    final String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
                    print(
                      formattedDate,
                    ); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      endDate.text = formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ),
              gaps(10),
              TextField(
                textAlignVertical: TextAlignVertical.top,
                controller: reason,
                maxLines: 5,
                style: const TextStyle(color: Colors.white),
                //editing controller of this TextField
                cursorColor: Colors.white,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Reason',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.edit_note, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white24,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              gaps(20),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff036eb7),
                    padding: EdgeInsets.zero,
                    shape: ButtonBorder(),
                  ),
                  onPressed: () {
                    issueLeave();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Request Leave',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
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
