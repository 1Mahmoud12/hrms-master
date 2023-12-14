import 'package:cnattendance/data/source/network/model/login/Login.dart';
import 'package:cnattendance/data/source/network/model/login/User.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences with ChangeNotifier {
  final String userId = 'user_id';
  final String userAvatar = 'user_avatar';
  final String userToken = 'user_token';
  final String userEmail = 'user_email';
  final String userName = 'user_name';
  final String userFullName = 'user_fullname';
  final String roleId = 'role_id';
  final String userAuth = 'user_auth';
  final String appInEnglish = 'eng_date';

  Future<bool> saveUser(Login data) async {
    // Obtain shared preferences.
    final User user = data.user;
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(userToken, data.tokens);
    await prefs.setInt(userId, user.id);
    await prefs.setString(roleId, user.roleId);
    await prefs.setString(userAvatar, user.avatar);
    await prefs.setString(userEmail, user.email);
    await prefs.setString(userName, user.username);
    await prefs.setString(userFullName, user.name);

    notifyListeners();

    return true;
  }

  void saveBasicUser(User user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(userId, user.id);
    await prefs.setString(userAvatar, user.avatar);
    await prefs.setString(userEmail, user.email);
    await prefs.setString(roleId, user.roleId);
    await prefs.setString(userName, user.username);
    await prefs.setString(userFullName, user.name);
    await prefs.setString(userFullName, user.name);

    notifyListeners();
  }

  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(userId, 0);
    await prefs.setString(userToken, '');
    await prefs.setString(userAvatar, '');
    await prefs.setString(userEmail, '');
    await prefs.setString(roleId, '');
    await prefs.setString(userName, '');
    await prefs.setString(userFullName, '');
    await prefs.setBool(userAuth, false);
    await prefs.setBool(appInEnglish, true);

    notifyListeners();
  }

  void saveUserAuth({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(userAuth, value);
  }

  void saveAppEng({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(appInEnglish, value);
  }

  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    return User(
      id: prefs.getInt(userId) ?? 0,
      name: prefs.getString(userFullName) ?? '',
      roleId: prefs.getString(roleId) ?? '',
      email: prefs.getString(userEmail) ?? '',
      username: prefs.getString(userName) ?? '',
      avatar: prefs.getString(userAvatar) ?? '',
    );
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(userToken) ?? '';
  }

  // Future<String> getUserid() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   print(prefs.getString(USER_ID));
  //   return prefs.getString(USER_ID) ?? "";
  // }

  Future<bool> getUserAuth() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(userAuth) ?? false;
  }

  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userName) ?? '';
  }

  Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmail) ?? '';
  }

  Future<String> getAvatar() async {
    final prefs = await SharedPreferences.getInstance();

    // print('----------------------------');
    // print(this.getToken());
    // print(prefs.getString(USER_AVATAR));

    return prefs.getString(userAvatar) ?? '';
  }

  Future<String> getFullName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userFullName) ?? '';
  }

  Future<bool> getEnglishDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(appInEnglish) ?? true;
  }
}
