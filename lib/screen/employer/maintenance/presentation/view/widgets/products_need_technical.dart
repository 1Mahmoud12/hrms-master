import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/productsNeedTechnicalBloc/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/productsNeedTechnicalBloc/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/custom_drop_down_menu.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductsNeedTechnical extends StatelessWidget {
  const ProductsNeedTechnical({super.key, this.onItemSelected});
 final ValueChanged<String>? onItemSelected;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsNeedTechnicalBloc(),
      child: BlocBuilder<ProductsNeedTechnicalBloc, ProductsNeedTechnicalState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Products Needed'.tr,
              style: Styles.style16700,
            ),
            ...List.generate(
              ProductsNeedTechnicalBloc.of(context).products.length,
              (index) => selectedItem(
                context: context,
                nameProduct: ProductsNeedTechnicalBloc.of(context).products[index],
                index: index,
              ),
            ),
            BlocBuilder<ProductsNeedTechnicalBloc, ProductsNeedTechnicalState>(
              builder: (context, state) => CustomDropDownMenuTechnical(
                onItemSelected:onItemSelected ,
                selectedItem: 'choose Product'.tr,
                items:  ['Engine'.tr, 'Cabin'.tr],
                width: context.screenWidth,
                cubit: ProductsNeedTechnicalBloc(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget selectedItem({required BuildContext context, required String nameProduct, required int index}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameProduct,
            style: Styles.style14400,
          ),
          InkWell(
            onTap: () => ProductsNeedTechnicalBloc.of(context).removeProduct(index: index),
            child: SvgPicture.asset(
              Assets.trash,
              height: 15,
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
          ),
        ],
      ),
      const Divider(),
    ],
  );
}
