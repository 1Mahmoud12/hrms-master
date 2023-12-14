import 'package:cnattendance/model/mention.dart';

class Reply {
  int id;
  int commentId;
  String description;
  String name;
  String userId;
  String avatar;
  String createdAt;
  List<Mention> mentions;

  Reply(this.id, this.commentId, this.description, this.name, this.userId,
      this.avatar, this.createdAt, this.mentions,);
}
