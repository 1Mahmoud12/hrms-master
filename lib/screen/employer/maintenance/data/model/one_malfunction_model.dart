class OneMalfunctionModel {
  bool? success;
  Data? data;

  OneMalfunctionModel({this.success, this.data});

  OneMalfunctionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Malfunction? malfunction;
  Report? report;
  List<Payment>? payment;

  Data({this.malfunction, this.report});

  Data.fromJson(Map<String, dynamic> json) {
    malfunction = json['malfunction'] != null
        ? Malfunction.fromJson(json['malfunction'])
        : null;
    report = json['report'] != null ? Report.fromJson(json['report']) : null;
    if (json['payment'] != null) {
      payment = <Payment>[];
      json['payment'].forEach((v) {
        payment!.add(Payment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (malfunction != null) {
      data['malfunction'] = malfunction!.toJson();
    }
    if (report != null) {
      data['report'] = report!.toJson();
    }
    if (payment != null) {
      data['payment'] = payment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Malfunction {
  int? id;
  String? name;
  String? description;
  String? location;
  String? img;
  int? customerId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Malfunction({
    this.id,
    this.name,
    this.description,
    this.img,
    this.location,
    this.customerId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Malfunction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    img = json['img'];
    location = json['location'];
    customerId = json['customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['img'] = img;
    data['location'] = location;
    data['customer_id'] = customerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class Report {
  int? id;
  int? technicalId;
  int? engineerId;
  int? malfunctionId;
  String? description;
  String? price;
  String? status;
  String? product;
  String? createdAt;
  String? updatedAt;
  Technical? technical;
  Technical? engineer;

  Report({
    this.id,
    this.technicalId,
    this.engineerId,
    this.malfunctionId,
    this.description,
    this.price,
    this.status,
    this.product,
    this.createdAt,
    this.updatedAt,
    this.technical,
    this.engineer,
  });

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    technicalId = json['technical_id'];
    engineerId = json['engineer_id'];
    malfunctionId = json['malfunction_id'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    product = json['product'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    technical = json['technical'] != null
        ? Technical.fromJson(json['technical'])
        : null;
    engineer =
        json['engineer'] != null ? Technical.fromJson(json['engineer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['technical_id'] = technicalId;
    data['engineer_id'] = engineerId;
    data['malfunction_id'] = malfunctionId;
    data['description'] = description;
    data['price'] = price;
    data['status'] = status;
    data['product'] = product;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (technical != null) {
      data['technical'] = technical!.toJson();
    }
    if (engineer != null) {
      data['engineer'] = engineer!.toJson();
    }
    return data;
  }
}

class Technical {
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
  String? createdBy;
  int? updatedBy;
  String? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? arabicname;
  int? passport;
  String? nationality;
  String? socialstatus;
  String? graduateyear;
  String? experience;
  String? contractstart;
  String? contractend;
  int? accumodation;
  String? workingdate;
  String? clientId;
  String? userProfileImg;

  Technical({
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
    this.arabicname,
    this.passport,
    this.nationality,
    this.socialstatus,
    this.graduateyear,
    this.experience,
    this.contractstart,
    this.contractend,
    this.accumodation,
    this.workingdate,
    this.clientId,
    this.userProfileImg,
  });

  Technical.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    emailVerifiedAt = json['email_verified_at'];
    address = json['address'];
    if (json['avatar'] != null) {
      avatar = json['avatar'].contains('https')
          ? json['avatar']
          : 'https://rak.bytes-sa.com/uploads/projects/cover/${json['avatar']}';
    }
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
    arabicname = json['arabicname'];
    passport = json['passport'];
    nationality = json['nationality'];
    socialstatus = json['socialstatus'];
    graduateyear = json['graduateyear'];
    experience = json['experience'];
    contractstart = json['contractstart'];
    contractend = json['contractend'];
    accumodation = json['accumodation'];
    workingdate = json['workingdate'];
    clientId = json['client_id'];
    if (json['user_profile_img'] != null) {
      userProfileImg = json['user_profile_img'].contains('https')
          ? json['user_profile_img']
          : 'https://rak.bytes-sa.com/uploads/projects/cover/${json['user_profile_img']}';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
    data['arabicname'] = arabicname;
    data['passport'] = passport;
    data['nationality'] = nationality;
    data['socialstatus'] = socialstatus;
    data['graduateyear'] = graduateyear;
    data['experience'] = experience;
    data['contractstart'] = contractstart;
    data['contractend'] = contractend;
    data['accumodation'] = accumodation;
    data['workingdate'] = workingdate;
    data['client_id'] = clientId;
    data['user_profile_img'] = userProfileImg;
    return data;
  }
}

class Payment {
  int? id;
  int? malfunctionId;
  String? img;
  String? createdAt;
  String? updatedAt;

  Payment({
    this.id,
    this.malfunctionId,
    this.img,
    this.createdAt,
    this.updatedAt,
  });

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    malfunctionId = json['malfunction_id'];
    if (json['img'] != null) {
      img = json['img'].contains('https')
          ? json['img']
          : 'https://rak.bytes-sa.com/uploads/projects/cover/${json['img']}';
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['malfunction_id'] = malfunctionId;
    data['img'] = img;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
