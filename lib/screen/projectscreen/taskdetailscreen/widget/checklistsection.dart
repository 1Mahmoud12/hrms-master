import 'package:cnattendance/model/checklist.dart';
import 'package:cnattendance/screen/projectscreen/taskdetailscreen/taskdetailcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckListSection extends StatelessWidget {
  const CheckListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskDetailController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          'Checklists'.tr,
          style: const TextStyle(
              color: Color(0xff635F54),
              fontSize: 16,
              fontWeight: FontWeight.bold,),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => controller.taskDetail.value.checkList.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'NoCheckListFound'.tr,
                      style: const TextStyle(
                        color: Color(0xff635F54),
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.taskDetail.value.checkList.length,
                  itemBuilder: (context, index) {
                    final Checklist checklist =
                        controller.taskDetail.value.checkList[index];
                    final state = false.obs;
                    state.value = checklist.isCompleted == '0' ? false : true;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),),),
                      elevation: 0,
                      color: Colors.white10,
                      child: InkWell(
                        onTap: () async {
                          final response = await controller
                              .checkListToggle(checklist.id.toString());

                          if (response) {
                            state.value = !state.value;
                            checklist.isCompleted =
                                state.value == false ? '0' : '1';
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: () async {},
                                  child: Icon(
                                    state == true
                                        ? Icons.check_circle
                                        : Icons.radio_button_unchecked,
                                    color: state == true
                                        ? Colors.green
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Text(checklist.name,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        height: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
