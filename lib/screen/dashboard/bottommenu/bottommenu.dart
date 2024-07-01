import 'package:cnattendance/Controller/BottommenuController/BottomMenuController.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/provider/prefprovider.dart';
import 'package:cnattendance/screen/AttendenceScreen/attendanceScreenNew.dart';
import 'package:cnattendance/screen/MoreScreenEmployee/more_screen_new.dart';
import 'package:cnattendance/screen/dashboard/homescreen.dart';
import 'package:cnattendance/screen/leavescreen/LeaveScreenNew.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Chat/ChatScreenView.dart';

class MenuScreen extends StatelessWidget {
  static const String routeName = '/BottoMenu-Dashboard';

  MenuScreen({super.key});

  final bottomMenuController = Get.put(BottomMenuController());
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    ///final String fillcolor = '#635F54';
    final prefProvider = Provider.of<CustomerProvider>(context);
    prefProvider.getUser();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        // shape: const CircularNotchedRectangle(),
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: GetBuilder(
          init: bottomMenuController,
          builder: (ctx) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          bottomMenuController.updatewidget(const HomeScreen(), 0);
                        },
                        icon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (bottomMenuController.currenttab == 0)
                              SvgPicture.asset(
                                Assets.selectedHome,
                                // colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                              )
                            else
                              SvgPicture.asset(
                                Assets.unSelectedHome,
                                // colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                              ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          bottomMenuController.updatewidget(const LeaveScreenNew(), 1);
                        },
                        icon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (bottomMenuController.currenttab == 1)
                              SvgPicture.asset(
                                Assets.selectedMaintenance,
                              )
                            else
                              SvgPicture.asset(
                                Assets.maintenance,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          bottomMenuController.updatewidget(const AttendanceNew(), 2);
                        },
                        icon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (bottomMenuController.currenttab == 2)
                              SvgPicture.asset(
                                Assets.selectedProjects,
                              )
                            else
                              SvgPicture.asset(
                                Assets.projects,
                              ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          bottomMenuController.updatewidget(const MoreScreenNew(), 3);
                        },
                        icon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (bottomMenuController.currenttab == 3)
                              SvgPicture.asset(
                                Assets.selectedMenu,
                              )
                            else
                              SvgPicture.asset(
                                Assets.unSelectedMenu,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: GetBuilder(
        init: bottomMenuController,
        builder: (context) {
          return PageStorage(
            bucket: bucket,
            child: bottomMenuController.currentscreen,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Get.to(const ChatScreenView());
          // Get.to(CustomChatui());
        },
        child: SvgPicture.asset(
          Assets.selectedMessage,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.modulate),
        ),
      ),
    );
  }
}
