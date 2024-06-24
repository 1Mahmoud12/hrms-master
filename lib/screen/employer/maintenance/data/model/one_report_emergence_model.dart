class OneReportEmergenceModel {
  bool? success;
  Data? data;

  OneReportEmergenceModel({this.success, this.data});

  OneReportEmergenceModel.fromJson(Map<String, dynamic> json) {
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
  Report? report;

  Data({this.report});

  Data.fromJson(Map<String, dynamic> json) {
    report = json['report'] != null ? Report.fromJson(json['report']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (report != null) {
      data['report'] = report!.toJson();
    }
    return data;
  }
}

class Report {
  int? id;
  int? technicalId;
  int? engineerId;
  int? emergencieId;
  String? description;
  String? price;
  String? status;
  String? product;
  String? createdAt;
  String? updatedAt;
  Report({
    this.id,
    this.technicalId,
    this.engineerId,
    this.emergencieId,
    this.price,
    this.status,
    this.product,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    technicalId = json['technical_id'] ?? -1;
    engineerId = json['engineer_id'] ?? -1;
    emergencieId = json['emergency_id'];
    description = json['description'];
    price = json['price'];
    status = json['status'];
    product = json['product'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['technical_id'] = technicalId;
    data['engineer_id'] = engineerId;
    data['emergency_id'] = emergencieId;
    data['description'] = description;
    data['price'] = price;
    data['status'] = status;
    data['product'] = product;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
