import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/widget/fileslistbottom.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/widget/imagelistbottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttachmentBottomSheet extends StatelessWidget {
  const AttachmentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration:
          const BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Attachments'.tr,
                    style: const TextStyle(
                      color: Color(0xff635F54),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Color(0xff635F54),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Image'.tr,
                  style: const TextStyle(color: Color(0xff635F54), fontSize: 15),
                ),
                Text(
                  'files'.tr,
                  style: const TextStyle(color: Color(0xff635F54), fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                children: const [
                  ItemListBottom(),
                  FilesListBottom(),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
