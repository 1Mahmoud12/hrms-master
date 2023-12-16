import 'package:cnattendance/model/project.dart';
import 'package:cnattendance/screen/projectscreen/projectlistscreen/projectlistscrreencontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_stack/image_stack.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProjectCard extends StatelessWidget {
  final Project item;

  const ProjectCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectListScreenController model = Get.find();

    final List<String> members = [];
    for (final member in item.members) {
      members.add(member.image);
    }

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      elevation: 0,
      color: const Color(0xfffff8f8),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        onTap: () {
          model.onProjectClicked(item);
        },
        child: Container(
          padding: const EdgeInsets.all(20),
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
                    margin: EdgeInsets.zero,
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
                      color: Color(0xff635F54),
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.flag,
                    size: 15,
                    color: Color(0xff635F54),
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
              const SizedBox(
                height: 10,
              ),
              ImageStack(
                imageList: members,
                totalCount: members.length,
                imageRadius: 30,
                imageCount: 4,
                imageBorderWidth: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              LinearPercentIndicator(
                padding: EdgeInsets.zero,
                percent: item.progress / 100,
                width: MediaQuery.of(context).size.width - 80,
                lineHeight: 10,
                barRadius: const Radius.circular(20),
                backgroundColor: Colors.black12,
                progressColor: item.progress <= 25
                    ? const Color(0xffC1E1C1)
                    : item.progress <= 50
                        ? const Color(0xffC9CC3F)
                        : item.progress <= 75
                            ? const Color(0xff93C572)
                            : const Color(0xff3cb116),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.status,
                    style: const TextStyle(color: Color(0xff635F54), fontSize: 12),
                  ),
                  Text(
                    '${item.progress}%',
                    style: const TextStyle(color: Color(0xff635F54), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
