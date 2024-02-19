import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void loadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/animation/HandLoadinAnimation.json',
        ),
      ],
    ),
  );
}
