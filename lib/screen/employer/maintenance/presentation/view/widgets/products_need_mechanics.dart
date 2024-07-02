import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/productsNeedBloc/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/productsNeedBloc/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductsNeedMalfunction extends StatelessWidget {
  const ProductsNeedMalfunction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Products need'.tr,
          style: Styles.style16700,
        ),
        BlocBuilder<ProductsNeedBloc, ProductsNeedState>(
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${oneMalfunctioCache!.data!.report == null || oneMalfunctioCache == null ? 'N/A' : oneMalfunctioCache!.data!.report!.product}',
                style:
                    Styles.style14400.copyWith(color: AppColors.subTextColor),
              ),
              // if (ProductsNeedBloc.of(context).confirmCancelButton)
              //   if (ProductsNeedBloc.of(context).trashConfirmPrice)
              //     if (ProductsNeedBloc.of(context).editPrice)
              //       ...List.generate(
              //         5,
              //         (index) => Container(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(15.r),
              //           ),
              //           padding: EdgeInsets.all(10.w),
              //           child: Row(
              //             children: [
              //               Text(
              //                 'Engine',
              //                 style: Styles.style14400
              //                     .copyWith(color: AppColors.subTextColor),
              //               ),
              //               const Spacer(),

              //               if (ProductsNeedBloc.of(context)
              //                   .confirmCancelButton)
              //                 confirmCancelButton(context: context),
              //               if (ProductsNeedBloc.of(context).trashConfirmPrice)
              //                 trashConfirmPrice(context: context),
              //               if (ProductsNeedBloc.of(context).editPrice)
              //                 editPrice(context: context),
              //               //const Text('\$15,000'),
              //             ],
              //           ),
              //         ),
              //       ),
              const Divider(),
              Row(
                children: [
                  Text(
                    'Total'.tr,
                    style: Styles.style16700,
                  ),
                  const Spacer(),
                  Text(
                    '${oneMalfunctioCache!.data!.report == null || oneMalfunctioCache == null ? 'N/A' : oneMalfunctioCache!.data!.report!.price}',
                  ),

                  // Text(
                  //   '${int.parse(ProductsNeedBloc.of(context).priceController.text) * 5}',
                  // ),
                ],
              ),
            ],
          ),
        ),
      ].paddingDirectional(bottom: 10.h),
    );
  }
}

Widget editPrice({required BuildContext context}) {
  return Row(
    children: [
      Text('\$${ProductsNeedBloc.of(context).priceController.text}'),
      10.ESW(),
      InkWell(
        onTap: () => ProductsNeedBloc.of(context)
            .changeState(confirmCancel: false, trashConfirm: true, edit: false),
        child: SvgPicture.asset(
          Assets.edit,
          height: context.screenHeight * .02,
        ),
      ),
    ],
  );
}

Widget confirmCancelButton({required BuildContext context}) {
  return Row(
    children: [
      CustomTextButton(
        width: context.screenHeight * .074,
        height: context.screenHeight * .04,
        onPress: () {
          ProductsNeedBloc.of(context).changeState(
            confirmCancel: false,
            trashConfirm: false,
            edit: false,
          );
        },
        backgroundColor: AppColors.cBackGroundDeleteButton,
        borderColor: Colors.transparent,
        child: Text(
          'Cancel'.tr,
          style: TextStyle(color: AppColors.white, fontSize: 10.sp),
        ),
      ),
      5.ESW(),
      CustomTextButton(
        width: context.screenHeight * .075,
        height: context.screenHeight * .04,
        onPress: () {
          ProductsNeedBloc.of(context).changeState(
            confirmCancel: false,
            trashConfirm: true,
            edit: false,
          );
        },
        backgroundColor: AppColors.cBackGroundConfirmButton,
        borderColor: Colors.transparent,
        child: Text(
          'Confirm'.tr,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}

Widget trashConfirmPrice({required BuildContext context}) {
  return Row(
    children: [
      InkWell(
        onTap: () => ProductsNeedBloc.of(context)
            .changeState(confirmCancel: true, trashConfirm: false, edit: false),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: BorderRadius.circular(5.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
          child: SvgPicture.asset(Assets.trash),
        ),
      ),
      4.ESW(),
      InkWell(
        onTap: () {
          // if textButton not = 0
          if (ProductsNeedBloc.of(context).priceController.text != '0') {
            ProductsNeedBloc.of(context).changeState(
              confirmCancel: false,
              trashConfirm: false,
              edit: true,
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(5.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
          child: SvgPicture.asset(Assets.confirm),
        ),
      ),
      4.ESW(),
      Text(
        'Price'.tr,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textColorTextFormField,
        ),
      ),
      4.ESW(),
      SizedBox(
        width: context.screenWidth * .15,
        height: context.screenHeight * .05,
        child: TextField(
          controller: ProductsNeedBloc.of(context).priceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: '',
            fillColor: AppColors.white,
          ),
        ),
      ),
      10.ESW(),
    ],
  );
}
