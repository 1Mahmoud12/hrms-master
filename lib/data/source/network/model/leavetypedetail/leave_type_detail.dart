class LeaveTypeDetail {
  LeaveTypeDetail({
    required this.id,
    required this.noOfDays,
    required this.leaveTypeId,
    required this.leaveTypeName,
    required this.leaveFrom,
    required this.leaveTo,
    required this.leaveRequestedDate,
    required this.status,
    required this.leaveReason,
    required this.adminRemark,
    required this.earlyExit,
    required this.statusUpdatedBy,
  });

  factory LeaveTypeDetail.fromJson(dynamic json) {
    return LeaveTypeDetail(
      id: json['id'],
      noOfDays: json['no_of_days'] ?? '',
      leaveTypeId: json['leave_type_id'] ?? '',
      leaveTypeName: json['leave_type_name'] ?? '',
      leaveFrom: json['leave_from'] ?? '',
      leaveTo: json['leave_to'] ?? '',
      leaveRequestedDate: json['leave_requested_date'] ?? '',
      status: json['status'] ?? '',
      leaveReason: json['leave_reason'] ?? '',
      adminRemark: json['admin_remark'] ?? '',
      earlyExit: json['early_exit'] ?? false,
      statusUpdatedBy: json['status_updated_by'] ?? '',
    );
  }

  int id;
  String noOfDays;
  String leaveTypeId;
  String leaveTypeName;
  String leaveFrom;
  String leaveTo;
  String leaveRequestedDate;
  String status;
  String leaveReason;
  String adminRemark;
  bool earlyExit;
  String statusUpdatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['no_of_days'] = noOfDays;
    map['leave_type_id'] = leaveTypeId;
    map['leave_type_name'] = leaveTypeName;
    map['leave_from'] = leaveFrom;
    map['leave_to'] = leaveTo;
    map['leave_requested_date'] = leaveRequestedDate;
    map['status'] = status;
    map['leave_reason'] = leaveReason;
    map['admin_remark'] = adminRemark;
    map['early_exit'] = earlyExit;
    map['status_updated_by'] = statusUpdatedBy;
    return map;
  }
}
