import 'package:cnattendance/model/comment.dart';
import 'package:cnattendance/model/reply.dart';
import 'package:cnattendance/screen/profile/employeedetailscreen.dart';
import 'package:cnattendance/screen/projectscreen/commentscreen/commentscreencontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

class CommentList extends StatelessWidget {
  const CommentList({super.key});

  @override
  Widget build(BuildContext context) {
    final CommentScreenController model = Get.find();

    return Obx(
      () => ListView.builder(
        controller: model.scrollController,
        itemCount: model.commentList.length,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final Comment comment = model.commentList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            elevation: 0,
            color: const Color(0xfffff8f8),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),),),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        comment.avatar,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              comment.name,
                              style: const TextStyle(
                                  color: Color(0xff635F54),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(comment.createdAt,
                                style: const TextStyle(
                                    color: Color(0xff635F54), fontSize: 12,),),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(children: [
                          for (final mention in comment.mentions) ...[
                            WidgetSpan(
                                child: Card(
                              color: Colors.white24,
                              elevation: 0,
                              child: InkWell(
                                onTap: () {
                                  Get.to(const EmployeeDetailScreen(), arguments: {
                                    'employeeId': mention.userId,
                                  },);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3,),
                                  child: Text(
                                    '@${mention.name}',
                                    style: const TextStyle(color: Color(0xff635F54)),
                                  ),
                                ),
                              ),
                            ),),
                          ],
                          WidgetSpan(
                              child: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                parse(comment.description).body!.text,
                                style: const TextStyle(color: Color(0xff635F54)),
                              ),
                            ),
                          ),),
                        ],),),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.centerRight,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (model.user.value.id.toString() ==
                                      comment.userId) GestureDetector(
                                      onTap: () {
                                        model.deleteComment(
                                            comment.id.toString(),);
                                      },
                                      child: Text(
                                        'Delete'.tr,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,),
                                      ),
                                    ) else const SizedBox.shrink(),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  model.onReplyClicked(comment.id.toString());
                                },
                                child: Obx(
                                  () => Text(
                                    model.commentId.value.toString() !=
                                            comment.id.toString()
                                        ? 'Reply'.tr
                                        : 'CancelReply'.tr,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ListView.builder(
                          itemCount: comment.replies.length,
                          physics: const NeverScrollableScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final Reply reply = comment.replies[index];
                            return Card(
                              elevation: 0,
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        reply.avatar,
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Text(
                                                reply.name,
                                                style: const TextStyle(
                                                    color: Color(0xff635F54),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold,),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                reply.createdAt,
                                                style: const TextStyle(
                                                    color: Color(0xff635F54),
                                                    fontSize: 12,),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text.rich(TextSpan(children: [
                                            for (final mention
                                                in reply.mentions) ...[
                                              WidgetSpan(
                                                  child: Card(
                                                color: Colors.white24,
                                                elevation: 0,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 3,),
                                                  child: Text(
                                                    '@${mention.name}',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff635F54),),
                                                  ),
                                                ),
                                              ),),
                                            ],
                                            WidgetSpan(
                                                child: Card(
                                              elevation: 0,
                                              color: Colors.transparent,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: Text(
                                                  reply.description,
                                                  style: const TextStyle(
                                                      color: Color(0xff635F54),),
                                                ),
                                              ),
                                            ),),
                                          ],),),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10,),
                                            alignment: Alignment.centerRight,
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                if (model.user.value.id
                                                            .toString() ==
                                                        reply.userId) GestureDetector(
                                                        onTap: () {
                                                          model.deleteReply(
                                                              reply.id
                                                                  .toString(),);
                                                        },
                                                        child: const Text(
                                                          'Delete',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,),
                                                        ),
                                                      ) else const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
