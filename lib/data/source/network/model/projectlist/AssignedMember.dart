class AssignedMember {
  String avatar;
  int id;
  String name;

  AssignedMember(
      {required this.avatar,
      required this.id,
      required this.name,});

  factory AssignedMember.fromJson(Map<String, dynamic> json) {
    return AssignedMember(
      avatar: json['avatar'],
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
