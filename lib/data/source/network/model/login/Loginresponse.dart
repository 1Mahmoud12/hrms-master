import 'Login.dart';

class LoginResponse {
  bool status;
  String message;
  int statusCode;
  Login data;

  LoginResponse({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory LoginResponse.fromJson(dynamic json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      statusCode: json['status_code'],
      data: Login.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    map['data'] = data.toJson();
    return map;
  }
}
