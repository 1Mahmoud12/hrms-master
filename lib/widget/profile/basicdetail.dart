import 'package:cnattendance/provider/profileprovider.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:cnattendance/widget/cartTitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BasicDetail extends StatelessWidget {
  const BasicDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context).profile;
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
              CardTitle('Phone'.tr, profile.phone),
              CardTitle('Post'.tr, profile.post),
              CardTitle('Dateofbirth'.tr, profile.dob),
              CardTitle('Gender'.tr, profile.gender),
              CardTitle('Address'.tr, profile.address),
            ],
          ),
        ),
      ),
    );
  }
}
