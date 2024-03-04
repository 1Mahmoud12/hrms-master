class AllElevatorsModel {
  bool? success;
  Data? data;

  AllElevatorsModel({this.success, this.data});

  AllElevatorsModel.fromJson(Map<String, dynamic> json) {
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
  List<Elevators>? elevators;

  Data({this.elevators});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['elevators'] != null) {
      elevators = <Elevators>[];
      json['elevators'].forEach((v) {
        elevators!.add(Elevators.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (elevators != null) {
      data['elevators'] = elevators!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Elevators {
  int? id;
  String? name;
  int? peridicId;
  String? createdAt;
  String? updatedAt;

  Elevators({
    this.id,
    this.name,
    this.peridicId,
    this.createdAt,
    this.updatedAt,
  });

  Elevators.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    peridicId = json['peridic_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['peridic_id'] = peridicId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
