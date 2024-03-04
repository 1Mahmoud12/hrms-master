import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum UtilState {
  success,
  warning,
  error,
  none,
}

class Utils {
  static String nameToday() {
    final DateTime today = DateTime.now();
    final String dayName = DateFormat('EEEE').format(today);

    return dayName;
  }

  static String createNameFile({required String nameFile}) {
    const String removePath = '/data/user/0/com.rakelevators.codgoo/cache/file_picker/';
    return nameFile.replaceAll(removePath, '');
  }

  static Future<void> openFile({required String nameFile}) async {
    await OpenFile.open(nameFile);
  }

  static DateTime convertDateFromBackEnd({required String dateBackEnd}) => DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(dateBackEnd);

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
