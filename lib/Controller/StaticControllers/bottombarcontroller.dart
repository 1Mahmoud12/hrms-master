import 'package:cnattendance/screen/Chat/ChatScreenView.dart';
import 'package:cnattendance/screen/MoreScreenEmployee/MoreScreenNew.dart';
import 'package:cnattendance/screen/employer/ProjectsScreen/projects_screen.dart';
import 'package:cnattendance/screen/employer/main_screen_employer/home_screen_employer.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/maintenance_screen.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Customer
class BottomBarController extends GetxController {
  List<String> iconList = [
    Assets.selectedHome,
    Assets.selectedMaintenance,
    Assets.selectedProjects,
    Assets.selectedMenu,

    /*SvgPicture.asset(
      Assets.message,
      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.modulate),
    ),*/
  ];
  RxInt selectedIndex = 0.obs;
  List<Widget> screenList = [
    const HomeScreenEmployer(),
    const MaintenanceScreen(),
    ChatScreenView(),
    const ProjectsScreen(),
    const MoreScreenNew(),
  ];

  void onItemTapped(int index) {
//    final c = selectedIndex.value;
    selectedIndex.value = index;
    update();
    debugPrint(index.toString());
    // if (index == 3) {
    //   Get.to(LoginScreen());
    //   selectedIndex.value = c;
    // }
    if (index == 2) {
      update();
    }
    if (index == 4) {}
    update();
  }
}
