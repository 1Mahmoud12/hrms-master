import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/prefprovider.dart';
import 'package:cnattendance/screen/employer/staticloginhome/staticcontactformscreen.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:cnattendance/widget/deactivate_bottom_sheet.dart';
import 'package:cnattendance/widget/log_out_bottom_sheet.dart';
import 'package:cnattendance/widget/profile/heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class StaticLoginHomeScreen extends StatefulWidget {
  const StaticLoginHomeScreen({super.key});

  @override
  State<StaticLoginHomeScreen> createState() => _StaticLoginHomeScreenState();
}

class _StaticLoginHomeScreenState extends State<StaticLoginHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Styles.styleHeader,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            //color: Colors.black,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                20.ESH(),
                const Heading(),
                /*Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/images/dummy_avatar.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),*/
                // Text(
                //   'Hellothere'.tr,
                //   style: TextStyle(color: Colors.white, fontSize: 12),
                // ),
                /*Text(
                  provider.fullName,
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                ),*/
                // Text(
                //   provider.userName,
                //   style: TextStyle(color: Colors.white, fontSize: 16),
                // ),
                Text(
                  provider.email,
                  style: Styles.style14400,
                ),
                CustomTextButton(
                  onPress: () {
                    Get.to(const StaticContactFormScreen());
                  },
                  borderRadius: 30,
                  backgroundColor: AppColors.primaryColor,
                  child: Text('Support', style: Styles.style16700.copyWith(color: AppColors.white)),
                ),
                20.ESH(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      builder: (context) {
                        return const DeactivemodalSheet();
                      },
                    );
                  },
//                   showDialog<String>(
//                     context: context,
//                     builder: (BuildContext context) => AlertDialog(
//                       title: const Text('Delete Account'),
//                       content: const Text('Are you sure to delet account'),
//                       actions: <Widget>[
//                         TextButton(
//                           onPressed: () => Navigator.pop(context, 'Cancel'),
//                           child: Text(
//                             'Cancel',
//                             style: TextStyle(
//                                 color: ColorConstraints.primarycolor,
//                                 fontSize: 12),
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context, 'OK');
//                             const snackBar = SnackBar(
//                               content:
//                                   Text('Account will be deleted in 5 days'),
//                             );

// // Find the ScaffoldMessenger in the widget tree
// // and use it to show a SnackBar.
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(snackBar);
//                           },
//                           child: Text(
//                             'OK',
//                             style: TextStyle(
//                                 color: ColorConstraints.primarycolor,
//                                 fontSize: 12),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: AppColors.white),
                    child: ListTile(
                      trailing: const Icon(
                        Icons.delete,
                        color: AppColors.primaryColor,
                      ),
                      title: Text(
                        'Delete Account',
                        style: Styles.style16700.copyWith(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ),

                // IconButton(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.delete,
                //       color: Colors.white,
                //     )),

                // SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.height * .17,
        child: Column(
          children: [
            Container(
              width: context.screenWidth,
              margin: const EdgeInsets.all(40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    builder: (context) {
                      return const LogOutBottomSheet();
                    },
                  );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            20.ESH()
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.all(40),
      //   child: ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: Color(0xffffffff),
      //       shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.all(Radius.circular(50))),
      //     ),
      //     onPressed: () {},
      //     child: Text(
      //       "Logout",
      //       style: TextStyle(
      //           color: ColorConstraints.primarycolor,
      //           fontWeight: FontWeight.w900),
      //     ),
      //   ),
      // ),
    );
  }
}
/*FloatingActionButton(
        backgroundColor: const Color(0xffffffff),

      )*/
