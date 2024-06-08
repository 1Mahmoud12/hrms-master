import 'dart:io';

import 'package:cnattendance/screen/employer/allProject/presentation/manager/paymentBloc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
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

  List<String> upComing = ['20.000', '40.000'];
  List<String> history = [
    '50.000',
    '20.00',
    '50.000',
    '20.00',
    '50.000',
    '20.00',
    '50.000',
    '20.00',
  ];
  int toggleIndex = 0;
  void changeIndex({required int index}) {
    toggleIndex = index;
    emit(ChangeIndexState());
  }
}
