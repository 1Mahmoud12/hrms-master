import 'dart:io';

import 'package:cnattendance/screen/employer/allProject/data/dataSource/date_attachment_data_source.dart';
import 'package:cnattendance/screen/employer/allProject/data/dataSource/status_data_source.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/add_attachments_params.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/change_date_params.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/change_status_params.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/overViewProjectBloc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverViewProjectCubit extends Cubit<OverViewState> {
  OverViewProjectCubit() : super(OverViewInitial());

  static OverViewProjectCubit of(BuildContext context) => BlocProvider.of<OverViewProjectCubit>(context);

  String status = '';
  DateTime dueDate = DateTime(2023, 12, 14);

  void changeStatus({required String newStatus, required String projectId}) async {
    status = newStatus;
    emit(ChangeLoadingStatusState());
    await StatusDataSource.postUpdateStatus(
        changeStatusParams: ChangeStatusParams(projectId: projectId, status: newStatus.replaceAll(' ', '_').toLowerCase()));
    emit(ChangeStatusState());
    print('object=== $status');
  }

  void changeStatusOverView() {
    emit(ChangeStatusState());
  }

  void changeDate({required String newDate, required String projectId}) {
    emit(ChangeDateTimeLoadingState());
    // dueDate = newDate;
    DateAttachmentDataSource.postUpdateDeadline(changeDateParams: ChangeDateParams(projectId: projectId, deadline: newDate)).then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        emit(ChangeDateTimeErrorState(l.errMessage));
      }, (r) async {
        showToast(r);
        emit(ChangeDateTimeSuccessState());
      });
    });
  }

  List<File> filesPicker = [];

  Future<void> pickAndOpenPdf({
    required String projectId,
  }) async {
    emit(PickFileLoadingState());
    final FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      filesPicker.addAll(result.paths.map((path) => File(path!)).toList());
      emit(PickFileSuccessState());

      DateAttachmentDataSource.postAddAttachment(attachmentParams: AttachmentParams(projectId: projectId, attachments: filesPicker));
    } else {
      showToast('No file selected');
      emit(PickFileErrorState());
    }
  }

  Future<void> removePicture({
    required int index,
    required String attachmentId,
  }) async {
    emit(RemoveFileLoadingState());

    DateAttachmentDataSource.postDeleteAttachment(attachmentId: attachmentId).then((value) {
      value.fold((l) {
        emit(RemoveFileErrorState(l.errMessage));
      }, (r) {
        emit(RemoveFileSuccessState());
      });
    });
  }
}
