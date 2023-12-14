import 'package:cnattendance/model/attachment.dart';
import 'package:cnattendance/screen/tadascreen/widget/fileslistbottom.dart';
import 'package:cnattendance/screen/tadascreen/widget/imagelistbottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttachmentBottomSheet extends StatelessWidget {
  List<Attachment> attachments;

  AttachmentBottomSheet(this.attachments, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .9,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      // decoration: RadialDecoration(),
      decoration: const BoxDecoration(color: Color(0xffcfcdcb)),
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,),
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Color(0xff635F54),
                      ),),
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
                children: [
                  ItemListBottom(attachments),
                  FilesListBottom(attachments),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
