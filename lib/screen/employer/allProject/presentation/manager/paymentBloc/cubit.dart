import 'dart:developer';
import 'dart:io';

import 'package:cnattendance/screen/employer/allProject/presentation/manager/paymentBloc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  static PaymentCubit of(BuildContext context) => BlocProvider.of<PaymentCubit>(context);

  String status = 'In Progress';
  DateTime dueDate = DateTime(2023, 12, 14);

  List<File> filesPicker = [];
  final picker = ImagePicker();
  File? image;

  void selectImage() async {
    emit(PickFileLoadingState());
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100, // To set quality of images
      maxHeight: 1000, // To set maxHeight of images that you want in your app
      maxWidth: 1000,
    ); // To set maxHeight of images that you want in your app
    final XFile? xFilePick = pickedFile;
    if (xFilePick != null) {
      image = File(xFilePick.path);
      showToast('send receipt successfully');
      emit(PickFileSuccessState());
    } else {
      emit(PickFileErrorState());
    }
  }
}
