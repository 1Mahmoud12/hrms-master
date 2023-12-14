import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/model/team.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamSheetCard extends StatelessWidget {
  final Team teamList;

  const TeamSheetCard({super.key, required this.teamList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).w,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration:
                BoxDecoration(shape: BoxShape.circle, border: Border.all(color: teamList.active == '1' ? Colors.green : Colors.grey, width: 2)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                teamList.avatar,
                width: 40.w,
                height: 40.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/dummy_avatar.png',
                    width: 40.w,
                    height: 40.h,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          5.ESW(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                teamList.name,
                style: Styles.style16700,
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  teamList.post,
                  style: Styles.style14500,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () async {
              final url = Uri(scheme: 'sms', path: teamList.phone);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            icon: SvgPicture.asset(
              Assets.messageTeamSheet,
            ),
          ),
          10.ESW(),
          IconButton(
            onPressed: () async {
              final url = Uri.parse('tel:${teamList.phone}');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            icon: SvgPicture.asset(
              Assets.call,
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
