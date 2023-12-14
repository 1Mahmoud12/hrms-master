import 'package:cnattendance/provider/tadadetailcontroller.dart';
import 'package:cnattendance/screen/tadascreen/widget/attachmentbottomsheet.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

class TadaDetailScreen extends StatelessWidget {
  const TadaDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(TadaDetailController());
    return Container(
      decoration: RadialDecoration(),
      child: Obx(
        () => SafeArea(
          child: model.isLoading.value
              ? const SizedBox.shrink()
              : Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    actions: [
                      InkWell(
                        onTap: () {
                          model.onTadaEditClicked(
                              model.tada.value.id.toString(),);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SvgPicture.string(
                                '''
                 <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
  <path d="M16.5 9.13608C14.682 9.7421 12.2579 7.31804 12.8639 5.5M13.6109 4.75306L9.69403 8.66988C7.99123 10.3727 6.78322 12.5063 6.19917 14.8425L6.00991 15.5995C5.95094 15.8354 6.1646 16.0491 6.40049 15.9901L7.15752 15.8008C9.49375 15.2168 11.6273 14.0088 13.3301 12.306L17.2469 8.38914C17.7291 7.90697 18 7.253 18 6.5711C18 5.15112 16.8489 4 15.4289 4C14.747 4 14.093 4.27088 13.6109 4.75306Z" stroke="#635F54" stroke-width="1.5"/>
  <path d="M19 20H5" stroke="#635F54" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
                    ''',
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Image.asset('assets/icons/backicon.png'),
                      ),
                    ),
                    title: Text(
                      'Details'.tr,
                      style: const TextStyle(
                        color: Color(0xff635F54),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  // bottomNavigationBar: Obx(
                  //   () => Container(
                  //     padding: EdgeInsets.symmetric(horizontal: 20),
                  //     height: 50,
                  //     child: Row(
                  //       children: [
                  //         Card(
                  //           elevation: 0,
                  //           color: model.tada.value.status == "Pending"
                  //               ? Colors.orange.shade500
                  //               : model.tada.value.status == "Rejected"
                  //                   ? Colors.red.shade500
                  //                   : Colors.green.shade500,
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Text(model.tada.value.status,
                  //                 style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontSize: 18,
                  //                   fontWeight: FontWeight.bold,
                  //                 )),
                  //           ),
                  //         ),
                  //         Spacer(),
                  //         Text(
                  //           "Total ",
                  //           style: TextStyle(color: Colors.grey, fontSize: 18),
                  //         ),
                  //         Text("Rs " + model.tada.value.expenses.toString(),
                  //             style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.bold,
                  //             )),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  body: Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Title'.tr,
                            style: const TextStyle(
                                color: Color(0xff635F54), fontSize: 15,),
                          ),
                          Text(
                            model.tada.value.title,
                            style: const TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Description'.tr,
                            style: const TextStyle(
                                color: Color(0xff635F54), fontSize: 15,),
                          ),
                          Text(
                            parse(model.tada.value.description ?? '')
                                .body!
                                .text,
                            style: const TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                  AttachmentBottomSheet(
                                      model.tada.value.attachments!,),
                                  isDismissible: true,
                                  enableDrag: true,
                                  isScrollControlled: true,
                                  ignoreSafeArea: true,);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Attachments'.tr,
                                        style: const TextStyle(
                                          color: Color(0xff635F54),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' ( ${model.tada.value.attachments!.length} )',
                                        style: const TextStyle(
                                          color: Colors
                                              .black, // Change this to the desired style for the bracketed value
                                          fontSize:
                                              16, // Change this to the desired style for the bracketed value
                                          fontWeight: FontWeight
                                              .bold, // Change this to the desired style for the bracketed value
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Color(0xff635F54),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Verifiedby'.tr,
                            style: const TextStyle(
                                color: Color(0xff635F54), fontSize: 15,),
                          ),
                          Text(
                            parse(model.tada.value.verifiedBy ?? 'N/A')
                                .body!
                                .text,
                            style: const TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
