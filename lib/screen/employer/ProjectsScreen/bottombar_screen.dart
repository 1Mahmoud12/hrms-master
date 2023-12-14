/*
import 'package:cnattendance/Controller/StaticControllers/bottombarcontroller.dart';
import 'package:cnattendance/Controller/StaticControllers/maincontroller.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomBarController bottomController = Get.put(BottomBarController());
    final MaindartController maindartControl = Get.put(MaindartController());

    return GetBuilder(
      init: bottomController,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            // currentIndex: bottomController.selectedIndex.value,
            selectedItemColor: AppColors.scaffoldBackGround,
            unselectedItemColor: Colors.black,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            iconSize: 20,
            selectedFontSize: 0,
            onTap: bottomController.onItemTapped,
            elevation: 0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: bottomController.selectedIndex.value == 0
                    ? const ButtonBack(customIcon: Icons.home, colorName: AppColors.primaryColor)
                    : ButtonBack(customIcon: Icons.home, iconColorName: AppColors.primaryColor, colorName: AppColors.white.withOpacity(0.2)),
                label: 'home'.tr,
              ),
              BottomNavigationBarItem(
                icon: bottomController.selectedIndex.value == 1
                    ? const ButtonBack(customIcon: Icons.business, colorName: AppColors.primaryColor)
                    : ButtonBack(
                        customIcon: Icons.business,
                        iconColorName: AppColors.primaryColor,
                        colorName: AppColors.white.withOpacity(0.2),
                      ),
                label: 'favourite'.tr,
              ),
              BottomNavigationBarItem(
                icon: bottomController.selectedIndex.value == 2
                    ? const ButtonBack(customIcon: Icons.bakery_dining_outlined, colorName: AppColors.primaryColor)
                    : ButtonBack(
                        customIcon: Icons.bakery_dining_outlined,
                        iconColorName: AppColors.primaryColor,
                        colorName: AppColors.white.withOpacity(0.2),
                      ),
                label: 'notification'.tr,
              ),
              BottomNavigationBarItem(
                icon: bottomController.selectedIndex.value == 3
                    ? const ButtonBack(customIcon: Icons.person, colorName: AppColors.primaryColor)
                    : ButtonBack(customIcon: Icons.person, iconColorName: AppColors.primaryColor, colorName: AppColors.white.withOpacity(0.2)),
                // icon: Icon(FontAwesomeIcons.user),
                label: 'profile'.tr,
              ),
              // BottomNavigationBarItem(
            ],
          ),
        );
      },
    );
  }
}

class ButtonBack extends StatelessWidget {
  final IconData customIcon;
  final Color colorName;
  final Color? iconColorName;

  const ButtonBack({super.key, required this.customIcon, required this.colorName, this.iconColorName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colorName.withOpacity(0.2),
        // border: Border.all(
        //   color: Colors.red,
        // ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Icon(
        customIcon,
        color: iconColorName ?? colorName,
      ),
    );
  }
}
*/
