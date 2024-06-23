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

  Data({this.malfunction, this.report});

  Data.fromJson(Map<String, dynamic> json) {
    malfunction = json['malfunction'] != null ? Malfunction.fromJson(json['malfunction']) : null;
    report = json['report'] != null ? Report.fromJson(json['report']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (malfunction != null) {
      data['malfunction'] = malfunction!.toJson();
    }
    if (report != null) {
      data['report'] = report!.toJson();
    }
    return data;
  }
}

class Malfunction {
  int? id;
  String? name;
  String? description;
  String? img;
  String? location;
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
  Technical? technical;

  Report({this.technical});

  Report.fromJson(Map<String, dynamic> json) {
    technical = json['technical'] != null ? Technical.fromJson(json['technical']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (technical != null) {
      data['technical'] = technical!.toJson();
    }
    return data;
  }
}

class Technical {
  String? name;

  Technical({this.name});

  Technical.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
