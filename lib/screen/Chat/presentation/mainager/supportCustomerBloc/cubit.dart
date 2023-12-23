import 'dart:io';

import 'package:cnattendance/screen/Chat/presentation/mainager/supportCustomerBloc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupportCustomerBloc extends Cubit<SupportCustomerState> {
  SupportCustomerBloc() : super(SupportCustomerInitialState());

  static SupportCustomerBloc of(BuildContext context) => BlocProvider.of<SupportCustomerBloc>(context);
  List<File> filesPicker = [];

  void addAttachment() async {
    emit(PickFileLoadingState());
    final FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      filesPicker.addAll(result.paths.map((path) {
        print(path);
        return File(path!);
      }).toList());

      emit(PickFileSuccessState());
    } else {
      showToast('No file selected');
      emit(PickFileErrorState());
    }
  }

  void deleteIndexAttachment({required int index}) {
    filesPicker.removeAt(index);
    emit(RemoveIndexFileState());
  }
}
