import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String nameMaintenanceReport = 'Name Contract';
    const String location = 'Cairo';
    const int numberElevators = 15;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maintenance'.tr,
          style: Styles.styleHeader,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.screenWidth * .04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(Assets.cardPlans),
                  Column(
                    children: [
                      Text(
                        'Simple, transparent pricing',
                        style: Styles.style18700.copyWith(color: AppColors.white),
                      ),
                      Text(
                        'No contracts. No surprise fees.',
                        style: Styles.style12400.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ],
              ),*/
              Text(
                'Maintenance contracts'.tr,
                style: Styles.style16700,
              ),
              10.ESH(),
              ...List.generate(
                7,
                (index) => GestureDetector(
                  onTap: () {
                    final arguments = {
                      'nameMaintenanceReport': nameMaintenanceReport,
                      'startDate': '24 Aug',
                      'location': location,
                      'numberElevators': numberElevators,
                    };
                    Navigator.pushNamed(context, AppRoute.detailsMaintenanceWidget, arguments: arguments);
                  },
                  child: Container(
                    padding: EdgeInsets.all(context.screenWidth * .04),
                    margin: EdgeInsets.all(context.screenWidth * .02),
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(15.r)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: context.screenHeight * .01, horizontal: context.screenWidth * .02),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            //borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.cBackGroundDateMaintenance,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${nameMaintenanceReport.split(' ').first[0]}${nameMaintenanceReport.split(' ').length > 1 ? nameMaintenanceReport.split(' ').last[0] : ''}',
                              style: Styles.styleHeader.copyWith(color: AppColors.cDateMaintenance),
                            ),
                          ),
                        ),
                        10.ESW(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              nameMaintenanceReport,
                              style: Styles.style14500.copyWith(fontSize: 15.sp, color: AppColors.textColor, fontWeight: FontWeight.w700),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Elevators :',
                                  style: Styles.style14500.copyWith(color: AppColors.textColor, fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '$numberElevators',
                                  style: Styles.style14400.copyWith(color: AppColors.textColor),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // const Icon(Icons.location_on_outlined, color: AppColors.subTextColor),

                                Text(
                                  '14/Aug/2023 ==> 15/Sep/2024',
                                  style: Styles.style14500.copyWith(color: AppColors.subTextColor.withOpacity(.8), fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // const Icon(Icons.location_on_outlined, color: AppColors.subTextColor),

                                Text(
                                  'Status: ',
                                  style: Styles.style14500.copyWith(color: AppColors.textColor, fontWeight: FontWeight.w700),
                                ),
                                5.ESW(),
                                Text(
                                  'In progress',
                                  style: Styles.style14500.copyWith(color: AppColors.green, fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Location: ',
                                  style: Styles.style14500.copyWith(color: AppColors.textColor, fontWeight: FontWeight.w700),
                                ),
                                5.ESW(),
                                Text(
                                  'Cairo,Egypt',
                                  style: Styles.style14500.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.primaryColor,
                                  size: context.screenWidth * .05,
                                ),
                              ],
                            ),
                            5.ESH(),
                            SizedBox(
                              width: context.screenWidth * .5,
                              child: TextButton(
                                onPressed: null,
                                style: ButtonStyle(
                                    elevation: const MaterialStatePropertyAll(20),
                                    shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                                        side: BorderSide(color: AppColors.grey), borderRadius: BorderRadius.circular(20.r))),
                                    backgroundColor: const MaterialStatePropertyAll(AppColors.white)),
                                child: Text(
                                  'Show Reports',
                                  style: Styles.style14400.copyWith(color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                          ].paddingDirectional(bottom: 5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(_url) async {
    try {
      final bool launched = await launch(
        _url,
      );
      debugPrint('Launched  $launched');
    } catch (e) {
      await launch(
        _url,
      );
      debugPrint('Inside catch');
    }
  }
}

/*
const PropertyFlip(
                backimg: 'assets/images/projects-banner-2.jpg',
                misheading: 'Crafting a Connected Future',
                mispara: "Discover Dar Bayat's Exceptional Projects",
                misbackpara:
                    '''At Dar Bayat Development, we understand the importance of providing diverse housing solutions that cater to the unique needs and preferences of families across the Kingdom. Our focus on creating a wide range of residential options ensures that we contribute to a more inclusive, equitable society where everyone can find a place to call home.''',
              ),
              SizedBox(
                height: context.screenHeight * .34,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: leaderlist.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return PropertyComp(
                      leaderurl: leaderlist[index]['leaderurl'],
                      leaderimg: leaderlist[index]['leaderimg'],
                      leadername: leaderlist[index]['leadername'],
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _launchUrl('https://darbayat.sa/projects/');
                },
                style: ButtonStyle(
                  // Define the button's width
                  minimumSize: MaterialStateProperty.all(Size(Get.width * 0.4, 35)), // Adjust the width as needed

                  // Define the button's shape and border radius
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0), // Adjust the border radius as needed
                      side: const BorderSide(width: 2, color: Color(0xff635F54)), // Adjust the border color as needed
                    ),
                  ),

                  // Define the button's background color
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffcfcdcb)), // Adjust the background color as needed

                  // Define the text color when the button is pressed
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xff635F54),
                  ),
                ),
              ),
 */
class PropertyFlip extends StatelessWidget {
  final backimg;
  final misheading;
  final mispara;
  final misbackpara;

  const PropertyFlip({super.key, required this.backimg, required this.misbackpara, required this.misheading, required this.mispara});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: FlipCard(
        fill: Fill.fillBack,
        // The side to initially display.
        front: Container(
          height: 200,
          width: MediaQuery.of(context).size.width * .9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed

            image: DecorationImage(
              colorFilter: const ColorFilter.mode(AppColors.scaffoldBackGround, BlendMode.softLight),

              image: AssetImage(backimg), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    misheading,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    mispara,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        back: Container(
          width: MediaQuery.of(context).size.width * .9,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
            color: AppColors.white,
          ),
          child: Center(
            child: Text(
              misbackpara,
              style: const TextStyle(
                color: AppColors.scaffoldBackGround,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PropertyComp extends StatelessWidget {
  final leaderimg;
  final leadername;
  final leaderurl;

  const PropertyComp({super.key, required this.leaderimg, required this.leadername, required this.leaderurl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchUrl(leaderurl);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(left: 15, top: 5, bottom: 10),
        decoration: BoxDecoration(
          // color: ColorConstraints.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 240,
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 196,
                width: 175,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage(leaderimg),
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.9),
                      BlendMode.modulate,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Flexible(
                child: Text(
                  leadername,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20, color: AppColors.white, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(_url) async {
    try {
      final bool launched = await launch(
        _url,
      );
      debugPrint('Launched  $launched');
    } catch (e) {
      await launch(
        _url,
      );
      debugPrint('Inside catch');
    }
  }
}
