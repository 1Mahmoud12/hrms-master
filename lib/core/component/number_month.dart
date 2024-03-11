import 'package:intl/intl.dart';

int monthStringToInt(String month) {
  if (month.length >= 3) {
    final monthAbr = month.substring(0, 3).toUpperCase();
    switch (monthAbr) {
      case 'JAN':
        return 01;
      case 'FEB':
        return 02;
      case 'MAR':
        return 03;
      case 'APR':
        return 04;
      case 'MAY':
        return 05;
      case 'JUN':
        return 06;
      case 'JUL':
        return 07;
      case 'AUG':
        return 08;
      case 'SEP':
        return 09;
      case 'OCT':
        return 10;
      case 'NOV':
        return 11;
      case 'DEC':
        return 12;
      default:
        return -1; // Or throw an exception for invalid month
    }
  } else {
    return -1; // Or throw an exception for invalid string length
  }
}

String convertStringDateTime(String dateTime) {
  final List<String> splitDateTime = dateTime.split(' ');
  final int numberMonth = monthStringToInt(splitDateTime[0]);

  return DateFormat('yyyy-MM-dd').parse('${splitDateTime[2]}-$numberMonth-${splitDateTime[1]}T00:00').toString().substring(0, 16);
}
