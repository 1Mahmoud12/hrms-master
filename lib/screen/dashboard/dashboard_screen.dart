/*
import 'package:cnattendance/provider/prefprovider.dart';
import 'package:cnattendance/screen/dashboard/attendancescreen.dart';
import 'package:cnattendance/screen/dashboard/homescreen.dart';
import 'package:cnattendance/screen/dashboard/leavescreen.dart';
import 'package:cnattendance/screen/dashboard/morescreen.dart';
import 'package:cnattendance/screen/dashboard/projectscreen.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      ProjectScreen(),
      LeaveScreen(),
      AttendanceScreen(),
      const MoreScreen(),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    final prefProvider = Provider.of<PrefProvider>(context);
    prefProvider.getUser();
    return Scaffold(
      body: PersistentTabView(context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          backgroundColor: HexColor('#041033'),
          handleAndroidBackButtonPress: true,
          // Default is true.
          resizeToAvoidBottomInset: true,
          // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true,
          // Default is true.
          hideNavigationBarWhenKeyboardShows: true,
          // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(0.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          navBarStyle: NavBarStyle.style11),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(Assets.unSelectedMenu),
        title: 'Home',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white30,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(Assets.maintenance),
        title: 'Work',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white30,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.sick),
        title: 'Leave',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white30,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(Assets.projects),
        title: 'Attendance',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white30,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(Assets.unSelectedMenu),
        title: 'More',
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white30,
      ),
    ];
  }
}
*/
