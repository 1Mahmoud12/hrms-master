import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  Future SendChatNotification(messgae, userid) async {
    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();
    final uri = Uri.parse('https://hr.dar-bayat.com/api/users/chat-popup/$userid');

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.post(
        uri,
        headers: headers,
        body: {
          'message': messgae,
        },
      );
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e);
    }
  }
}
