import 'Profile.dart';

class ProfileResponse {
  ProfileResponse({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory ProfileResponse.fromJson(dynamic json) {
    return ProfileResponse(
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
