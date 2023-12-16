import 'package:cnattendance/model/project.dart';
import 'package:cnattendance/model/task.dart';
import 'package:cnattendance/provider/projectdashboardcontroller.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailscreen.dart';
import 'package:cnattendance/screen/projectscreen/projectlistscreen/projectlistscreen.dart';
import 'package:cnattendance/screen/projectscreen/taskdetailscreen/taskdetailscreen.dart';
import 'package:cnattendance/screen/projectscreen/tasklistscreen/tasklistscreen.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_stack/image_stack.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProjectScreen extends StatelessWidget {
  final model = Get.put(ProjectDashboardController());

  ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              child: Image.asset('assets/icons/backicon.png'),
            ),
          ),
          title: Text(
            'Projects'.tr,
            style: const TextStyle(
              color: Color(0xff635F54),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          color: Colors.white,
          backgroundColor: Colors.blueGrey,
          edgeOffset: 50,
          onRefresh: () {
            return model.getProjectOverview();
          },
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [projectOverview(), recentProject(), recentTasks()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget projectOverview() {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      color: const Color(0xfffff8f8),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Obx(
                () => CircularPercentIndicator(
                  radius: 60.0,
                  animation: true,
                  animationDuration: 1200,
                  lineWidth: 15.0,
                  // ignore: invalid_use_of_protected_member
                  percent: model.overview.value['progress']! / 100,
                  center: Obx(
                    () => Text(
                      // ignore: invalid_use_of_protected_member
                      "${model.overview.value['progress']}%",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Color(0xff635F54),
                      ),
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.black12,
                  progressColor:
                      // ignore: invalid_use_of_protected_member
                      (model.overview.value['progress']! / 100) <= .25
                          ? Color(0xffC1E1C1)
                          // ignore: invalid_use_of_protected_member
                          : (model.overview.value['progress']! / 100) <= .50
                              ? Color(0xffC9CC3F)
                              // ignore: invalid_use_of_protected_member
                              : (model.overview.value['progress']! / 100) <= .75
                                  ? Color(0xff93C572)
                                  : Color(0xff3cb116),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'progress_current_task'.tr,
                    style: const TextStyle(
                      color: Color(0xff635F54),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    endIndent: 0,
                    indent: 0,
                  ),
                  Obx(
                    () => Text(
                      // ignore: invalid_use_of_protected_member
                      "${model.overview.value['task_completed']} / ${model.overview.value['total_task']}${"Task_Completed".tr}",
                      style: const TextStyle(
                        color: Color(0xff635F54),
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget recentProject() {
    return Obx(
      () => Visibility(
        visible: model.projectList.isEmpty ? false : true,
        child: Container(
          height: 300,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent_project'.tr,
                    style: const TextStyle(
                      color: Color(0xff635F54),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const ProjectListScreen());
                    },
                    child: Text(
                      'view_all'.tr,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff635F54),
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: model.projectList.length,
                  itemBuilder: (context, index) {
                    final Project item = model.projectList[index];
                    final memberImages = [];

                    for (final member in item.members) {
                      memberImages.add(member.image);
                    }

                    return GestureDetector(
                      onTap: () {
                        Get.to(const ProjectDetailScreen(), arguments: {'id': item.id});
                      },
                      child: Card(
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        color: const Color(0xfffff8f8),
                        child: Container(
                          height: 290,
                          width: 200,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.work,
                                    size: 20,
                                    color: Color(0xff635F54),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Colors.black12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        item.priority,
                                        style: const TextStyle(color: Color(0xff635F54)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                item.name,
                                maxLines: 2,
                                style: const TextStyle(
                                  height: 1.5,
                                  color: Color(0xff635F54),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.date,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.flag,
                                    size: 15,
                                    color: Colors.black12,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    item.noOfTask.toString(),
                                    style: const TextStyle(
                                      color: Color(0xff635F54),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              ImageStack(
                                imageList: List<String>.from(memberImages),
                                totalCount: memberImages.length,
                                imageCount: 4,
                                imageBorderColor: Colors.black12,
                                imageBorderWidth: 1,
                              ),
                              LinearPercentIndicator(
                                padding: EdgeInsets.zero,
                                percent: item.progress / 100,
                                lineHeight: 10,
                                barRadius: const Radius.circular(20),
                                backgroundColor: Colors.black12,
                                progressColor: item.progress <= 25
                                    ? Color(0xffC1E1C1)
                                    : item.progress <= 50
                                        ? Color(0xffC9CC3F)
                                        : item.progress <= 75
                                            ? Color(0xff93C572)
                                            : Color(0xff3cb116),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.status,
                                    style: const TextStyle(
                                      color: Color(0xff635F54),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${item.progress}%',
                                    style: const TextStyle(
                                      color: Color(0xff635F54),
                                      fontSize: 12,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget recentTasks() {
    return Obx(
      () => Visibility(
        visible: model.taskList.isEmpty ? false : true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent_taks'.tr,
                    style: const TextStyle(
                      color: Color(0xff635F54),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        const TaskListScreen(),
                        transition: Transition.cupertino,
                      );
                    },
                    child: Text(
                      'view_all'.tr,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xff635F54),
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: model.taskList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final Task item = model.taskList[index];
                    return InkWell(
                      onTap: () {
                        Get.to(const TaskDetailScreen(), arguments: {'id': item.id});
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                    color: Color(0xff635F54),
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
                                        ? Color(0xff80C1E1C1)
                                        : item.status == 'Not Started'
                                            ? Color(0xffC9CC3F)
                                            : item.status == 'On Hold'
                                                ? Color(0xff93C572)
                                                : Color(0xff3cb116),
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
            ],
          ),
        ),
      ),
    );
  }
}
