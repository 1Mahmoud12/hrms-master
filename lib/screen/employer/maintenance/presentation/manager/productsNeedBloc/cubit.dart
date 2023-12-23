import 'package:cnattendance/screen/employer/maintenance/presentation/manager/productsNeedBloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsNeedBloc extends Cubit<ProductsNeedState> {
  ProductsNeedBloc() : super(ProductsNeedInitial());

  static ProductsNeedBloc of(BuildContext context) => BlocProvider.of<ProductsNeedBloc>(context);
  List<Map<String, dynamic>> productsNeed = [];
  TextEditingController priceController = TextEditingController(text: '0');
  bool confirmCancelButton = true;
  bool trashConfirmPrice = false;
  bool editPrice = false;

  void changeState({
    required bool confirmCancel,
    required bool trashConfirm,
    required bool edit,
  }) {
    confirmCancelButton = confirmCancel;
    trashConfirmPrice = trashConfirm;
    editPrice = edit;
    emit(SelectLocationState());
  }
}
