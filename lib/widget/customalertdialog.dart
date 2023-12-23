import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;

  const CustomAlertDialog(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.scaffoldBackGround, borderRadius: BorderRadius.all(Radius.circular(20.r))),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/dialog_icon.png',
            width: 80,
            height: 80,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            textAlign: TextAlign.center,
            title,
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            // child: ElevatedButton(
            //   style: TextButton.styleFrom(
            //       backgroundColor: HexColor("#036eb7"), shape: ButtonBorder()),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: 15),
            //     child: Text("Close"),
            //   ),
            // ),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(29)),
                ),
              ),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
