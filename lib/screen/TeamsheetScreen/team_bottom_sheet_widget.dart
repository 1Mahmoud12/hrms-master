import 'package:cnattendance/model/team.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamBottomSheetWidget extends StatelessWidget {
  final Team teamList;
  const TeamBottomSheetWidget({super.key, required this.teamList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all(color: teamList.active == '1' ? Colors.green : Colors.grey, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  teamList.avatar,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/dummy_avatar.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              teamList.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff635F54),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              teamList.post,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xff635F54),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse('tel:${teamList.phone}');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  style: ButtonStyle(
                    // Define the button's width
                    minimumSize: MaterialStateProperty.all(Size(Get.width * 0.42, 35)), // Adjust the width as needed

                    // Define the button's shape and border radius
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0), // Adjust the border radius as needed
                        side: const BorderSide(width: 2, color: Color(0xff635F54)), // Adjust the border color as needed
                      ),
                    ),

                    // Define the button's background color
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Adjust the background color as needed

                    // Define the text color when the button is pressed
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    'call'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff635F54),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final url = Uri(scheme: 'sms', path: teamList.phone);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  style: ButtonStyle(
                    // Define the button's width
                    minimumSize: MaterialStateProperty.all(Size(Get.width * 0.42, 35)), // Adjust the width as needed

                    // Define the button's shape and border radius
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0), // Adjust the border radius as needed
                        side: const BorderSide(width: 2, color: Color(0xff635F54)), // Adjust the border color as needed
                      ),
                    ),

                    // Define the button's background color
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Adjust the background color as needed

                    // Define the text color when the button is pressed
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    'Message'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff635F54),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
