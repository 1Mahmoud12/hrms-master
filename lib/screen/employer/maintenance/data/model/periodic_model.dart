class PeriodicModel {
  bool? success;
  Data? data;

  PeriodicModel({this.success, this.data});

  PeriodicModel.fromJson(Map<String, dynamic> json) {
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
  List<Periodic>? periodic;

  Data({this.periodic});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['peridics'] != null) {
      periodic = <Periodic>[];
      json['peridics'].forEach((v) {
        periodic!.add(Periodic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (periodic != null) {
      data['peridics'] = periodic!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Periodic {
  int? id;
  String? name;
  String? city;
  String? numelevaters;
  String? model;
  String? numsteps;
  String? maximumload;
  String? installdate;
  String? statuselevator;
  String? availablecompany;
  String? location;
  int? customerId;
  String? createdAt;
  String? updatedAt;

  Periodic({
    this.id,
    this.name,
    this.city,
    this.numelevaters,
    this.model,
    this.numsteps,
    this.maximumload,
    this.installdate,
    this.statuselevator,
    this.availablecompany,
    this.location,
    this.customerId,
    this.createdAt,
    this.updatedAt,
  });

  Periodic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    numelevaters = json['numelevaters'];
    model = json['model'];
    numsteps = json['numsteps'];
    maximumload = json['maximumload'];
    installdate = json['installdate'];
    statuselevator = json['statuselevator'];
    availablecompany = json['availablecompany'];
    location = json['location'];
    customerId = json['customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['city'] = city;
    data['numelevaters'] = numelevaters;
    data['model'] = model;
    data['numsteps'] = numsteps;
    data['maximumload'] = maximumload;
    data['installdate'] = installdate;
    data['statuselevator'] = statuselevator;
    data['availablecompany'] = availablecompany;
    data['location'] = location;
    data['customer_id'] = customerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
