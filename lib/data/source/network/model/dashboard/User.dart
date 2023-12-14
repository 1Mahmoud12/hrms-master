class User {
  User({
    required this.id,
    required this.name,
    required this.roleId,
    required this.email,
    required this.username,
    required this.avatar,
    required this.onlineStatus,
  });

  factory User.fromJson(dynamic json) {
    return User(
      id: json['id'],
      name: json['name'],
      roleId: json['role_id'],
      email: json['email'],
      username: json['username'],
      avatar: json['avatar'],
      onlineStatus: json['online_status'] ?? false,
    );
  }

  int id;
  String name;
  String roleId;
  String email;
  String username;
  String avatar;
  bool onlineStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['role_id'] = roleId;
    map['email'] = email;
    map['username'] = username;
    map['avatar'] = avatar;
    map['online_status'] = onlineStatus;
    return map;
  }
}
