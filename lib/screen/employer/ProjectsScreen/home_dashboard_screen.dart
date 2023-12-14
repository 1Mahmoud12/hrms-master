import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cnattendance/Controller/StaticControllers/bottombarcontroller.dart';
import 'package:cnattendance/Controller/StaticControllers/maincontroller.dart';
import 'package:cnattendance/provider/prefprovider.dart';
import 'package:cnattendance/screen/Chat/ChatScreenView.dart';
import 'package:cnattendance/screen/MoreScreenEmployee/MoreScreenNew.dart';
import 'package:cnattendance/screen/employer/main_screen_employer/home_screen_employer.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/maintenance_screen.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'projects_screen.dart';

final ZoomDrawerController za = ZoomDrawerController();

class HomeDashboardScreen extends StatefulWidget {
  static const String routeName = '/HomeDashboard';

  HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  BottomBarController bottomController = Get.put(BottomBarController());

  MaindartController maindartControl = Get.put(MaindartController());

  MaindartController mainlang = Get.put(MaindartController());

  // BottomBarController bottomController = Get.put(BottomBarController());
  int selectedIndex = 0;

  final _controller = NotchBottomBarController();
  List<Widget> screenList = [
    const HomeScreenEmployer(),
    const MaintenanceScreen(),
    ChatScreenView(),
    const ProjectsScreen(),
    const MoreScreenNew(),
  ];
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final prefProvider = Provider.of<CustomerProvider>(context);
    prefProvider.getUser();

