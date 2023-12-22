import 'dart:typed_data';

import 'package:cnattendance/core/component/slider.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/paymentBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/paymentBloc/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screenshot/screenshot.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payments',
          style: Styles.styleHeader,
        ),
      ),
      body: BlocProvider(
        create: (context) => PaymentCubit(),
        child: ListView(
          padding: EdgeInsets.all(10.w),
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
              child: Column(
                children: [
                  const SliderCustom(valueSlider: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(Assets.paidWallet),
                          Text(
                            'Paid',
                            style: Styles.style14500.copyWith(color: AppColors.subTextColor),
                          ),
                          Text(
                            '\$30,000',
                            style: Styles.style14500.copyWith(color: AppColors.subTextColor),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(Assets.remaining),
                          Text(
                            'Remaining',
                            style: Styles.style14500.copyWith(color: AppColors.subTextColor),
                          ),
                          Text(
                            '\$50,000',
                            style: Styles.style14500.copyWith(color: AppColors.subTextColor),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            15.ESH(),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(15.r)),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(color: AppColors.cBackGroundIconButton, borderRadius: BorderRadius.circular(8.r)),
                        child: SvgPicture.asset(
                          Assets.nextPayment,
                        ),
                      ),
                      20.ESW(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Next Payment is due to 4 Days',
                            style: Styles.style12400.copyWith(color: AppColors.textColorTextFormField),
                          ),
                          Text(
                            '28th Dec, 2023',
                            style: Styles.style12400.copyWith(color: AppColors.subTextColor),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        '\$20,000',
                        style: Styles.style14400.copyWith(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<PaymentCubit, PaymentState>(
                  builder: (context, state) {
                    final cubit = PaymentCubit.of(context);
                    return InkWell(
                      onTap: () {
                        cubit.selectImage();
                      },
                      child: Row(
                        children: [
                          Container(
                            width: context.screenWidth * .9,
                            margin: EdgeInsets.symmetric(horizontal: context.screenWidth * .02),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5.r), bottomRight: Radius.circular(5.r))),
                            child: Center(
                              child: Text(
                                'Pay Now',
                                style: Styles.style14500.copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
