import 'package:cnattendance/model/support.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SupportDetailScreen extends StatelessWidget {
  Support support;

  SupportDetailScreen(this.support, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          foregroundColor: const Color(0xff635F54),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('SupportDetail'.tr),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2, top: 10),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),),),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            support.query_date,
                            style: const TextStyle(
                                color: Color(0xff635F54), fontSize: 14,),
                          ),
                          Text(
                            support.status,
                            style: TextStyle(
                                color: support.status == 'Pending'
                                    ? Colors.deepOrange
                                    : support.status == 'In Progress'
                                        ? Colors.orangeAccent
                                        : Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        support.title,
                        style: const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),),),
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description'.tr,
                        style:
                            const TextStyle(color: Color(0xff635F54), fontSize: 14),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        support.description,
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'AssignedTo'.tr,
                        style:
                            const TextStyle(color: Color(0xff635F54), fontSize: 14),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        support.requested_department,
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'SolvedBy'.tr,
                        style:
                            const TextStyle(color: Color(0xff635F54), fontSize: 14),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        support.status != 'Solved' ? '-' : support.solved_by,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'SolvedAt'.tr,
                        style:
                            const TextStyle(color: Color(0xff635F54), fontSize: 14),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        support.status != 'Solved' ? '-' : support.solved_at,
                        style: const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
