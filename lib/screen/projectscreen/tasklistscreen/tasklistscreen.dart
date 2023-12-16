import 'package:cnattendance/model/task.dart';
import 'package:cnattendance/screen/projectscreen/taskdetailscreen/taskdetailscreen.dart';
import 'package:cnattendance/screen/projectscreen/tasklistscreen/tasklistscontroller.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(TaskListController());
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: const Color(0xff635F54),
          title: Text('Tasks'.tr),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return model.getTaskList();
            },
            child: Container(
              child: Column(
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    color: Colors.white12,
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Obx(
                        () => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    model.selected.value = 'All';
                                    model.filterList();
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: model.selected.value == 'All' ? Colors.white24 : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 15,
                                      ),
                                      child: Text(
                                        'All'.tr,
                                        style: const TextStyle(
                                          color: Color(0xff635F54),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    model.selected.value = 'In Progress';
                                    model.filterList();
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: model.selected.value == 'In Progress' ? Colors.white24 : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 15,
                                      ),
                                      child: Text(
                                        'In_progress'.tr,
                                        style: const TextStyle(
                                          color: Color(0xff635F54),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    model.selected.value = 'Completed';
                                    model.filterList();
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: model.selected.value == 'Completed' ? Colors.white24 : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 15,
                                      ),
                                      child: Text(
                                        'Completed'.tr,
                                        style: const TextStyle(
                                          color: Color(0xff635F54),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    model.selected.value = 'On Hold';
                                    model.filterList();
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: model.selected.value == 'On Hold' ? Colors.white24 : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 15,
                                      ),
                                      child: Text(
                                        'On_Hold'.tr,
                                        style: const TextStyle(
                                          color: Color(0xff635F54),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    model.selected.value = 'Cancelled';
                                    model.filterList();
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: model.selected.value == 'Cancelled' ? Colors.white24 : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 15,
                                      ),
                                      child: Text(
                                        'Cancelled'.tr,
                                        style: const TextStyle(
                                          color: Color(0xff635F54),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    model.selected.value = 'Not Started';
                                    model.filterList();
                                  },
                                  child: Card(
                                    elevation: 0,
                                    color: model.selected.value == 'Not Started' ? Colors.white24 : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 15,
                                      ),
                                      child: Text(
                                        'Not_Started'.tr,
                                        style: const TextStyle(
                                          color: Color(0xff635F54),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Obx(
                      () => model.filteredList.isEmpty
                          ? SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Container(),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                primary: false,
                                itemCount: model.filteredList.length,
                                itemBuilder: (context, index) {
                                  final Task item = model.filteredList[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        const TaskDetailScreen(),
                                        arguments: {'id': item.id},
                                      );
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(vertical: 10),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      color: const Color(0xfffff8f8),
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              maxLines: 1,
                                              item.name!,
                                              style: const TextStyle(
                                                color: Color(0xff635F54),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.work,
                                                  color: Colors.black12,
                                                  size: 15,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  maxLines: 1,
                                                  item.projectName!,
                                                  style: const TextStyle(
                                                    color: Color(0xff635F54),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Divider(color: Colors.grey),
                                            const SizedBox(
                                              height: 0,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${item.date!}-${item.endDate!}',
                                                  style: const TextStyle(
                                                    color: Color(0xff635F54),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                                Card(
                                                  elevation: 0,
                                                  color: item.status == 'In Progress'
                                                      ? const Color(0xff80C1E1C1)
                                                      : item.status == 'Not Started'
                                                          ? const Color(0xffC9CC3F)
                                                          : item.status == 'On Hold'
                                                              ? const Color(
                                                                  0xff93C572,
                                                                )
                                                              : const Color(
                                                                  0xff3cb116,
                                                                ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 5,
                                                    ),
                                                    child: Text(
                                                      item.status!,
                                                      style: const TextStyle(
                                                        color: Color(0xff635F54),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
