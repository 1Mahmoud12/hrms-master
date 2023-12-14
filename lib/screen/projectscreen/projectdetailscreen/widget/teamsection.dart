import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/widget/teambottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_stack/image_stack.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectDetailController model = Get.find();
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
            TeamBottomSheet(
              model.project.value.leaders,
              model.project.value.members,
            ),
            isDismissible: true,
            enableDrag: true,
            isScrollControlled: false,
            ignoreSafeArea: true,);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'teamleader'.tr,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => ImageStack(
                  imageList: List<String>.from(model.memberImages),
                  totalCount: model.project.value.members.length,
                  imageCount: 4,
                  imageBorderColor: Colors.white,
                  imageBorderWidth: 1,
                ),
              ),
              Obx(
                () => ImageStack(
                  imageList: List<String>.from(model.leaderImages),
                  totalCount: model.project.value.leaders.length,
                  imageCount: 1,
                  imageBorderColor: Colors.white,
                  imageBorderWidth: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
