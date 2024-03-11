import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/widget/attachmentsection.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/widget/descriptionsection.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/widget/headersection.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/widget/tasksection.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/widget/teamsection.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(ProjectDetailController());
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: const Color(0xff635F54),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(const Duration(seconds: 1));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20,
                  ),
                  child: model.project.value.id == 0
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HeaderSection(),
                            const DescriptionSection(),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Color(0xff635F54),
                            ),
                            const TeamSection(),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Color(0xff635F54),
                            ),
                            const AttachmentSection(),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Color(0xff635F54),
                            ),
                            Obx(
                              () => model.project.value.tasks.isNotEmpty ? const TaskSection() : const SizedBox(),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
