import 'package:intl/intl.dart';

class Utils {
  static String nameToday() {
    final DateTime today = DateTime.now();
    final String dayName = DateFormat('EEEE').format(today);

    return dayName;
  }
}
