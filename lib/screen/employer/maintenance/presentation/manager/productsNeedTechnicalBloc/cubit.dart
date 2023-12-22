import 'package:cnattendance/screen/employer/maintenance/presentation/manager/productsNeedTechnicalBloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsNeedTechnicalBloc extends Cubit<ProductsNeedTechnicalState> {
  ProductsNeedTechnicalBloc() : super(ProductsNeedTechnicalInitial());

  static ProductsNeedTechnicalBloc of(BuildContext context) => BlocProvider.of<ProductsNeedTechnicalBloc>(context);

  List<String> products = [];

  void addProduct({
    required String product,
  }) {
    debugPrint(product);
    debugPrint('$products');
    products.add(product);
    emit(AddProductState());
  }

  void removeProduct({required int index}) {
    products.removeAt(index);
    emit(RemoveIndexState());
  }
}
