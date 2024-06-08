import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/provider/projectdashboardcontroller.dart';
import 'package:cnattendance/screen/employer/ProjectsScreen/widgets/card_project.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Get.put(ProjectDashboardController()).getProjectOverview();
    final model = Get.put(ProjectDashboardController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Projects',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: [
                ...List.generate(
                  model.projectList.length.obs.value,
                  (index) => CardProject(project: model.projectList[index],index: index,),
                ),
                30.ESH(),
              ].paddingDirectional(bottom: 10.h),
            ),
          ),
        ),
      ),
    );
  }
}

class LeadershipComp extends StatelessWidget {
  final String? leaderImg;
  final String? leaderName;
  final String? leaderDesign;

  const LeadershipComp({super.key, required this.leaderImg, required this.leaderName, required this.leaderDesign});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: 240,
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 156,
              width: 165,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage(leaderImg!),
                  colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.9),
                    BlendMode.modulate,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Flexible(
              child: Text(
                leaderName!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Flexible(
            child: Text(
              leaderDesign!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*SizedBox(
                height: context.screenHeight * .28,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: leaderlist.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return LeadershipComp(
                      leaderDesign: leaderlist[index]['leaderdesig'],
                      leaderImg: leaderlist[index]['leaderimg'],
                      leaderName: leaderlist[index]['leadername'],
                    );
                  },
                ),
              ),*/
/* const SizedBox(
                // width: MediaQuery.of(context).size.width,
                height: 200,
                child: SliderWidget(),
              ),*/
