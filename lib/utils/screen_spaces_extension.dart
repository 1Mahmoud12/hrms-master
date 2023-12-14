// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ScreenSpaces<T extends num> on T {
  /// Sized Box with Width
  SizedBox ESW() => SizedBox(width: w);

  /// Sized Box with height
  SizedBox ESH() => SizedBox(height: h);

  /// radius
  double toRad() => r;

  /// font size
  double toFS() => sp;

  /// height
  double toH() => h;

  /// width
  double toW() => w;
}

extension REsponsive on BuildContext {}
