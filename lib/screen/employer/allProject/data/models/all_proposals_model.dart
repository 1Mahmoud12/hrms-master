import 'dart:convert';

import 'package:flutter/cupertino.dart';

class AllProposalsModel {
  bool? success;
  Data? data;

  AllProposalsModel({this.success, this.data});

  AllProposalsModel.fromJson(Map<String, dynamic> json) {
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
  List<Requests>? requests;

  Data({this.requests});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['requests'] != null) {
      requests = <Requests>[];
      json['requests'].forEach((v) {
        requests!.add(Requests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (requests != null) {
      data['requests'] = requests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Requests {
  int? id;
  int? propasalId;
  int? userId;
  String? formCustomfields;
  FormData? formData;
  String? totalCost;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;
  Proposal? propasal;
  UserProposal? user;

  Requests({
    this.id,
    this.propasalId,
    this.userId,
    this.formCustomfields,
    this.formData,
    this.totalCost,
    this.createdAt,
    this.updatedAt,
    this.pivot,
    this.propasal,
    this.user,
  });

  Requests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propasalId = json['propasal_id'];
    userId = json['user_id'];
    formCustomfields = json['form_customfields'];
    formData = FormData.fromJson(jsonDecode(json['form_data']));
    totalCost = json['total_cost'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    propasal = json['propasal'] != null ? Proposal.fromJson(json['propasal']) : null;
    user = json['user'] != null ? UserProposal.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['propasal_id'] = propasalId;
    data['user_id'] = userId;
    data['form_customfields'] = formCustomfields;
    data['form_data'] = formData;
    data['total_cost'] = totalCost;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    if (propasal != null) {
      data['propasal'] = propasal!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class FormData {
  String? userNameValue;
  String? userNameLabel;

  String? userAgeValue;
  String? userAgeLabel;

  String? phoneNumberValue;
  String? phoneNumberLabel;

  String? userAddressValue;
  String? userAddressLabel;

  String? userEmailValue;
  String? userEmailLabel;

  String? userGenderValue;
  String? userGenderLabel;

  FormData({
    this.userNameValue,
    this.userNameLabel,
    this.userAgeValue,
    this.userAgeLabel,
    this.phoneNumberValue,
    this.phoneNumberLabel,
    this.userAddressValue,
    this.userAddressLabel,
    this.userEmailValue,
    this.userEmailLabel,
    this.userGenderValue,
    this.userGenderLabel,
  });

  FormData.fromJson(Map<String, dynamic> json) {
    userNameValue = json['user_name']['value'];
    userNameLabel = json['user_name']['label'].replaceAll('_', '').replaceAll('Enter', '').replaceAll('Your', '');
    debugPrint('userName $userNameValue $userNameLabel');

    userAgeValue = json['user_age']['value'];
    userAgeLabel = json['user_age']['label'].replaceAll('_', '').replaceAll('Enter', '').replaceAll('Your', '');
    debugPrint('userAge $userAgeValue $userAgeLabel');

    phoneNumberValue = json['phone_number']['value'];
    phoneNumberLabel = json['phone_number']['label'].replaceAll('_', '').replaceAll('Enter', '').replaceAll('Your', '');
    debugPrint('phoneNumber $phoneNumberValue $phoneNumberLabel');

    userAddressValue = json['user_address']['value'];
    userAddressLabel = json['user_address']['label'].replaceAll('_', '').replaceAll('Enter', '').replaceAll('Your', '');
    debugPrint('userAddress $userAddressValue $userAddressLabel');

    userEmailValue = json['user_email']['value'];
    userEmailLabel = json['user_email']['label'].replaceAll('_', '').replaceAll('Enter', '').replaceAll('Your', '');
    debugPrint('userEmail $userEmailValue $userEmailLabel');

    userGenderValue = json['user_gender']['value'];
    userGenderLabel = json['user_gender']['label'].replaceAll('_', '').replaceAll('Enter', '').replaceAll('Your', '');
    debugPrint('userGender $userGenderValue $userGenderLabel');
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': {
        'value': userNameValue,
        'label': userGenderLabel,
      },
      'user_age': {
        'value': userAgeValue,
        'label': userAgeLabel,
      },
      'phone_number': {
        'value': phoneNumberValue,
        'label': phoneNumberLabel,
      },
      'user_address': {
        'value': userAddressValue,
        'label': userAddressLabel,
      },
      'user_email': {
        'value': userEmailValue,
        'label': userEmailLabel,
      },
      'user_gender': {
        'value': userGenderValue,
        'label': userGenderLabel,
      },
    };
  }
}

class Pivot {
  int? userId;
  int? formRequestId;

  Pivot({this.userId, this.formRequestId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    formRequestId = json['form_request_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['form_request_id'] = formRequestId;
    return data;
  }
}

class Proposal {
  int? id;
  String? name;
  int? numberOfSteps;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Proposal({
    this.id,
    this.name,
    this.numberOfSteps,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  Proposal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    numberOfSteps = json['number_of_steps'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number_of_steps'] = numberOfSteps;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UserProposal {
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
  String? leaveAllocated;
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
  String? branchId;
  String? departmentId;
  String? postId;
  String? supervisorId;
  String? officeTimeId;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? arabicname;
  String? passport;
  String? nationality;
  String? socialstatus;
  String? graduateyear;
  String? experience;
  String? contractstart;
  String? contractend;
  String? accumodation;
  String? workingdate;
  String? userProfileImg;

  UserProposal({
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
    this.userProfileImg,
  });

  UserProposal.fromJson(Map<String, dynamic> json) {
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
    userProfileImg = json['user_profile_img'];
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
    data['user_profile_img'] = userProfileImg;
    return data;
  }
}
