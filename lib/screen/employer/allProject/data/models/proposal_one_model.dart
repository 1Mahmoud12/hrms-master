import 'dart:convert';

class ProposalOneModel {
  bool? success;
  Data? data;

  ProposalOneModel({this.success, this.data});

  ProposalOneModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Formrequest? formrequest;
  List<Products>? products;
  List<int>? allprdids;
  Report? report;

  Data({this.formrequest, this.products, this.allprdids, this.report});

  Data.fromJson(Map<String, dynamic> json) {
    formrequest = json['formrequest'] != null ? Formrequest.fromJson(json['formrequest']) : null;
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
    final Map<String, dynamic> data = {};
    if (formrequest != null) {
      data['formrequest'] = formrequest!.toJson();
    }
    if (products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['allprdids'] = this.allprdids;
    if (report != null) {
      data['report'] = report!.toJson();
    }
    return data;
  }
}

class FormDataModel {
  PassengersNumber? passengersNumber;
  PassengersNumber? floorsNumber;
  PassengersNumber? machineLocation;
  PassengersNumber? depthField;
  PassengersNumber? widthField;
  PassengersNumber? holeDepth;
  PassengersNumber? areaLfloor;
  AllDoors? allDoors;
  AllDoors? allColumns;
  AllDoors? allMachines;
  AllDoors? allControls;

  FormDataModel(
      {this.passengersNumber,
      this.floorsNumber,
      this.machineLocation,
      this.depthField,
      this.widthField,
      this.holeDepth,
      this.areaLfloor,
      this.allDoors,
      this.allColumns,
      this.allMachines,
      this.allControls});

  FormDataModel.fromJson(Map<String, dynamic> json) {
    passengersNumber = json['passengers_number'] != null ? PassengersNumber.fromJson(json['passengers_number']) : null;
    floorsNumber = json['floors_number'] != null ? PassengersNumber.fromJson(json['floors_number']) : null;
    machineLocation = json['Machine_location'] != null ? PassengersNumber.fromJson(json['Machine_location']) : null;
    depthField = json['Depth_field'] != null ? PassengersNumber.fromJson(json['Depth_field']) : null;
    widthField = json['Width_field'] != null ? PassengersNumber.fromJson(json['Width_field']) : null;
    holeDepth = json['Hole_depth'] != null ? PassengersNumber.fromJson(json['Hole_depth']) : null;
    areaLfloor = json['area_lfloor'] != null ? PassengersNumber.fromJson(json['area_lfloor']) : null;
    allDoors = json['all_doors'] != null ? AllDoors.fromJson(json['all_doors']) : null;
    allColumns = json['all_columns'] != null ? AllDoors.fromJson(json['all_columns']) : null;
    allMachines = json['all_machines'] != null ? AllDoors.fromJson(json['all_machines']) : null;
    allControls = json['all_controls'] != null ? AllDoors.fromJson(json['all_controls']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (passengersNumber != null) {
      data['passengers_number'] = passengersNumber!.toJson();
    }
    if (floorsNumber != null) {
      data['floors_number'] = floorsNumber!.toJson();
    }
    if (machineLocation != null) {
      data['Machine_location'] = machineLocation!.toJson();
    }
    if (depthField != null) {
      data['Depth_field'] = depthField!.toJson();
    }
    if (widthField != null) {
      data['Width_field'] = widthField!.toJson();
    }
    if (holeDepth != null) {
      data['Hole_depth'] = holeDepth!.toJson();
    }
    if (areaLfloor != null) {
      data['area_lfloor'] = areaLfloor!.toJson();
    }
    if (allDoors != null) {
      data['all_doors'] = allDoors!.toJson();
    }
    if (allColumns != null) {
      data['all_columns'] = allColumns!.toJson();
    }
    if (allMachines != null) {
      data['all_machines'] = allMachines!.toJson();
    }
    if (allControls != null) {
      data['all_controls'] = allControls!.toJson();
    }
    return data;
  }
}

class PassengersNumber {
  String? label;
  String? module;
  String? value;

  PassengersNumber({this.label, this.module, this.value});

  PassengersNumber.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    module = json['module'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['label'] = label;
    data['module'] = module;
    data['value'] = value;
    return data;
  }
}

class AllDoors {
  String? label;
  String? module;
  List<Value>? value;

  AllDoors({this.label, this.module, this.value});

  AllDoors.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    module = json['module'];
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add(Value.fromJson(jsonDecode('$v')));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['label'] = label;
    data['module'] = module;
    if (value != null) {
      data['value'] = value!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Value {
  String? id;
  String? name;

  Value({this.id, this.name});

  Value.fromJson(Map<String, dynamic> json) {
    id = '${json['id']}';
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Formrequest {
  int? id;
  int? propasalId;
  int? userId;
  List<String>? formCustomfields;
  FormDataModel? formData;
  String? totalCost;
  String? createdAt;
  String? updatedAt;
  int? status;
  Propasal? propasal;
  User? user;

  Formrequest({
    this.id,
    this.propasalId,
    this.userId,
    this.formCustomfields,
    this.formData,
    this.totalCost,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.propasal,
    this.user,
  });

  Formrequest.fromJson(Map<String, dynamic> json) {
    print('object form_data ======>${jsonDecode(json['form_data'])}\n');
    id = json['id'];
    propasalId = json['propasal_id'];
    userId = json['user_id'];
    if (json['form_customfields'] != null) {
      formCustomfields = [];
      jsonDecode(json['form_customfields']).forEach((element) {
        final String cleanedElement = element.replaceAll('{', '').replaceAll('}', '');
        formCustomfields!.add(cleanedElement);
      });
    }

    formData = FormDataModel.fromJson(jsonDecode(json['form_data']));
    totalCost = json['total_cost'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    propasal = json['propasal'] != null ? Propasal.fromJson(json['propasal']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['propasal_id'] = propasalId;
    data['user_id'] = userId;
    data['form_customfields'] = formCustomfields;
    data['form_data'] = formData;
    data['total_cost'] = totalCost;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    if (propasal != null) {
      data['propasal'] = propasal!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Propasal {
  int? id;
  String? name;
  String? nameAr;
  String? descriptionAr;
  String? descriptionEn;
  String? img;
  String? numberOfSteps;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Propasal({
    this.id,
    this.name,
    this.nameAr,
    this.descriptionAr,
    this.descriptionEn,
    this.img,
    this.numberOfSteps,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  Propasal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    img = json['img'];
    numberOfSteps = json['number_of_steps'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['name_ar'] = nameAr;
    data['description_ar'] = descriptionAr;
    data['description_en'] = descriptionEn;
    data['img'] = img;
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
  int? branchId;
  int? departmentId;
  int? postId;
  String? supervisorId;
  int? officeTimeId;
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
  String? clientId;
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
    this.clientId,
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
    clientId = json['client_id'];
    userProfileImg = json['user_profile_img'];
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
  int? vectorFloor;
  String? country;
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
    this.vectorFloor,
    this.country,
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
    vectorFloor = json['vector_floor'];
    country = json['country'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
    data['vector_floor'] = vectorFloor;
    data['country'] = country;
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
    final Map<String, dynamic> data = {};
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
