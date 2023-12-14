import 'package:cnattendance/model/member.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamBottomSheet extends StatelessWidget {
  List<Member> members;

  TeamBottomSheet(this.members, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          color: Color(0xfffff8f8),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Team_Member'.tr,
                      style: const TextStyle(
                          color: Color(0xff635F54),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Color(0xff635F54),
                        ),),
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  itemCount: members.length,
                  itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.all(5), child: teamCard(members[i]),),),
            ],
          ),
        ),
      ),
    );
  }

  Widget teamCard(Member member) {
    return Card(
      shape: ButtonBorder(),
      elevation: 0,
      color: Colors.black12,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                member.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      member.name,
                      style: const TextStyle(color: Color(0xff635F54), fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    Text(member.post,
                        style: const TextStyle(
                          color: Color(0xff635F54),
                        ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
