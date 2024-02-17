import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/ProjectsScreen/widgets/card_project.dart';
import 'package:cnattendance/screen/employer/main_screen_employer/presentation/view/widgets/slide_widget.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreenEmployer extends StatelessWidget {
  const HomeScreenEmployer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .03),
          child: Column(
            children: [
              //const HeaderProfile(),
              SizedBox(
                // width: MediaQuery.of(context).size.width,
                height: context.screenHeight * .25,
                child: const Center(child: SliderWidget()),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                      10.r,
                    )),
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Story',
                      style: Styles.styleHeader.copyWith(color: AppColors.primaryColor),
                    ),
                    Text(
                      '''
In 2019, a group of passionate and forward-thinking individuals embarked on a journey to redefine the real estate landscape in Saudi Arabia. Their vision was to create a new standard of luxury living that would elevate the concept of home to new heights.

Inspired by the Saudi Vision 2030, which aims to transform the Kingdom’s economy and society through sustainability and innovation, they saw an opportunity to create a real estate company that would align with the Vision’s goals and values.''',
                      style: Styles.style12400.copyWith(color: AppColors.subTextColor),
                    ),
                    Text(
                      'Leadership Excellence',
                      style: Styles.styleHeader.copyWith(color: AppColors.primaryColor),
                    ),
                    Text(
                      '''Meet Dar Bayat’s esteemed management team, and discover how their experience, vision, and expertise guide us towards a brighter future for all.''',
                      style: Styles.style12400.copyWith(color: AppColors.subTextColor),
                    ),
                  ].paddingDirectional(bottom: context.screenHeight * .02),
                ),
              ),
              /* BlocBuilder<MainBlocHomeCustomerCubit, MainBlocHomeCustomerState>(
                builder: (context, state) {
                  final cubit = MainBlocHomeCustomerCubit.of(context);
                  return SizedBox(
                    height: cubit.isExpandedKnows ? context.screenHeight : context.screenHeight * .1,
                    child: ExpandedTileList.builder(
                      itemCount: 1,
                      itemBuilder: (context, index, controller) => ExpandedTile(
                        title: const Text('KnowUs'),
                        content: const KnowUs(),
                        controller: controller,
                        onTap: () {
                          cubit.changeState();
                        },
                      ),
                    ),
                  );
                },
              ),*/
              if (genderUser != RoleId.twelve.name.tr)
                SizedBox(
                  width: context.screenWidth,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoute.knowUs),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor),
                    ),
                    child: Text(
                      'Know more us',
                      style: Styles.style16700.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              20.ESH(),
              if (genderUser != RoleId.twelve.name.tr)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Our business'.tr,
                    style: Styles.styleHeader.copyWith(color: AppColors.primaryColor),
                  ),
                ),
              if (genderUser != RoleId.twelve.name.tr) const CardProject(valueSlider: 100), 50.ESH(),
            ],
          ),
        ),
      ),
    );
  }
}
