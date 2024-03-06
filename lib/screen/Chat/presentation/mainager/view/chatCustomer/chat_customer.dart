import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_drop_down_menu.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/Chat/presentation/mainager/supportCustomerBloc/cubit.dart';
import 'package:cnattendance/screen/Chat/presentation/mainager/supportCustomerBloc/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:cnattendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatCustomer extends StatelessWidget {
  const ChatCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Support',
          style: Styles.styleHeader,
        ),
      ),
      //resizeToAvoidBottomInset: false,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .03),
        children: [
          Text(
            'Help Desk',
            style: Styles.style16700,
          ),
          Text(
            'Contact us if any problem or complains need to be addressed.',
            style: Styles.style14400.copyWith(
                color: AppColors.subTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp),
          ),
          5.ESH(),
          SizedBox(
            width: context.screenWidth,
            child: CustomDropDownMenu(
                selectedItem: 'Department',
                items: [RoleId.nine.name.tr, RoleId.ten.name.tr]),
          ), //
          CustomTextFormField(
            controller: TextEditingController(),
            hintText: 'Title',
            fillColor: AppColors.white,
          ),
          CustomTextFormField(
            controller: TextEditingController(),
            hintText: 'Description',
            fillColor: AppColors.white,
            maxLines: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Attachment',
                style: Styles.style16700,
              ),
              BlocBuilder<SupportCustomerBloc, SupportCustomerState>(
                builder: (context, state) => IconButton(
                  onPressed: () {
                    SupportCustomerBloc.of(context).addAttachment();
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<SupportCustomerBloc, SupportCustomerState>(
            builder: (context, state) => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  await Utils.openFile(
                      nameFile: SupportCustomerBloc.of(context)
                          .filesPicker[index]
                          .path);
                },
                child: Container(
                  padding: EdgeInsets.all(context.screenWidth * .02),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(context.screenWidth * .015),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.greyWhite)),
                        child: SvgPicture.asset(Assets.FileSVG),
                      ),
                      10.ESW(),
                      Text(
                        Utils.createNameFile(
                            nameFile: SupportCustomerBloc.of(context)
                                .filesPicker[index]
                                .path),
                        style: Styles.style14500
                            .copyWith(color: AppColors.subTextColor),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          SupportCustomerBloc.of(context)
                              .deleteIndexAttachment(index: index);
                        },
                        child: SvgPicture.asset(
                          Assets.trash,
                          colorFilter:
                              ColorFilter.mode(AppColors.red, BlendMode.srcIn),
                          width: context.screenWidth * .045,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: SupportCustomerBloc.of(context).filesPicker.length,
              separatorBuilder: (context, index) => 5.ESH(),
            ),
          ),

          //   40.ESH(),
        ].paddingDirectional(bottom: context.screenHeight * .01),
      ),
      bottomNavigationBar:
          BlocBuilder<SupportCustomerBloc, SupportCustomerState>(
        builder: (context, state) =>
            SupportCustomerBloc.of(context).filesPicker.length < 4
                ? SizedBox(
                    //  height: context.screenHeight * .13,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextButton(
                          backgroundColor: AppColors.primaryColor,
                          onPress: () {
                            Navigator.pushNamed(
                                context, AppRoute.messagesCustomerScreen);
                          },
                          child: Text(
                            'Chating',
                            style: Styles.style16700
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: context.screenHeight * 0,
                  ),
      ),
      /* persistentFooterButtons: [
        CustomTextButton(
          backgroundColor: AppColors.primaryColor,
          onPress: () {
            Navigator.pushNamed(context, AppRoute.messagesCustomerScreen);
          },
          child: Text(
            'Chating',
            style: Styles.style16700.copyWith(color: AppColors.white),
          ),
        )
      ], */
    );
  }
}
