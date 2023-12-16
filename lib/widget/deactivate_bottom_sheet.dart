import 'package:cnattendance/provider/morescreenprovider.dart';
import 'package:cnattendance/screen/auth/login_screen.dart';
import 'package:cnattendance/utils/navigationservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:cnattendance/widget/buttonborder.dart';

class DeactivemodalSheet extends StatefulWidget {
  const DeactivemodalSheet({super.key});

  @override
  State<StatefulWidget> createState() => DeactivemodalSheetState();
}

class DeactivemodalSheetState extends State<DeactivemodalSheet> {
  void deactivateuser() async {
    try {
      setState(() {
        showLoader();
      });
      final response = await Provider.of<MoreScreenProvider>(context, listen: false).deactivateUser(password: password.text);

      setState(() {
        dismissLoader();
      });
      if (!mounted) {
        return;
      }
      if (response) {
        Get.snackbar('Success', 'Account Deleted Successfully');

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
      NavigationService().showSnackBar('Deactivate Alert', e.toString());
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
      EasyLoading.show(
        status: 'Deactiviting Account , Please Wait..',
        maskType: EasyLoadingMaskType.black,
      );
    });
  }

  final password = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: const BoxDecoration(color: Color(0xffcfcdcb)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Deactivate',
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
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Are you sure you want to deativate your account?',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password is required';
                    }

                    return null;
                  },
                  controller: password,
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Password'.tr,
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.lock, color: Colors.black),
                    labelStyle: const TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xff635F54),
                      ),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
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
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xff635F54),
                          shape: ButtonBorder(),
                        ),
                        onPressed: () async {
                          deactivateuser();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Confirm'.tr,
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
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Goback'.tr,
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
    );
  }
}
