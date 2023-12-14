import 'Profile.dart';

class Profileresponse {
  Profileresponse({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory Profileresponse.fromJson(dynamic json) {
    return Profileresponse(
        status: json['status'],
        message: json['message'],
        statusCode: json['status_code'],
        data: Profile.fromJson(json['data'] ?? []),
    );
  }

  bool status;
  String message;
  int statusCode;
  Profile data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    map['data'] = data.toJson();
    return map;
  }
}
