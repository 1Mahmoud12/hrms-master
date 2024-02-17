import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:cnattendance/widget/cartTitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicDetail extends StatelessWidget {
  const BasicDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Card(
        shape: ButtonBorder(),
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTitle('Phone'.tr, userCache!.email!),
              CardTitle('Post'.tr, userCache!.email!),
              CardTitle('Dateofbirth'.tr, userCache!.email!),
              CardTitle('Gender'.tr, userCache!.email!),
              CardTitle('Address'.tr, userCache!.email!),
            ],
          ),
        ),
      ),
    );
  }
}