    //print('object');
    return Scaffold(
      // backgroundColor: AppColors.scaffoldBackGround,

      // backgroundColor:
      // bottomcontroller.selectedIndex.value != 0
      //     ? ColorConstraints.white
      //     :
      //  Colors.transparent,
      /*appBar:
            // bottomcontroller.selectedIndex.value != 0
            //     ? null
            //     :
            AppBar(
          title: Image.asset(
            Assets.appLoage,
            width: 100,
            color: AppColors.primaryColor,
          ),
          elevation: 0.0,
          actions: const [],
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // debugPrint("${za.toggle}");
              za.toggle!();
              // za.open!();
            },
          ),
        ),*/
      body: bottomController.screenList[selectedIndex],
      /*floatingActionButton: FloatingActionButton(
          onPressed: () {},
          //params
        ),*/
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        bottomBarItems: [
          BottomBarItem(inActiveItem: SvgPicture.asset(Assets.unSelectedHome), activeItem: SvgPicture.asset(Assets.selectedHome)),
          BottomBarItem(inActiveItem: SvgPicture.asset(Assets.maintenance), activeItem: SvgPicture.asset(Assets.selectedMaintenance)),
          BottomBarItem(inActiveItem: SvgPicture.asset(Assets.unSelectMessage), activeItem: SvgPicture.asset(Assets.selectedMessage)),
          BottomBarItem(inActiveItem: SvgPicture.asset(Assets.projects), activeItem: SvgPicture.asset(Assets.selectedProjects)),
          BottomBarItem(inActiveItem: SvgPicture.asset(Assets.unSelectedMenu), activeItem: SvgPicture.asset(Assets.selectedMenu)),
        ],
        onTap: (value) {
          selectedIndex = value;
          _controller.index = value;
          //_pageController.jumpToPage(value);

          print(selectedIndex);
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

/*class HomeScreenBody extends StatelessWidget {
  HomeScreenBody({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackGround,

      // backgroundColor:
      // bottomcontroller.selectedIndex.value != 0
      //     ? ColorConstraints.white
      //     :
      //  Colors.transparent,
      */ /*appBar:
            // bottomcontroller.selectedIndex.value != 0
            //     ? null
            //     :
            AppBar(
          title: Image.asset(
            Assets.appLoage,
            width: 100,
            color: AppColors.primaryColor,
          ),
          elevation: 0.0,
          actions: const [],
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // debugPrint("${za.toggle}");
              za.toggle!();
              // za.open!();
            },
          ),
        ),*/ /*
      body: bottomController.screenList[bottomController.selectedIndex.value],
      */ /*floatingActionButton: FloatingActionButton(
          onPressed: () {},
          //params
        ),*/ /*
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        bottomBarItems: [
          BottomBarItem(inActiveItem: SvgPicture.asset(Assets.unSelectedHome), activeItem: SvgPicture.asset(Assets.selectedHome)),
          BottomBarItem(inActiveItem: SvgPicture.asset(Assets.maintenance), activeItem: SvgPicture.asset(Assets.selectedMaintenance)),
          BottomBarItem(inActiveItem: SvgPicture.asset(Assets.messageChat), activeItem: SvgPicture.asset(Assets.message)),
          BottomBarItem(inActiveItem: SvgPicture.asset(Assets.projects), activeItem: SvgPicture.asset(Assets.selectedProjects)),
          BottomBarItem(inActiveItem: SvgPicture.asset(Assets.unSelectedMenu), activeItem: SvgPicture.asset(Assets.selectedMenu)),
        ],
        onTap: (value) {
          print(value);
          bottomController.selectedIndex.value = value;
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}*/

/*
BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: GetBuilder(
            init: bottomController,
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
                            bottomController.selectedIndex.value = 0;
                            bottomController.update();
                            za.close!();
                          },
                          icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (bottomController.selectedIndex.value == 0)
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
                            bottomController.selectedIndex.value = 1;
                            bottomController.update();
                            za.close!();
                          },
                          icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (bottomController.selectedIndex.value == 1)
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
                            bottomController.selectedIndex.value = 2;
                            bottomController.update();
                            za.close!();
                          },
                          icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (bottomController.selectedIndex.value == 2)
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
                            bottomController.selectedIndex.value = 3;
                            bottomController.update();
                            za.close!();
                          },
                          icon: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (bottomController.selectedIndex.value == 3)
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
        )
 */

// class HomeScreenBody extends StatelessWidget {
//   HomeScreenBody({Key? key}) : super(key: key);
//   // var _bottomNavIndex = 0;
//   BottombarController bottomcontroller = Get.put(BottombarController());

//   // late AnimationController controller = AnimationController(
//   @override
//   Widget build(BuildContext context) {
//     return Obx((() => Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           decoration: bottomcontroller.selectedIndex.value != 0
//               ? null
//               : BoxDecoration(
//                   gradient: LinearGradient(
//                   begin: Alignment(-1.0, -1),
//                   end: Alignment(-1.0, 1),
//                   colors: [
//                     ColorConstraints.primarycolor,
//                     ColorConstraints.primarycolor,
//                     Colors.white,
//                     Colors.white,
//                     // Colors.transparent,
//                   ],
//                 )),
//           child: Scaffold(
//               backgroundColor: bottomcontroller.selectedIndex.value != 0
//                   ? ColorConstraints.white
//                   : Colors.transparent,
//               appBar: bottomcontroller.selectedIndex.value != 0
//                   ? null
//                   : AppBar(
//                       backgroundColor: Colors.transparent,
//                       centerTitle: true,
//                       title: Image.asset(
//                         "assets/images/login.jpg",
//                       ),
//                       elevation: 0.0,
//                       actions: [],
//                       leading: IconButton(
//                         icon: Icon(Icons.draw_rounded),
//                         onPressed: () {
//                           // debugPrint("${za.toggle}");
//                           za.toggle!();
//                           // za.open!();
//                         },
//                       ),
//                     ),
//               // body: HomeScreen(),

//               body: bottomcontroller.screenList
//                   .elementAt(bottomcontroller.selectedIndex.value),
//               floatingActionButton: FloatingActionButton(
//                 backgroundColor: ColorConstraints.primarycolor,
//                 //Floating action button on Scaffold
//                 onPressed: () {
//                   // Get.to(LearningScreen());
//                   // bottomcontroller.selectedIndex.value = 4;
//                   bottomcontroller.onItemTapped(4);
//                 },
//               ),
//               floatingActionButtonLocation:
//                   FloatingActionButtonLocation.centerDocked,
//               bottomNavigationBar: Bottomnavbar()),
//         )));
//   }
// }

class Menubutton extends StatelessWidget {
  final menutext;
  final menuicon;

  const Menubutton({
    super.key,
    required this.menutext,
    required this.menuicon,
  });

  @override
  Widget build(BuildContext context) {
    final MaindartController mainlang = Get.put(MaindartController());

    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.3), // Adjust the color as needed
          ),
        ),
      ),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -2),
        dense: true,
        minLeadingWidth: 0,
        leading: Icon(menuicon),
        title: Text(
          '$menutext',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
/*
GetX(
      init: maindartControl,
      builder: (contextbuilder) {
        return ZoomDrawer(
          isRtl: maindartControl.directionrlt.value,
          controller: za,
          reverseDuration: const Duration(milliseconds: 100),
          borderRadius: 24,

          // showShadow: true,
          openCurve: Curves.fastOutSlowIn,
          slideWidth: MediaQuery.of(context).size.width * 0.77,
          // duration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 100),
          // showShadow: true,
          // angle: -30.0,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 20,
              blurRadius: 22,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          angle: 0.0,
          drawerShadowsBackgroundColor: Colors.grey,
          moveMenuScreen: false,
          // isRtl: true,
          menuScreenWidth: MediaQuery.of(context).size.width,
          menuBackgroundColor: AppColors.scaffoldBackGround,
          mainScreen: HomeScreenBody(),
          menuScreen: Theme(
            data: ThemeData.dark(),
            child: Scaffold(
              backgroundColor: AppColors.scaffoldBackGround,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          Assets.appLogo,
                          width: 200,
                        ),
                      ],
                    ),
                    /* ListView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tiles.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (index == 0) {
                                    bottomcontroller.selectedIndex.value = 0;
                                    bottomcontroller.update();
                                    za.close!();
                                  } else if (index == 1) {
                                    bottomcontroller.selectedIndex.value = 1;
                                    bottomcontroller.update();
                                    za.close!();
                                  } else if (index == 2) {
                                    bottomcontroller.selectedIndex.value = 2;
                                    bottomcontroller.update();
                                    za.close!();
                                  } else if (index == 3) {
                                    Get.to(const PrivacyPolicyScreen());
                                    za.close!();
                                  } else if (index == 4) {
                                    Get.to(const ContactUsScreen());
                                    //  Get.to(StaticLoginHomeScreen());
                                    za.close!();
                                  }
                                  debugPrint('$index');
                                },
                                child: Menubutton(menutext: tiles[index]['text'], menuicon: tiles[index]['icon']),
                              ),
                            ],
                          );
                        },),*/
                  ],
                ),
              ),
            ),
          ),
        );
      },
    )
 */
