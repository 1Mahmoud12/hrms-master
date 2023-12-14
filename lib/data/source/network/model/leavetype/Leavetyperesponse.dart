
import 'LeaveType.dart';

class Leavetyperesponse {
  Leavetyperesponse({
    required this.status,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory Leavetyperesponse.fromJson(dynamic json) {
    return Leavetyperesponse(
        status: json['status'],
        message: json['message'],
        statusCode: json['status_code'],
        data: List<LeaveType>.from(
            json['data'].map((x) => LeaveType.fromJson(x)),),);
  }

  bool status;
  String message;
  int statusCode;
  List<LeaveType> data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['status_code'] = statusCode;
    map['data'] = data.map((v) => v.toJson()).toList();
    return map;
  }
}
