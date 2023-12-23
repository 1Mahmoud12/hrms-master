import 'package:cnattendance/screen/employer/allProject/presentation/manager/commentBLoc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());

  static CommentCubit of(BuildContext context) => BlocProvider.of<CommentCubit>(context);
  final TextEditingController commentController = TextEditingController();
  List<String> comments = [];
  void addComment() {
    comments.add(commentController.text);
    commentController.clear();
    showToast('Add Comment Successfully');
    emit(AddCommentState());
  }

  void deleteComment({required int index}) {
    comments.removeAt(index);

    showToast('Deleted Comment Successfully');
    emit(DeletedCommentState());
  }
}
