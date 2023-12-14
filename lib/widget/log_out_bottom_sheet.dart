import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/morescreenprovider.dart';
import 'package:cnattendance/screen/auth/login_screen.dart';
import 'package:cnattendance/utils/navigationservice.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LogOutBottomSheet extends StatefulWidget {
  const LogOutBottomSheet({super.key});

  @override
  State<StatefulWidget> createState() => LogOutBottomSheetState();
}

class LogOutBottomSheetState extends State<LogOutBottomSheet> {
  void logout() async {
    try {
      setState(() {
        showLoader();
      });
      final response = await Provider.of<MoreScreenProvider>(context, listen: false).logout();

      setState(() {
        dismissLoader();
      });
      if (!mounted) {
        return;
      }
      if (response.statusCode == 200 || response.statusCode == 401) {
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const LoginScreen();
            },
          ),
          (_) => false,
        );
      }
    } catch (e) {
      NavigationService().showSnackBar('Log out Alert', e.toString());
      setState(() {
        dismissLoader();
      });
    }
  }

  void dismissLoader() {
    setState(() {
      EasyLoading.dismiss();
    });
  }

  void showLoader() {
    setState(() {
      EasyLoading.show(status: 'Logging Out, Please Wait..', maskType: EasyLoadingMaskType.black);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'logout'.tr,
                  style: Styles.style16700,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.black,
                    ),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'areyousurelogout'.tr,
                style: Styles.style16700.copyWith(fontWeight: FontWeight.w400),
              ),
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
                          style: TextButton.styleFrom(backgroundColor: AppColors.primaryColor, shape: ButtonBorder()),
                          onPressed: () async {
                            logout();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Confirm'.tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: TextButton(
                          style: TextButton.styleFrom(backgroundColor: AppColors.primaryColor, shape: ButtonBorder()),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Goback'.tr,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
