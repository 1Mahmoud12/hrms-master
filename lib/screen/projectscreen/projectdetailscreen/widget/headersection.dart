import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectDetailController model = Get.find();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: const Color(0xfffff8f8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
            child: Obx(() => Text(
                  model.project.value.priority,
                  style: const TextStyle(
                    color: Color(0xff635F54),
                  ),
                ),),
          ),
        ),
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              model.project.value.name,
              style: const TextStyle(
                  color: Color(0xff635F54),
                  fontSize: 21,
                  fontWeight: FontWeight.bold,),
            ),
          ),
        ),
        Row(
          children: [
            Card(
              margin: EdgeInsets.zero,
              color: const Color(0xfffff8f8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Row(
                  children: [
                    Text(
                      'due_date'.tr,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,),
                    ),
                    Obx(
                      () => Text(
                        model.project.value.date,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: const Color(0xff635F54),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                child: Obx(
                  () => Text(
                    model.project.value.status,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
