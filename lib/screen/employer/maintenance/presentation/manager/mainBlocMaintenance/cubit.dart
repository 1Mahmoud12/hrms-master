import 'dart:io';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// Ensure to include relevant imports for Failure and EmergenciesModel

class MainBlocMaintenanceCubit extends Cubit<MainBlocMaintenanceState> {
  MainBlocMaintenanceCubit() : super(MainBlocMaintenanceInitial());

  static MainBlocMaintenanceCubit of(BuildContext context) =>
      BlocProvider.of<MainBlocMaintenanceCubit>(context);

  void changeState() {
    emit(SelectLocationState());
  }

  // toggle switch
  int indexList = 0;

  List<String> maintenanceLabels = [
    'Emergency Request'.tr,
    'Malfunction Request'.tr,
    'Periodic Maintenance'.tr,
  ];

  void changeIndex({required int index}) {
    indexList = index;
    emit(ChangeIndexState());
  }

  PageController pageController = PageController();

  void changeView(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceOut,
    );
  }

  final picker = ImagePicker();
  File? image;

  void imageFileClear() async {
    image = File('');
    emit(ClearImageState());
  }

  void imagesAttachmentClear({required int index}) async {
    imagesAttachment.removeAt(index);
    emit(ClearImageState());
  }

  void selectImage() async {
    emit(SelectImageLoadingState());
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    final XFile? xFilePick = pickedFile;
    if (xFilePick != null) {
      image = File(xFilePick.path);
      emit(SelectImageSuccessState());
    } else {
      emit(SelectImageErrorState());
    }
  }

  List<File> imagesAttachment = [];

  void selectMoreImages() async {
    emit(SelectImageLoadingState());
    final pickedFile = await picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    final List<XFile> xFilePick = pickedFile;

    for (final element in xFilePick) {
      imagesAttachment.add(File(element.path));
    }

    emit(SelectImageSuccessState());
  }
}
