import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum UtilState {
  success,
  warning,
  error,
  none,
}

class Utils {
  /// ------------------------------ toast --------------------------------------
  static void showToast({
    required String title,
    Color textColor = Colors.white,
    ToastGravity gravity = ToastGravity.BOTTOM,
    required UtilState state,
  }) {
    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      timeInSecForIosWeb: 5,
      backgroundColor: _toastColor(state),
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  static Color _toastColor(UtilState utilState) {
    Color? color;
    switch (utilState) {
      case UtilState.success:
        color = Colors.green;
        break;
      case UtilState.warning:
        color = Colors.amber;
        break;
      case UtilState.error:
        color = Colors.red;
        break;
      case UtilState.none:
        color = Colors.black;
        break;
    }
    return color;
  }
}
