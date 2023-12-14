import 'package:cnattendance/data/source/network/model/commentlist/Mentioned.dart';

class Reply {
  String avatar;
  int comment_id;
  String created_at;
  int created_by_id;
  String created_by_name;
  String description;
  List<Mentioned> mentioned;
  int reply_id;

  Reply(
      {required this.avatar,
      required this.comment_id,
      required this.created_at,
      required this.created_by_id,
      required this.created_by_name,
      required this.description,
      required this.mentioned,
      required this.reply_id,});

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      avatar: json['avatar'],
      comment_id: json['comment_id'],
      created_at: json['created_at'],
      created_by_id: json['created_by_id'],
      created_by_name: json['created_by_name'],
      description: json['description'],
      mentioned: (json['mentioned'] as List)
          .map((i) => Mentioned.fromJson(i))
          .toList(),
      reply_id: json['reply_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['comment_id'] = comment_id;
    data['created_at'] = created_at;
    data['created_by_id'] = created_by_id;
    data['created_by_name'] = created_by_name;
    data['description'] = description;
    data['reply_id'] = reply_id;
    data['mentioned'] = mentioned.map((v) => v.toJson()).toList();
    return data;
  }
}
