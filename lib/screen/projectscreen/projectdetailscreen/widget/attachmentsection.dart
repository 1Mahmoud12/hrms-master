import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/widget/attachmentbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttachmentSection extends StatelessWidget {
  const AttachmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectDetailController model = Get.find();
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(const AttachmentBottomSheet(),
            isDismissible: true,
            enableDrag: true,
            isScrollControlled: true,
            ignoreSafeArea: true,);
      },
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Attachments'.tr,
                  style: const TextStyle(
                      color: Color(0xff635F54),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,),
                ),
                Text(
                  'Show_Media'.tr,
                  style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xff635F54),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  color: const Color(0xff635F54),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // child: Text(
                    //   "Files/Images ( ${model.project.value.attachment.length} )",
                    //   style: TextStyle(
                    //       color: Colors.white70,
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'FilesImages'.tr,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' ( ${model.project.value.attachment.length} )',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
