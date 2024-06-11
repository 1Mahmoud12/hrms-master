class EmergenciesModel {
  bool? success;
  Data? data;

  EmergenciesModel({this.success, this.data});

  EmergenciesModel.fromJson(Map<String, dynamic> json) {
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
  List<Emergencie>? emergencie;

  Data({this.emergencie});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['emergencies'] != null) {
      emergencie = <Emergencie>[];
      json['emergencies'].forEach((v) {
        emergencie!.add(Emergencie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (emergencie != null) {
      data['emergencies'] = emergencie!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Emergencie {
  int? id;
  String? name;
  String? description;
  String? img;
  String? location;
  int? customerId;
  String? createdAt;
  String? updatedAt;

  Emergencie({
    this.id,
    this.name,
    this.location,
    this.customerId,
    this.createdAt,
    this.updatedAt,
  });

  Emergencie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    img = json['img'];
    location = json['location'];

    customerId = json['customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
