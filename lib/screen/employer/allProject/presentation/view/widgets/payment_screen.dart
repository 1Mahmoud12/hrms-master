import 'package:cnattendance/core/component/slider/slider.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/paymentBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/paymentBloc/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    PaymentCubit.of(context).getAllPayments(context: context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payments',
          style: Styles.styleHeader,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.w),
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
            child: Column(
              children: [
                BlocBuilder<PaymentCubit, PaymentState>(builder: (context, state) {
                  final double value =(PaymentCubit.of(context).history.length/PaymentCubit.of(context).upComing.length+PaymentCubit.of(context).history.length)*100;
                  print('slider value ${value.runtimeType}');
                  return  SliderCustom(valueSlider:value);
                },),
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
                          '\$${PaymentCubit.of(context).paid}',
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
                          '\$${PaymentCubit.of(context).remaining}',
                          style: Styles.style14500.copyWith(color: AppColors.subTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          15.ESH(),
          Center(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: AppColors.white,
              ),
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                child: BlocBuilder<PaymentCubit, PaymentState>(
                  builder: (context, state) => ToggleSwitch(
                    cornerRadius: 20,
                    activeBgColor: const [AppColors.primaryColor],
                    activeFgColor: Colors.white,
                    inactiveFgColor: AppColors.primaryColor,
                    inactiveBgColor: AppColors.white,
                    minWidth: context.screenWidth * 0.4,
                    minHeight: 34,
                    initialLabelIndex: PaymentCubit.of(context).toggleIndex,
                    totalSwitches: 2,
                    onToggle: (int? index) {
                      PaymentCubit.of(context).changeIndex(index: index!);
                    },
                    customTextStyles: [
                      Styles.style12400.copyWith(color: PaymentCubit.of(context).toggleIndex == 0 ? AppColors.white : AppColors.subTextColor),
                      Styles.style12400.copyWith(color: PaymentCubit.of(context).toggleIndex == 1 ? AppColors.white : AppColors.subTextColor),
                    ],
                    labels: ['upcoming'.tr, 'History'.tr],
                  ),
                ),
              ),
            ),
          ),
          10.ESH(),
          BlocBuilder<PaymentCubit, PaymentState>(
            builder: (context, state) =>allPaymentsProjectModelCache == null ? const Center(child: CircularProgressIndicator()) : Column(
              children: [
                if (PaymentCubit.of(context).toggleIndex == 0)
                  ...List.generate(
                    PaymentCubit.of(context).upComing.length,
                    (index) => Container(
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
                                'Next Payment is \$${PaymentCubit.of(context).upComing[index].price}',
                                style: Styles.style12400.copyWith(color: AppColors.textColorTextFormField),
                              ),

                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: context.screenHeight * .05,
                            decoration: BoxDecoration(border: Border.all(color: AppColors.greyWhite)),
                          ),
                          15.ESW(),
                          BlocBuilder<PaymentCubit, PaymentState>(
                            builder: (context, state) {
                              final cubit = PaymentCubit.of(context);
                              return InkWell(
                                onTap: () {
                                  cubit.selectImage();
                                },
                                child: Text(
                                  'wait payment'.tr,
                                  style: Styles.style14500.copyWith(color: AppColors.primaryColor),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                if (PaymentCubit.of(context).toggleIndex == 1)
                  ...List.generate(
                    PaymentCubit.of(context).history.length,
                    (index) => Container(
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
                                'Past Payment is \$${PaymentCubit.of(context).history[index].price}',
                                style: Styles.style12400.copyWith(color: AppColors.textColorTextFormField),
                              ),
                              Text(
                                PaymentCubit.of(context).history[index].date.toString(),
                                style: Styles.style12400.copyWith(color: AppColors.subTextColor),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: context.screenHeight * .05,
                            decoration: BoxDecoration(border: Border.all(color: AppColors.greyWhite)),
                          ),
                          10.ESW(),
                          BlocBuilder<PaymentCubit, PaymentState>(
                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  showToast('The value has been paid previously');
                                  // cubit.selectImage();
                                },
                                child: Text(
                                  'Paid',
                                  style: Styles.style14500.copyWith(color: AppColors.subTextColor),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
              ].paddingDirectional(bottom: context.screenWidth * .02),
            ),
          ),
        ],
      ),
    );
  }
}
