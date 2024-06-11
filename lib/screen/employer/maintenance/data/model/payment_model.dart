class PaymentModel {
  bool? success;
  Data? data;

  PaymentModel({this.success, this.data});

  PaymentModel.fromJson(Map<String, dynamic> json) {
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
  List<Payment>? payment;

  Data({this.payment});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['payment'] != null) {
      payment = <Payment>[];
      json['payment'].forEach((v) {
        payment!.add(Payment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (payment != null) {
      data['payment'] = payment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payment {
  int? id;
  int? emergencyId;
  String? img;
  String? createdAt;
  String? updatedAt;

  Payment({
    this.id,
    this.emergencyId,
    this.img,
    this.createdAt,
    this.updatedAt,
  });

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emergencyId = json['emergency_id'];
    img = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['emergency_id'] = emergencyId;
    data['img'] = img;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
