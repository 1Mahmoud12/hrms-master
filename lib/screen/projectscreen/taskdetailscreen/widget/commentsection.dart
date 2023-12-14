import 'package:cnattendance/screen/projectscreen/commentscreen/commentscreen.dart';
import 'package:cnattendance/screen/projectscreen/taskdetailscreen/taskdetailcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskDetailController controller = Get.find();
    return GestureDetector(
      onTap: () {
        Get.to(const CommentScreen(), arguments: {
          'taskId': controller.taskDetail.value.id.toString(),
          'members': controller.taskDetail.value.members,
        },);
      },
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () =>
                    //   Text(
                    //     "Comments ( ${controller.taskDetail.value.noOfComments} )",
                    //     style: TextStyle(
                    //         color: Color(0xff635F54),
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Comments'.tr,
                        style: const TextStyle(
                          color: Color(0xff635F54),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' ( ${controller.taskDetail.value.noOfComments} )',
                        style: const TextStyle(
                          color: Color(0xff635F54),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
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
          // SizedBox(height: 10),
          // Card(
          //   color: Colors.blue,
          //   child: Padding(
          //     padding: const EdgeInsets.all(10),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Icon(
          //           Icons.comment,
          //           color: Colors.white,
          //         ),
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Text(
          //           "Write a comment",
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 15,
          //               fontWeight: FontWeight.bold),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
