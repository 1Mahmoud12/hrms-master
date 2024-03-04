class OneElevatorModel {
  bool? success;
  Data? data;

  OneElevatorModel({this.success, this.data});

  OneElevatorModel.fromJson(Map<String, dynamic> json) {
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
  Elevator? elevator;
  Peridic? peridic;
  List<Reports>? reports;

  Data({this.elevator, this.peridic, this.reports});

  Data.fromJson(Map<String, dynamic> json) {
    elevator = json['elevator'] != null ? Elevator.fromJson(json['elevator']) : null;
    peridic = json['peridic'] != null ? Peridic.fromJson(json['peridic']) : null;
    if (json['reports'] != null) {
      reports = <Reports>[];
      json['reports'].forEach((v) {
        reports!.add(Reports.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (elevator != null) {
      data['elevator'] = elevator!.toJson();
    }
    if (peridic != null) {
      data['peridic'] = peridic!.toJson();
    }
    if (reports != null) {
      data['reports'] = reports!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Elevator {
  int? id;
  String? name;
  int? peridicId;
  String? createdAt;
  String? updatedAt;

  Elevator({
    this.id,
    this.name,
    this.peridicId,
    this.createdAt,
    this.updatedAt,
  });

  Elevator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    peridicId = json['peridic_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['peridic_id'] = peridicId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Peridic {
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

  Peridic({
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

  Peridic.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = {};
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

class Reports {
  int? id;
  int? technicalId;
  int? engineerId;
  int? elevatorId;
  String? description;
  String? createdAt;
  String? updatedAt;

  Reports({
    this.id,
    this.technicalId,
    this.engineerId,
    this.elevatorId,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Reports.fromJson(Map<String, dynamic> json) {
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
