class Participator {
  Participator({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.onlineStatus,
    required this.avatar,
    required this.post,
  });

  factory Participator.fromJson(dynamic json) {
    return Participator(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      onlineStatus: json['online_status'] ?? '',
      avatar: json['avatar'] ?? '',
      post: json['post'] ?? '',
    );
  }

  String id;
  String name;
  String email;
  String phone;
  String onlineStatus;
  String avatar;
  String post;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['online_status'] = onlineStatus;
    map['avatar'] = avatar;
    map['post'] = post;
    return map;
  }
}
