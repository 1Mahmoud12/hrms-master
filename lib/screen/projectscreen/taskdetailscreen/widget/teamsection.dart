import 'package:cnattendance/screen/projectscreen/taskdetailscreen/taskdetailcontroller.dart';
import 'package:cnattendance/screen/projectscreen/taskdetailscreen/widget/teambottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_stack/image_stack.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskDetailController controller = Get.find();
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(TeamBottomSheet(controller.taskDetail.value.members),
            isDismissible: true,
            enableDrag: true,
            isScrollControlled: false,
            ignoreSafeArea: true,);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Teams'.tr,
                style: const TextStyle(
                    color: Color(0xff635F54),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,),
              ),
              Text(
                'view_all'.tr,
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xff635F54),
                    fontSize: 12,
                    fontWeight: FontWeight.normal,),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => ImageStack(
              imageList: List<String>.from(controller.memberImages),
              totalCount: controller.memberImages.length,
              imageCount: 4,
              imageBorderColor: Colors.black12,
              imageBorderWidth: 1,
            ),
          ),
        ],
      ),
    );
  }
}
