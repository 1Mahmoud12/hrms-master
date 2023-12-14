import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  final String value;
  final String title;

  const CardTitle(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.style14500,
          ),
          Padding(
            padding: const EdgeInsets.only(),
            child: Text(
              value,
              style: Styles.style14500.copyWith(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
