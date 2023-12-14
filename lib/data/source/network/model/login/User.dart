import 'package:flutter/material.dart';

class User {
  User({
    required this.id,
    required this.name,
    required this.roleId,
    required this.email,
    required this.username,
    required this.avatar,
  });

  factory User.fromJson(dynamic json) {
    debugPrint('User $json');

    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      roleId: '${json['role_id']}',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  final int id;
  final String name;
  final String roleId;
  final String email;
  final String username;
  final String avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['role_id'] = roleId;
    map['email'] = email;
    map['username'] = username;
    map['avatar'] = avatar;
    return map;
  }
}
