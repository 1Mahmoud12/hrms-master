import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/network/model/meeting/Participator.dart';
import 'package:cnattendance/screen/profile/meetingdetailscreen.dart';
import 'package:cnattendance/widget/meeting/meetingparticipator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MeetingCard extends StatelessWidget {
  final int id;
  final String title;
  final String venue;
  final String date;
  final List<Participator> participator;

  const MeetingCard(this.id, this.title, this.venue, this.date, this.participator, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          MeetingDetailScreen.routeName,
          arguments: id,
        );
      },
      child: Card(
        color: AppColors.cBackGroundIconMaintenance,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            // alignment: Alignment.center,
            children: [
              Align(
                // alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Venue : $venue',
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Directionality(
                        textDirection: defaultLanguage != 'en' ? TextDirection.ltr : TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                date,
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.28,
                            ),
                            SizedBox(
                              height: 25,
                              child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: participator.length < 3 ? participator.length : 3,
                                itemBuilder: (context, index) {
                                  return MeetingParticipator(
                                    participator[index].avatar,
                                  );
                                },
                              ),
                            ),
                            if (participator.length <= 3)
                              const SizedBox(
                                width: 5,
                              ),
                            if (participator.length <= 3)
                              Text(
                                '+${participator.length - 3} more',
                              style: const TextStyle(
                                fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
