import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/login/Login.dart';
import 'package:cnattendance/data/source/network/model/login/User.dart';
import 'package:flutter/material.dart';

class CustomerProvider with ChangeNotifier {
  String _userName = '';
  String _fullName = '';
  String _email = '';
  String _phone = '';
  String _avatar = '';
  String _roleId = '';
  bool _auth = false;

  String get userName {
    return _userName;
  }

  String get fullName {
    return _fullName;
  }

  String get email {
    return _email;
  }

  String get phone {
    return _phone;
  }

  String get avatar {
    return _avatar;
  }

  String get roleId {
    return _roleId;
  }

  bool get auth {
    return _auth;
  }

  void getUser() async {
    final Preferences preferences = Preferences();
    final User user = await preferences.getUser();
    _userName = await preferences.getUsername();
    _fullName = await preferences.getFullName();
    _phone = await preferences.getEmail();
    _email = await preferences.getEmail();
    _avatar = await preferences.getAvatar();
    _roleId = user.roleId;
    notifyListeners();
  }

  Future<bool> getUserAuth() async {
    final Preferences preferences = Preferences();
    return preferences.getUserAuth();
  }

  void saveUser(Login data) async {
    final Preferences preferences = Preferences();
    preferences.saveUser(data);
    notifyListeners();
  }

  void saveBasicUser(User user) async {
    final Preferences preferences = Preferences();
    preferences.saveBasicUser(user);
    notifyListeners();
  }

  void saveAuth({required bool value}) async {
    final Preferences preferences = Preferences();
    preferences.saveUserAuth(value: value);

    _auth = await preferences.getUserAuth();
    notifyListeners();
  }
}
