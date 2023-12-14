import 'package:cnattendance/data/source/network/model/commentsaveresponse/MentionedX.dart';

class Reply {
  String avatar;
  int comment_id;
  String created_at;
  String created_by_id;
  String created_by_name;
  String description;
  List<MentionedX> mentioned;
  int reply_id;
  String username;

  Reply(
      {required this.avatar,
      required this.comment_id,
      required this.created_at,
      required this.created_by_id,
      required this.created_by_name,
      required this.description,
      required this.mentioned,
      required this.reply_id,
      required this.username,});

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      avatar: json['avatar'],
      comment_id: json['comment_id'],
      created_at: json['created_at'],
      created_by_id: json['created_by_id'],
      created_by_name: json['created_by_name'],
      description: json['description'],
      mentioned: (json['mentioned'] as List)
          .map((i) => MentionedX.fromJson(i))
          .toList(),
      reply_id: json['reply_id'],
      username: json['username'],
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
    data['username'] = username;
    data['mentioned'] = mentioned.map((v) => v.toJson()).toList();
    return data;
  }
}
