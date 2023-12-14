import 'package:cnattendance/screen/projectscreen/taskdetailscreen/taskdetailcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:readmore/readmore.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskDetailController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          'Description'.tr,
          style: const TextStyle(
              color: Color(0xff635F54),
              fontSize: 16,
              fontWeight: FontWeight.bold,),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => ReadMoreText(
            parse(controller.taskDetail.value.description).body!.text,
            trimLines: 4,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show_more'.tr,
            trimExpandedText: 'Show_less'.tr,
            style: const TextStyle(
                color: Color(0xff635F54),
                fontSize: 15,
                fontWeight: FontWeight.normal,),
            lessStyle: const TextStyle(
                color: Color(0xff635F54),
                fontSize: 14,
                fontWeight: FontWeight.bold,),
            moreStyle: const TextStyle(
                color: Color(0xff635F54),
                fontSize: 14,
                fontWeight: FontWeight.bold,),
          ),
        ),
      ],
    );
  }
}
