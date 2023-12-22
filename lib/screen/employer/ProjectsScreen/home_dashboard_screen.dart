import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cnattendance/Controller/StaticControllers/mainBlocHome/cubit.dart';
import 'package:cnattendance/Controller/StaticControllers/mainBlocHome/state.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/custom_floating_action_button_maintenance.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeDashboardScreen extends StatefulWidget {
  static const String routeName = '/HomeDashboard';

  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int selectedIndex = 0;

  final _controller = NotchBottomBarController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBlocHomeCubit, MainBlocHomeState>(
      builder: (context, state) => Scaffold(
        body: MainBlocHomeCubit.of(context).screenList[MainBlocHomeCubit.of(context).indexList],
        extendBody: true,
        bottomNavigationBar: SizedBox(
          height: context.screenHeight * .15,
          child: Column(
            children: [
              if (MainBlocHomeCubit.of(context).indexList == 1 && genderUser == RoleId.customer.name) const CustomFloatingActionButtonMaintenance(),
              const Spacer(),
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
                      SvgPicture.asset(Assets.selectedMessage)
                    else
                      SvgPicture.asset(Assets.unSelectMessage),
                    if (MainBlocHomeCubit.of(context).indexList == 3)
                      SvgPicture.asset(Assets.selectedProjects)
                    else
                      SvgPicture.asset(Assets.projects),
                    if (MainBlocHomeCubit.of(context).indexList == 4)
                      SvgPicture.asset(Assets.selectedMenu)
                    else
                      SvgPicture.asset(Assets.unSelectedMenu),
                  ],
                  onTap: (int index) {
                    MainBlocHomeCubit.of(context).changeIndex(index: index);
                  }),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
/*

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
