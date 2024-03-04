import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardOverView extends StatelessWidget {
  final String type;
  final String value;
  final IconData icon;

  const CardOverView({super.key, required this.type, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 20,
      child: Card(
        shape: ButtonBorder(),
        elevation: 0,
        color: Colors.white12,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
              Text(
                type,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardoverviewSvgs extends StatelessWidget {
  final String type;
  final String value;
  final String svgvalue;

  const CardoverviewSvgs({super.key, required this.type, required this.value, required this.svgvalue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 20,
      child: Card(
        shape: ButtonBorder(),
        elevation: 0,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(svgvalue),
                  10.ESW(),
                  Text(
                    type,
                    style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              8.ESH(),
              Row(
                children: [
                  Text(
                    value,
                    style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w700),
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

class CardoverviewSvgsandcolor extends StatelessWidget {
  final String type;
  final String value;
  final String svgValue;
  final Color bgcolor;

  const CardoverviewSvgsandcolor({super.key, required this.type, required this.value, required this.svgValue, required this.bgcolor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 20,
      child: Card(
        shape: ButtonBorder(),
        elevation: 0,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(svgValue),
                  15.ESW(),
                  Text(
                    type,
                    style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    value,
                    style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w700),
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
