import 'package:flutter/material.dart';

class Team with ChangeNotifier {
  int id;
  String name;
  String post;
  String avatar;
  String phone;
  String email;
  String active;

  Team(
      {required this.id,
      required this.name,
      required this.post,
      required this.avatar,
      required this.phone,
      required this.email,
      required this.active,});
}
