import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../model/attachment.dart';

class FilesListBottom extends StatelessWidget {
  const FilesListBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectDetailController model = Get.find();
    final attachments = <Attachment>[];

    for (final attachment in model.project.value.attachment) {
      if (attachment.type == 'file') {
        attachments.add(attachment);
      }
    }
    return Container(
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: attachments.length,
          primary: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final attachment = attachments[index];
            return Card(
                elevation: 0,
                color: Colors.white12,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          attachment.url,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          model.launchUrls(attachment.url);
                        },
                        child: const Icon(
                          Icons.download,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),);
          },
        ),);
  }
}
