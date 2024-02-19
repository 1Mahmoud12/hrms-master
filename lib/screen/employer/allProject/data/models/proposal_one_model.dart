import 'dart:convert';

import 'package:flutter/material.dart';

class ProposalOneModel {
  bool? success;
  Data? data;

  ProposalOneModel({this.success, this.data});

  ProposalOneModel.fromJson(Map<String, dynamic> json) {
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
  FormRequest? formRequest;
  List<Products>? products;
  List<int>? allprdids;
  Report? report;

  Data({this.formRequest, this.products, this.allprdids, this.report});

  Data.fromJson(Map<String, dynamic> json) {
    formRequest = json['formrequest'] != null ? FormRequest.fromJson(json['formrequest']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    allprdids = json['allprdids'].cast<int>();
    report = json['report'] != null ? Report.fromJson(json['report']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (formRequest != null) {
      data['formrequest'] = formRequest!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['allprdids'] = allprdids;
    if (report != null) {
      data['report'] = report!.toJson();
    }
    return data;
  }
}

class FormRequest {
  int? id;
  int? propasalId;
  int? userId;
  String? formCustomfields;
  FormData? formData;
  String? totalCost;
  String? createdAt;
  String? updatedAt;
  Proposal? propasal;
  User? user;

  FormRequest({
    this.id,
    this.propasalId,
    this.userId,
    this.formCustomfields,
    this.formData,
    this.totalCost,
    this.createdAt,
    this.updatedAt,
    this.propasal,
    this.user,
  });

  FormRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propasalId = json['propasal_id'];
    userId = json['user_id'];
    formCustomfields = json['form_customfields'];
    formData = FormData.fromJson(jsonDecode(json['form_data']));
    totalCost = json['total_cost'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    propasal = json['propasal'] != null ? Proposal.fromJson(json['propasal']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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

class User {
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

  User({
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

  User.fromJson(Map<String, dynamic> json) {
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

class Products {
  int? id;
  String? name;
  String? sku;
  int? salePrice;
  int? purchasePrice;
  int? quantity;
  String? taxId;
  int? categoryId;
  int? unitId;
  String? type;
  String? description;
  String? proImage;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  Products({
    this.id,
    this.name,
    this.sku,
    this.salePrice,
    this.purchasePrice,
    this.quantity,
    this.taxId,
    this.categoryId,
    this.unitId,
    this.type,
    this.description,
    this.proImage,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sku = json['sku'];
    salePrice = json['sale_price'];
    purchasePrice = json['purchase_price'];
    quantity = json['quantity'];
    taxId = json['tax_id'];
    categoryId = json['category_id'];
    unitId = json['unit_id'];
    type = json['type'];
    description = json['description'];
    proImage = json['pro_image'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sku'] = sku;
    data['sale_price'] = salePrice;
    data['purchase_price'] = purchasePrice;
    data['quantity'] = quantity;
    data['tax_id'] = taxId;
    data['category_id'] = categoryId;
    data['unit_id'] = unitId;
    data['type'] = type;
    data['description'] = description;
    data['pro_image'] = proImage;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Report {
  int? id;
  int? formRequestId;
  String? reportTechnical;
  String? reportEngineer;
  String? costs;
  String? submit;
  String? createdAt;
  String? updatedAt;

  Report({
    this.id,
    this.formRequestId,
    this.reportTechnical,
    this.reportEngineer,
    this.costs,
    this.submit,
    this.createdAt,
    this.updatedAt,
  });

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formRequestId = json['form_request_id'];
    reportTechnical = json['report_technical'];
    reportEngineer = json['report_engineer'];
    costs = json['costs'];
    submit = json['submit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['form_request_id'] = formRequestId;
    data['report_technical'] = reportTechnical;
    data['report_engineer'] = reportEngineer;
    data['costs'] = costs;
    data['submit'] = submit;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
