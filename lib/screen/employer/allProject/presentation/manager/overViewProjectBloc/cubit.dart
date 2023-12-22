import 'dart:developer';
import 'dart:io';

import 'package:cnattendance/screen/employer/allProject/presentation/manager/overViewProjectBloc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverViewProjectCubit extends Cubit<OverViewState> {
  OverViewProjectCubit() : super(OverViewInitial());

  static OverViewProjectCubit of(BuildContext context) => BlocProvider.of<OverViewProjectCubit>(context);

  String status = 'In Progress';
  DateTime dueDate = DateTime(2023, 12, 14);

  void changeStatus({required String newStatus}) {
    status = newStatus;
    emit(ChangeStatusState());
  }

  void changeDate({required DateTime newDate}) {
    dueDate = newDate;
    emit(ChangeDateTimeState());
  }

  List<File> filesPicker = [];

  Future<void> pickAndOpenPdf() async {
    emit(PickFileLoadingState());
    final FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      filesPicker.addAll(result.paths.map((path) => File(path!)).toList());
      emit(PickFileSuccessState());
    } else {
      showToast('No file selected');
      emit(PickFileErrorState());
    }
  }
}
