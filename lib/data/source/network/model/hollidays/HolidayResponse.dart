import 'Holidays.dart';

class HolidayResponse {
  HolidayResponse({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory HolidayResponse.fromJson(dynamic json) {
    return HolidayResponse(
        status: json['status'],
        message: json['message'],
        statusCode: json['status_code'],
        data: List<Holidays>.from(json['data'].map((x) => Holidays.fromJson(x))),);
  }

  bool status;
  String message;
  int statusCode;
  List<Holidays>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    map['data'] = data?.map((v) => v.toJson()).toList();
    return map;
  }
}
