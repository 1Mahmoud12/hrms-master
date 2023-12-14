class ChatScreenUser {
  String? status;
  List<Data>? data;

  ChatScreenUser({this.status, this.data});

  ChatScreenUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? username;
  String? emailVerifiedAt;
  String? address;
  String? avatar;
  String? dob;
  String? gender;
  int? phone;
  String? status;
  int? isActive;
  int? onlineStatus;
  int? roleId;
  int? leaveAllocated;
  String? employmentType;
  String? userType;
  String? joiningDate;
  int? workspaceType;
  String? uuid;
  String? fcmToken;
  String? deviceType;
  int? logoutStatus;
  String? remarks;
  int? companyId;
  int? branchId;
  int? departmentId;
  int? postId;
  int? supervisorId;
  int? officeTimeId;
  int? createdBy;
  int? updatedBy;
  String? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data({
    this.id,
    this.name,
    this.email,
    this.username,
    this.emailVerifiedAt,
    this.address,
    this.avatar,
    this.dob,
    this.gender,
    this.phone,
    this.status,
    this.isActive,
    this.onlineStatus,
    this.roleId,
    this.leaveAllocated,
    this.employmentType,
    this.userType,
    this.joiningDate,
    this.workspaceType,
    this.uuid,
    this.fcmToken,
    this.deviceType,
    this.logoutStatus,
    this.remarks,
    this.companyId,
    this.branchId,
    this.departmentId,
    this.postId,
    this.supervisorId,
    this.officeTimeId,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    emailVerifiedAt = json['email_verified_at'];
    address = json['address'];
    avatar = json['avatar'];
    dob = json['dob'];
    gender = json['gender'];
    phone = json['phone'];
    status = json['status'];
    isActive = json['is_active'];
    onlineStatus = json['online_status'];
    roleId = json['role_id'];
    leaveAllocated = json['leave_allocated'];
    employmentType = json['employment_type'];
    userType = json['user_type'];
    joiningDate = json['joining_date'];
    workspaceType = json['workspace_type'];
    uuid = json['uuid'];
    fcmToken = json['fcm_token'];
    deviceType = json['device_type'];
    logoutStatus = json['logout_status'];
    remarks = json['remarks'];
    companyId = json['company_id'];
    branchId = json['branch_id'];
    departmentId = json['department_id'];
    postId = json['post_id'];
    supervisorId = json['supervisor_id'];
    officeTimeId = json['office_time_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['email_verified_at'] = emailVerifiedAt;
    data['address'] = address;
    data['avatar'] = avatar;
    data['dob'] = dob;
    data['gender'] = gender;
    data['phone'] = phone;
    data['status'] = status;
    data['is_active'] = isActive;
    data['online_status'] = onlineStatus;
    data['role_id'] = roleId;
    data['leave_allocated'] = leaveAllocated;
    data['employment_type'] = employmentType;
    data['user_type'] = userType;
    data['joining_date'] = joiningDate;
    data['workspace_type'] = workspaceType;
    data['uuid'] = uuid;
    data['fcm_token'] = fcmToken;
    data['device_type'] = deviceType;
    data['logout_status'] = logoutStatus;
    data['remarks'] = remarks;
    data['company_id'] = companyId;
    data['branch_id'] = branchId;
    data['department_id'] = departmentId;
    data['post_id'] = postId;
    data['supervisor_id'] = supervisorId;
    data['office_time_id'] = officeTimeId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
