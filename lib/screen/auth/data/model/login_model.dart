class LoginModel {
  bool? status;
  String? message;
  int? statusCode;
  UserData? data;

  LoginModel({this.status, this.message, this.statusCode, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['status_code'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  User? user;
  String? tokens;

  UserData({this.user, this.tokens});

  UserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    tokens = json['tokens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['tokens'] = tokens;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  int? roleId;
  String? username;
  String? avatar;

  User({
    this.id,
    this.name,
    this.email,
    this.roleId,
    this.username,
    this.avatar,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    roleId = json['role_id'];
    username = json['username'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role_id'] = roleId;
    data['username'] = username;
    data['avatar'] = avatar;
    return data;
  }
}
