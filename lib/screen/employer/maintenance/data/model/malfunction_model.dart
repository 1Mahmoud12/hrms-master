class MalfunctionModel {
  bool? success;
  Data? data;

  MalfunctionModel({this.success, this.data});

  MalfunctionModel.fromJson(Map<String, dynamic> json) {
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
  List<Malfunction>? malfunction;

  Data({this.malfunction});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['malfunctions'] != null) {
      malfunction = <Malfunction>[];
      json['malfunctions'].forEach((v) {
        malfunction!.add(Malfunction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (malfunction != null) {
      data['malfunctions'] = malfunction!.map((v) => v.toJson()).toList();
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
