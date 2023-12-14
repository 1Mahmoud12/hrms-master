import 'package:cnattendance/screen/projectscreen/projectlistscreen/projectlistscrreencontroller.dart';
import 'package:cnattendance/screen/projectscreen/projectlistscreen/widget/projectlist.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(ProjectListScreenController());
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: const Color(0xff635F54),
          title: Text('Projects'.tr),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return model.getProjectOverview();
            },
            child: Container(
              child: Column(
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),),),
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
                                    color: model.selected.value == 'All'
                                        ? Colors.white24
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15,),
                                      child: Text(
                                        'All'.tr,
                                        style: const TextStyle(
                                            color: Color(0xff635F54),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,),
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
                                    color: model.selected.value == 'In Progress'
                                        ? Colors.white24
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15,),
                                      child: Text(
                                        'In_progress'.tr,
                                        style: const TextStyle(
                                            color: Color(0xff635F54),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,),
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
                                    color: model.selected.value == 'Completed'
                                        ? Colors.white24
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15,),
                                      child: Text(
                                        'Completed'.tr,
                                        style: const TextStyle(
                                            color: Color(0xff635F54),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,),
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
                                    color: model.selected.value == 'On Hold'
                                        ? Colors.white24
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15,),
                                      child: Text(
                                        'On_Hold'.tr,
                                        style: const TextStyle(
                                            color: Color(0xff635F54),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,),
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
                                    color: model.selected.value == 'Cancelled'
                                        ? Colors.white24
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15,),
                                      child: Text(
                                        'Cancelled'.tr,
                                        style: const TextStyle(
                                            color: Color(0xff635F54),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,),
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
                                    color: model.selected.value == 'Not Started'
                                        ? Colors.white24
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 15,),
                                      child: Text(
                                        'Not_Started'.tr,
                                        style: const TextStyle(
                                            color: Color(0xff635F54),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,),
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
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ProjectList(),
                  ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
