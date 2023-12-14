import 'AttendanceStatus.dart';

class AttendanceStatusResponse {
  AttendanceStatusResponse({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory AttendanceStatusResponse.fromJson(dynamic json) {
    return AttendanceStatusResponse(
      status: json['status'],
      message: json['message'],
      statusCode: json['status_code'],
      data: AttendanceStatus.fromJson(json['data']),
    );
  }

  bool status;
  String message;
  int statusCode;
  AttendanceStatus data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    map['data'] = data.toJson();
    return map;
  }
}
