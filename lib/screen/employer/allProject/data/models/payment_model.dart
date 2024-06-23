class PaymentsProjectModel {
  bool? status;
  String? message;
  int? statusCode;
  List<ItemPayment>? data;

  PaymentsProjectModel({this.status, this.message, this.statusCode, this.data});

  PaymentsProjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <ItemPayment>[];
      json['data'].forEach((v) {
        data!.add( ItemPayment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['status_code'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemPayment {
  int? id;
  int? projectId;
  String? name;
  String? date;
  int? status;
  String? price;
  String? createdAt;
  String? updatedAt;

  ItemPayment(
      {this.id,
        this.projectId,
        this.name,
        this.date,
        this.status,
        this.price,
        this.createdAt,
        this.updatedAt,});

  ItemPayment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['project_id'];
    name = json['name'];
    date = json['date'];
    status = json['status'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['project_id'] = projectId;
    data['name'] = name;
    data['date'] = date;
    data['status'] = status;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
