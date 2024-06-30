import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordDataSource {
  Future<void> resetPassword(String email) async {
    const String url = 'https://rak.bytes-sa.com/api/forget-password';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      print('Password reset request sent successfully');
    } else {
      print('Failed to send password reset request: ${response.statusCode}');
    }
  }
}
