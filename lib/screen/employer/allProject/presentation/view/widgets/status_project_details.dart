import 'package:cnattendance/core/component/slider.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatusDetailsProject extends StatelessWidget {
  const StatusDetailsProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(Assets.users),
                  20.ESW(),
                  Text(
                    'Teams',
                    style: Styles.style14400.copyWith(color: AppColors.textColorTextFormField),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Stack(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Padding(
                          padding: EdgeInsets.only(left: index * 18.0),
                          child: Image.asset(Assets.temporaryPerson),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5 * 18.0),
                        child: Container(
                          padding: EdgeInsets.all(context.screenWidth * .015),
                          decoration: const BoxDecoration(color: AppColors.cLightPlusNumber, shape: BoxShape.circle),
                          child: Text(
                            '+5',
                            style: Styles.style12400.copyWith(color: AppColors.cPlusNumber),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(Assets.oneUser),
                  20.ESW(),
                  Text(
                    'Engineer',
                    style: Styles.style14400.copyWith(color: AppColors.textColorTextFormField),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: context.screenWidth * .3),
                    child: const Text('Darwish ahmed mohamed eljoijfldj flkjlkfjl;dskjflk', overflow: TextOverflow.ellipsis),
                  ),
                  5.ESW(),
                  Image.asset(Assets.temporaryPerson),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(Assets.userCheck),
                  20.ESW(),
                  Text(
                    'Status',
                    style: Styles.style14400.copyWith(color: AppColors.textColorTextFormField),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8).w,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.r), border: Border.all(color: AppColors.primaryColor)),
                    child: Text(
                      'TO-DO',
                      style: Styles.style14500.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(Assets.calenderProject),
                  20.ESW(),
                  Text(
                    'Due Date',
                    style: Styles.style14400.copyWith(color: AppColors.textColorTextFormField),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Text(
                    'Dec 14,2024',
                    style: Styles.style14400,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(Assets.FileProject),
                  20.ESW(),
                  Text(
                    'Attachment',
                    style: Styles.style14400.copyWith(color: AppColors.textColorTextFormField),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: context.screenWidth * .5,
                height: context.screenHeight * .05,
                child: ListView(
                  //s shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8).w,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.r), border: Border.all(color: AppColors.primaryColor)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            Assets.FileProject,
                            colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                          ),
                          5.ESW(),
                          Text(
                            'Name file.pdf',
                            style: Styles.style14500.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style:
                          const ButtonStyle(shape: MaterialStatePropertyAll(LinearBorder.none), padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                      child: Container(
                        padding: const EdgeInsets.all(8).w,
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(50.r), border: Border.all(color: AppColors.primaryColor, width: 2)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              Assets.plusIcon,
                              colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                            ),
                            5.ESW(),
                            Text(
                              'Add',
                              style: Styles.style14500.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ].paddingDirectional(end: context.screenWidth * .01),
                ),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            final arguments = {
              'progressRatio': 80,
            };
            Navigator.pushNamed(context, AppRoute.progressScreen, arguments: arguments);
          },
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(Assets.progress),
                    20.ESW(),
                    Text(
                      'Progress',
                      style: Styles.style14400.copyWith(color: AppColors.textColorTextFormField),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SliderCustom(valueSlider: 80),
              ),
            ],
          ),
        ),
      ].paddingDirectional(start: 20.w, top: 10.h),
    );
  }
}
