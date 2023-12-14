import 'dart:math';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void unFocusKeyboard() => FocusScope.of(this).unfocus();
  dynamic get getArguments => ModalRoute.of(this)?.settings.arguments;
  TextTheme get appTextTheme => Theme.of(this).textTheme;
  Color get primaryColor => Theme.of(this).primaryColor;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  Size get screenSize => MediaQuery.of(this).size;
  double get minScreenSize => min(
        MediaQuery.of(this).size.height,
        MediaQuery.of(this).size.width,
      );
  double get maxScreenSize => max(
        MediaQuery.of(this).size.height,
        MediaQuery.of(this).size.width,
      );
}

extension PaddingList on List<Widget> {
  List<Widget> paddingDirectional({
    double? top,
    double? bottom,
    double? start,
    double? end,
  }) {
    return map(
      (e) => Padding(
        padding: EdgeInsetsDirectional.only(
          top: top ?? 0,
          bottom: bottom ?? 0,
          start: start ?? 0,
          end: end ?? 0,
        ),
        child: e,
      ),
    ).toList();
  }
}
