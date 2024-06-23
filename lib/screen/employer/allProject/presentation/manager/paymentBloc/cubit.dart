import 'dart:convert';
import 'dart:io';

import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/data/source/datastore/preferences.dart';
import 'package:cnattendance/screen/employer/allProject/data/dataSource/payment_data_source.dart';
import 'package:cnattendance/screen/employer/allProject/data/models/payment_model.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/paymentBloc/state.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../projectscreen/projectdetailscreen/projectdetailcontroller.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  static PaymentCubit of(BuildContext context) => BlocProvider.of<PaymentCubit>(context);


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

  List<ItemPayment> upComing = [];
  List<ItemPayment> history = [];

  int paid=0;
  int remaining=0;

  int toggleIndex = 0;
  void changeIndex({required int index}) {
    toggleIndex = index;
    emit(ChangeIndexState());
  }

  void getAllPayments({required BuildContext context}) async {
    emit(GetAllPaymentLoadingState());

    //  Navigator.of(context).pushNamedAndRemoveUntil(HomeDashboardScreen.routeName, (route) => false);
    // Preferences.setSaved(value: RoleId.eight.name.tr, key: 'genderUser');
    //if (context.mounted) return;

    await AllPaymentsDataSource.getPayment(Get.find<ProjectDetailController>().project.value.id.toString()).then((value) async {
      value.fold((l) {
        debugPrint(l.errMessage);
        showToast(l.errMessage);
        debugPrint('==== Error ====');
        emit(GetAllPaymentFailureState(l.errMessage));
      }, (r) async {
        await Preferences.setSaved(value: jsonEncode(r.toJson()), key: allProposalsKey);
        if(allPaymentsProjectModelCache!=null)allPaymentsProjectModelCache=null;
        allPaymentsProjectModelCache = PaymentsProjectModel.fromJson(r.toJson());
        upComing=[];
        history=[];
        remaining=0;
        paid=0;

        for(int i = 0; i < allPaymentsProjectModelCache!.data!.length; i++){
          if(allPaymentsProjectModelCache!.data![i].status == 0){
            upComing.add(allPaymentsProjectModelCache!.data![i]);
            remaining+=double.parse(allPaymentsProjectModelCache!.data![i].price!).toInt();
          }else{
            history.add(allPaymentsProjectModelCache!.data![i]);
            paid+=double.parse(allPaymentsProjectModelCache!.data![i].price!).toInt();

          }
        }

        emit(GetAllPaymentSuccessState());
      });
    });

    /* setState(() {
      _isLoading = false;
      EasyLoading.dismiss();
    });*/
  }

}
