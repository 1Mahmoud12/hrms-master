import 'package:cnattendance/Controller/StaticControllers/mainBlocHome/cubit.dart';
import 'package:cnattendance/Controller/StaticControllers/mainBlocHome/state.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upgrader/upgrader.dart';

class HomeDashboardScreen extends StatefulWidget {
  static const String routeName = '/HomeDashboard';

  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
        debugLogging: true,
        durationUntilAlertAgain: const Duration(days: 1),
        languageCode: 'en',
        countryCode: 'Us',
      ),
      child: BlocBuilder<MainBlocHomeCubit, MainBlocHomeState>(
        builder: (context, state) => Scaffold(
          body: MainBlocHomeCubit.of(context)
              .screenList[MainBlocHomeCubit.of(context).indexList],
          //extendBody: true,
          floatingActionButton: InkWell(
            onTap: () {
              MainBlocHomeCubit.of(context).changeIndex(index: 2);
            },
            child: MainBlocHomeCubit.of(context).indexList != 2
                ? Container(
                    padding: const EdgeInsets.all(9),
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor, shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      Assets.unSelectMessage,
                      width: context.screenWidth * .08,
                      colorFilter: const ColorFilter.mode(
                          AppColors.white, BlendMode.srcIn),
                    ),
                  )
                : const SizedBox(),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,

          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r))),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedFontSize: 0,
              selectedFontSize: 0,
              items: [
                BottomNavigationBarItem(
                  icon: MainBlocHomeCubit.of(context).indexList == 0
                      ? SvgPicture.asset(Assets.selectedHome)
                      : SvgPicture.asset(Assets.unSelectedHome),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: MainBlocHomeCubit.of(context).indexList == 1
                      ? SvgPicture.asset(Assets.selectedMaintenance)
                      : SvgPicture.asset(Assets.maintenance),
                  label: '',
                ),
                /* BottomNavigationBarItem(
                  icon: MainBlocHomeCubit.of(context).indexList == 2
                      ? SvgPicture.asset(Assets.selectedMessage, width: context.screenWidth * .065)
                      : SvgPicture.asset(Assets.unSelectMessage),
                  label: '',
                ),*/
                BottomNavigationBarItem(
                  icon: MainBlocHomeCubit.of(context).indexList == 3
                      ? SvgPicture.asset(Assets.selectedProjects)
                      : SvgPicture.asset(Assets.projects),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: MainBlocHomeCubit.of(context).indexList == 4
                      ? SvgPicture.asset(Assets.selectedMenu)
                      : SvgPicture.asset(Assets.unSelectedMenu),
                  label: '',
                ),
              ],
              type: BottomNavigationBarType.fixed,
              landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
              onTap: (int index) {
                MainBlocHomeCubit.of(context)
                    .changeIndex(index: index >= 2 ? index + 1 : index);
              },
            ),
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}
/*
 CurvedNavigationBar(
                items: [
                  if (MainBlocHomeCubit.of(context).indexList == 0)
                    SvgPicture.asset(Assets.selectedHome)
                  else
                    SvgPicture.asset(Assets.unSelectedHome),
                  if (MainBlocHomeCubit.of(context).indexList == 1)
                    SvgPicture.asset(Assets.selectedMaintenance)
                  else
                    SvgPicture.asset(Assets.maintenance),
                  if (MainBlocHomeCubit.of(context).indexList == 2)
                    SvgPicture.asset(
                      Assets.selectedMessage,
                      width: context.screenWidth * .065,
                    )
                  else
                    SvgPicture.asset(Assets.unSelectMessage),
                  if (MainBlocHomeCubit.of(context).indexList == 3) SvgPicture.asset(Assets.selectedProjects) else SvgPicture.asset(Assets.projects),
                  if (MainBlocHomeCubit.of(context).indexList == 4)
                    SvgPicture.asset(Assets.selectedMenu)
                  else
                    SvgPicture.asset(Assets.unSelectedMenu),
                ],
                onTap: (int index) {
                  MainBlocHomeCubit.of(context).changeIndex(index: index);
                },
              ),
 SizedBox(
          height: context.screenHeight * .4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (selectedIndex == 1 && genderUser == RoleId.customer.name) const CustomFloatingActionButtonMaintenance(),
              AnimatedNotchBottomBar(
                notchBottomBarController: _controller,
                bottomBarItems: [
                  BottomBarItem(inActiveItem: SvgPicture.asset(Assets.unSelectedHome), activeItem: SvgPicture.asset(Assets.selectedHome)),
                  BottomBarItem(inActiveItem: SvgPicture.asset(Assets.maintenance), activeItem: SvgPicture.asset(Assets.selectedMaintenance)),
                  BottomBarItem(inActiveItem: SvgPicture.asset(Assets.unSelectMessage), activeItem: SvgPicture.asset(Assets.selectedMessage)),
                  BottomBarItem(inActiveItem: SvgPicture.asset(Assets.projects), activeItem: SvgPicture.asset(Assets.selectedProjects)),
                  BottomBarItem(inActiveItem: SvgPicture.asset(Assets.unSelectedMenu), activeItem: SvgPicture.asset(Assets.selectedMenu)),
                ],
                onTap: (value) {
                  MainBlocHomeCubit.of(context).changeIndex(index: value);
                  _controller.index = value;
                  //_pageController.jumpToPage(value);

                  print(selectedIndex);
                },
              ),
            ],
          ),
        )
 */
