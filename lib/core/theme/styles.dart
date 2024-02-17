import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  static TextStyle styleHeader = TextStyle(color: AppColors.textColor, fontSize: 20.sp, fontWeight: FontWeight.w700);
  static TextStyle style18700 = TextStyle(color: AppColors.textColor, fontSize: 18.sp, fontWeight: FontWeight.w700);
  static TextStyle style14500 = TextStyle(color: AppColors.textColor, fontSize: 12.sp, fontWeight: FontWeight.w600);
  static TextStyle style16700 = TextStyle(color: AppColors.textColor, fontSize: 16.sp, fontWeight: FontWeight.w700);
  static TextStyle style14400 = TextStyle(color: AppColors.textColor, fontSize: 15.sp, fontWeight: FontWeight.w500);
  static TextStyle style12400 = TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500);
//static TextStyle style18700 = TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600);
}

// scaleFactor
// responsive font size
// (min , max) fontSize
double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  final double scaleFactor = getScaleFactor(context);
  final double responsiveFontSize = fontSize * scaleFactor;

  final double lowerLimit = fontSize * .8;
  final double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  // var dispatcher = PlatformDispatcher.instance;
  // var physicalWidth = dispatcher.views.first.physicalSize.width;
  // var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  // double width = physicalWidth / devicePixelRatio;

  final double width = MediaQuery.sizeOf(context).width;
  if (width < 600) {
    return width / 550;
  } else if (width < 900) {
    return width / 1000;
  } else {
    return width / 1920;
  }
}
