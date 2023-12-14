import 'dart:convert';
import 'dart:developer';

import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/data/source/network/model/commentlist/commentlistresponse.dart';
import 'package:cnattendance/data/source/network/model/commentsaveresponse/commentsaveresponse.dart';
import 'package:cnattendance/data/source/network/model/login/User.dart';
import 'package:cnattendance/model/comment.dart';
import 'package:cnattendance/model/member.dart';
import 'package:cnattendance/model/mention.dart';
import 'package:cnattendance/model/reply.dart';
import 'package:cnattendance/model/sendcomment.dart';
import 'package:cnattendance/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mentions/flutter_mentions.dart' as fm;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommentScreenController extends GetxController {
  TextEditingController commentEdit = TextEditingController();
  final scrollController = ScrollController();
  Preferences preferences = Preferences();
  FocusNode focusNode = FocusNode();

  Rx<User> user = User(id: 0, name: '', roleId: '', email: '', username: '', avatar: '').obs;

  SendComment sendComment = SendComment();

  String taskId = '0';
  TextEditingController commentController = TextEditingController();
  RxInt commentId = 0.obs;

  int page = 1;
  static const int PER_PAGE = 10000;

  final mentionList = <Member>[].obs;

  void onReplyClicked(String replyId) {
    if (commentId.value.toString() != replyId) {
      commentId.value = int.parse(replyId);
      focusNode.requestFocus();
    } else {
      commentId.value = 0;
      focusNode.unfocus();
    }
  }

  RxList<Comment> commentList = <Comment>[].obs;

  GlobalKey<fm.FlutterMentionsState> commentKey = GlobalKey<fm.FlutterMentionsState>();

  @override
  Future<void> onInit() async {
    super.onInit();
    taskId = Get.arguments['taskId'];
    user.value = await preferences.getUser();
    getComments();
  }

  Future<void> getComments([double position = 0]) async {
    final uri = Uri.parse('${Constant.GET_COMMENT_URL}?per_page=$PER_PAGE&page=$page&task_id=${Get.arguments['taskId']}');

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    log(uri.toString());

    EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
    final response = await http.get(
      uri,
      headers: headers,
    );
    EasyLoading.dismiss();
    log(response.body);

    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      final value = CommentListResponse.fromJson(responseData);

      final comments = <Comment>[];
      for (final comment in value.data) {
        final commentMentions = <Mention>[];
        for (final mention in comment.mentioned) {
          commentMentions.add(Mention(mention.id, mention.name));
        }

        final replies = <Reply>[];
        for (final reply in comment.replies) {
          final mentions = <Mention>[];
          for (final mention in reply.mentioned) {
            mentions.add(Mention(mention.id, mention.name));
          }
          replies.add(
            Reply(
              reply.reply_id,
              reply.comment_id,
              reply.description,
              reply.created_by_name,
              reply.created_by_id.toString(),
              reply.avatar,
              reply.created_at,
              mentions,
            ),
          );
        }

        comments.add(
          Comment(
            comment.id,
            comment.description,
            comment.created_by_name,
            comment.created_by_id.toString(),
            comment.avatar,
            comment.created_at,
            commentMentions,
            replies,
          ),
        );
      }
      if (page == 1) {
        commentList.value = comments;
      } else {
        commentList.addAll(comments);
      }
      if (comments.isNotEmpty) {
        page++;
      }

      scrollController.jumpTo(position);
    } else {
      final errorMessage = responseData['message'];
      debugPrint(errorMessage);
      throw errorMessage;
    }
  }

  Future<void> saveComments() async {
    if (commentController.text.isEmpty) {
      return;
    }
    final uri = Uri.parse(Constant.SAVE_COMMENT_URL);

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    log(uri.toString());
    final body = {
      'task_id': taskId,
      'comment_id': commentId.value.toString() == '0' ? '' : commentId.value,
      'description': commentController.text,
    };

    for (int i = 0; i < mentionList.length; i++) {
      body.addEntries({'mentioned[$i]': mentionList[i].id}.entries);
    }
    commentController.clear();
    commentId.value = 0;
    mentionList.clear();
    final response = await http.post(uri, headers: headers, body: body);

    log(response.body);

    final responseData = json.decode(response.body);
    final comment = commentsaveresponse.fromJson(responseData);

    if (comment.status_code == 200) {
      commentController.clear();
      commentId.value = 0;
      mentionList.clear();

      if (hasComment(comment.data.id)) {
        for (final oldComment in commentList) {
          if (oldComment.id == comment.data.id) {
            final commentMentions = <Mention>[];
            for (final mention in comment.data.mentioned) {
              commentMentions.add(Mention(mention.id, mention.name));
            }
            final replies = <Reply>[];
            for (final reply in comment.data.replies) {
              final mentions = <Mention>[];
              for (final mention in reply.mentioned) {
                mentions.add(Mention(mention.id, mention.name));
              }
              replies.add(
                Reply(
                  reply.reply_id,
                  reply.comment_id,
                  reply.description,
                  reply.created_by_name,
                  reply.created_by_id,
                  reply.avatar,
                  reply.created_at,
                  mentions,
                ),
              );
            }
            final newComment = Comment(
              comment.data.id,
              comment.data.description,
              comment.data.created_by_name,
              comment.data.created_by_id,
              comment.data.avatar,
              comment.data.created_at,
              commentMentions,
              replies,
            );

            final index = commentList.indexWhere((element) => element.id == newComment.id);
            commentList[index] = newComment;
          }
        }
      } else {
        final commentMentions = <Mention>[];
        for (final mention in comment.data.mentioned) {
          commentMentions.add(Mention(mention.id, mention.name));
        }
        final replies = <Reply>[];
        for (final reply in comment.data.replies) {
          final mentions = <Mention>[];
          for (final mention in reply.mentioned) {
            mentions.add(Mention(mention.id, mention.name));
          }
          replies.add(
            Reply(
              reply.reply_id,
              reply.comment_id,
              reply.description,
              reply.created_by_name,
              reply.created_by_id,
              reply.avatar,
              reply.created_at,
              mentions,
            ),
          );
        }
        commentList.insert(
          0,
          Comment(
            comment.data.id,
            comment.data.description,
            comment.data.created_by_name,
            comment.data.created_by_id,
            comment.data.avatar,
            comment.data.created_at,
            commentMentions,
            replies,
          ),
        );
      }

      commentList.refresh();
    } else {
      final errorMessage = responseData['message'];
      debugPrint(errorMessage);
      throw errorMessage;
    }
  }

  bool hasComment(int id) {
    for (final oldComment in commentList) {
      if (oldComment.id == id) {
        return true;
      }
    }
    return false;
  }

  Future<void> deleteComment(String id) async {
    final uri = Uri.parse('${Constant.DELETE_COMMENT_URL}/$id');

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
    final response = await http.get(uri, headers: headers);
    log(response.body);

    final responseData = json.decode(response.body);

    EasyLoading.dismiss();

    if (response.statusCode == 200) {
      page = 1;
      getComments();
    } else {
      final errorMessage = responseData['message'];
      debugPrint(errorMessage);
      throw errorMessage;
    }
  }

  Future<void> deleteReply(String id) async {
    final uri = Uri.parse('${Constant.DELETE_REPLY_URL}/$id');

    final Preferences preferences = Preferences();
    final String token = await preferences.getToken();

    final Map<String, String> headers = {
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
    final response = await http.get(uri, headers: headers);
    log(response.body);

    final responseData = json.decode(response.body);

    EasyLoading.dismiss();

    if (response.statusCode == 200) {
      page = 1;
      getComments();
    } else {
      final errorMessage = responseData['message'];
      debugPrint(errorMessage);
      throw errorMessage;
    }
  }

  void removeMember(Member member) {
    mentionList.remove(member);
  }
}
