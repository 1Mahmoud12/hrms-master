// class UserRequests {
//   UserRequests({
//     required this.status,
//     required this.message,
//     required this.statusCode,
//     required this.data,
//   });

//   factory UserRequests.fromJson(dynamic json) {
//     return UserRequests(
//         status: json['status'],
//         message: json['message'],
//         statusCode: json['status_code'],
//         data: List<LeaveTypeDetail>.from(
//             json['data'].map((x) => LeaveTypeDetail.fromJson(x))));
//   }

//   bool status;
//   String message;
//   int statusCode;
//   List<LeaveTypeDetail> data;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['message'] = message;
//     map['status_code'] = statusCode;
//     map['data'] = data.map((v) => v.toJson()).toList();
//     return map;
//   }
// }
