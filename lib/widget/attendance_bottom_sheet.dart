import 'package:cnattendance/provider/dashboardprovider.dart';
import 'package:cnattendance/widget/customalertdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:cnattendance/widget/buttonborder.dart';

class AttedanceBottomSheet extends StatefulWidget {
  const AttedanceBottomSheet({super.key});

  @override
  State<StatefulWidget> createState() => AttendanceBottomSheetState();
}

class AttendanceBottomSheetState extends State<AttedanceBottomSheet> {
  bool isEnabled = true;
  bool isLoading = false;

  void onCheckOut() async {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    try {
      setState(() {
        isLoading = true;
        EasyLoading.show(
          status: 'Requesting...',
          maskType: EasyLoadingMaskType.black,
        );
      });
      final status = await provider.getCheckInStatus();
      if (status) {
        final response = await provider.checkOutAttendance();
        isEnabled = true;
        if (!mounted) {
          return;
        }
        setState(() {
          EasyLoading.dismiss();
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
        });
      }
    } catch (e) {
      setState(() {
        EasyLoading.dismiss();
        isLoading = false;
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomAlertDialog(e.toString()),
            );
          },
        );
      });
    }
  }

  void onCheckIn() async {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    try {
      isLoading = true;
      setState(() {
        EasyLoading.show(
          status: 'Requesting...',
          maskType: EasyLoadingMaskType.black,
        );
      });
      final status = await provider.getCheckInStatus();
      if (status) {
        final response = await provider.checkInAttendance();
        isEnabled = true;
        if (!mounted) {
          return;
        }
        setState(() {
          EasyLoading.dismiss();
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
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        EasyLoading.dismiss();
        Navigator.pop(context);
        isLoading = false;
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: CustomAlertDialog(e.toString()),
            );
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Container(
        decoration: const BoxDecoration(color: Color(0xffcfcdcb)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Checkinout'.tr,
                    style: const TextStyle(fontSize: 18, color: Color(0xff635F54)),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: Color(0xff635F54),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(right: 5, left: 5),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff635F54),
                            shape: ButtonBorder(),
                          ),
                          onPressed: () async {
                            isEnabled ? onCheckIn() : null;
                            isEnabled = false;
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'check_in'.tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff635F54),
                            shape: ButtonBorder(),
                          ),
                          onPressed: () {
                            isEnabled ? onCheckOut() : null;
                            isEnabled = false;
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'check_out'.tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
