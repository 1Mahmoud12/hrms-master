import 'package:cnattendance/model/member.dart';
import 'package:cnattendance/screen/projectscreen/commentscreen/commentscreencontroller.dart';
import 'package:cnattendance/screen/projectscreen/commentscreen/widget/commentlist.dart';
import 'package:cnattendance/screen/projectscreen/commentscreen/widget/mentionbottomsheet.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_textfield_autocomplete/flutter_textfield_autocomplete.dart';

import 'package:get/get.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TextFieldAutoCompleteState<String>> _textFieldAutoCompleteKey =
        GlobalKey();
    final model = Get.put(CommentScreenController());
    final List<Member> value = Get.arguments['members'];
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          foregroundColor: const Color(0xff635F54),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Comments'.tr),
        ),
        body: GestureDetector(
          onVerticalDragDown: (details) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 10,
                    right: 10,
                    bottom: 100,
                    child: Column(
                      children: [
                        const Expanded(child: CommentList()),
                        GestureDetector(
                          onTap: () {
                            model.getComments();
                          },
                          child: Obx(
                            () => model.commentList.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Load_More_Comments'.tr,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ),),
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 90,
                  child: Divider(
                    color: Colors.white54,
                    endIndent: 10,
                    indent: 10,
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: const Color(0xfffff8f8),
                      height: 100,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: model.mentionList.length,
                                        itemBuilder: (context, index) {
                                          final member =
                                              model.mentionList[index];
                                          return Card(
                                            color: Colors.white54,
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      member.name,
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xff635F54,),),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        model.removeMember(
                                                            member,);
                                                      },
                                                      child: const Icon(
                                                        Icons.close,
                                                        size: 15,
                                                        color:
                                                            Color(0xff635F54),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.bottomSheet(MentionBottomSheet(value),
                                          isDismissible: true,
                                          enableDrag: true,
                                          isScrollControlled: false,
                                          ignoreSafeArea: true,);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0,),
                                      child: Icon(
                                        Icons.add,
                                        color: Color(0xff635F54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Obx(
                                      () => Image.network(
                                        model.user.value.avatar,
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                      ),
                                    ),),
                                Expanded(
                                    child: TextFormField(
                                  focusNode: model.focusNode,
                                  controller: model.commentController,
                                  keyboardType: TextInputType.multiline,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 15,),
                                  validator: (value) {
                                    return null;
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      hintText: 'Write_your_Comment'.tr,
                                      hintStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 15,),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10.0),),
                                      contentPadding:
                                          const EdgeInsets.symmetric(horizontal: 10),
                                      labelStyle: const TextStyle(
                                        color: Color(0xff635F54),
                                      ),
                                      filled: true,
                                      fillColor: Colors.transparent,),
                                ),),
                                GestureDetector(
                                  onTap: () {
                                    model.saveComments();
                                  },
                                  child: const Icon(
                                    Icons.send,
                                    color: Color(0xff635F54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
