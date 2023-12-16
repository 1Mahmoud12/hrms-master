import 'dart:io';

import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MainBlocMaintenanceCubit extends Cubit<MainBlocMaintenanceState> {
  MainBlocMaintenanceCubit() : super(MainBlocMaintenanceInitial());

  static MainBlocMaintenanceCubit of(BuildContext context) => BlocProvider.of<MainBlocMaintenanceCubit>(context);

  void changeState() {
    emit(SelectLocationState());
  }

  // toggle switch
  int indexList = 0;

  List<String> maintenanceLabels = ['Emergency maintenance request', 'Malfunction maintenance', 'Request periodic maintenance'];

  void changeIndex({required int index}) {
    indexList = index;
    emit(ChangeIndexState());
  }

  final picker = ImagePicker();
  File? image;
  void selectImage() async {
    emit(SelectImageLoadingState());
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100, // To set quality of images
      maxHeight: 1000, // To set maxHeight of images that you want in your app
      maxWidth: 1000,
    ); // To set maxHeight of images that you want in your app
    final XFile? xFilePick = pickedFile;
    if (xFilePick != null) {
      image = File(xFilePick.path);
      emit(SelectImageSuccessState());
    } else {
      emit(SelectImageErrorState());
    }
  }
}
