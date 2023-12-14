import 'package:flutter/material.dart';

import 'User.dart';

class Login {
  const Login({
    required this.user,
    required this.tokens,
  });

  factory Login.fromJson(dynamic json) {
    debugPrint('Json $json');

    return Login(user: User.fromJson(json['user']), tokens: json['tokens'].toString());
  }

  final User user;
  final String tokens;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user.toJson();
    map['tokens'] = tokens;
    return map;
  }
}
