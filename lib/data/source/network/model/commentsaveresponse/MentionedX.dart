class MentionedX {
  String id;
  String name;
  String username;

  MentionedX({required this.id, required this.name, required this.username});

  factory MentionedX.fromJson(Map<String, dynamic> json) {
    return MentionedX(
      id: json['id'],
      name: json['name'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    return data;
  }
}
