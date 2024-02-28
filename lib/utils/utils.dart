import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';

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
}
