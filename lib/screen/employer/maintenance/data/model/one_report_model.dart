class OneReportModel {
  bool? success;
  Data? data;

  OneReportModel({this.success, this.data});

  OneReportModel.fromJson(Map<String, dynamic> json) {
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
  int? elevatorId;
  String? description;
  String? createdAt;
  String? updatedAt;

  Report({
    this.id,
    this.technicalId,
    this.engineerId,
    this.elevatorId,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    technicalId = json['technical_id'] ?? -1;
    engineerId = json['engineer_id'] ?? -1;
    elevatorId = json['elevator_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['technical_id'] = technicalId;
    data['engineer_id'] = engineerId;
    data['elevator_id'] = elevatorId;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
