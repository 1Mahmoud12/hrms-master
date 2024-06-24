import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/tadalistcontroller.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TadaScreen extends StatelessWidget {
  const TadaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(TadaListController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Tada'.tr,
          style: Styles.styleHeader,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          model.onTadaCreateClicked();
        },
        child: const Icon(
          Icons.add,
          color: AppColors.scaffoldBackGround,
        ),
      ),
      // body: Obx(
      //   () => SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.all(15.0),
      //       child: RefreshIndicator(
      //         onRefresh: () {
      //           return model.getTadaList();
      //         },
      //         child: ListView.builder(
      //           itemCount: model.tadaList.length,
      //           itemBuilder: (context, index) {
      //             Tadaother item = model.tadaList[index];
      //             return Container(
      //               margin: EdgeInsets.symmetric(vertical: 8),
      //               child: ListTile(
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.only(
      //                         topLeft: Radius.circular(10),
      //                         topRight: Radius.circular(0),
      //                         bottomLeft: Radius.circular(0),
      //                         bottomRight: Radius.circular(10))),
      //                 tileColor: Colors.white38,
      //                 onTap: () {
      //                   model.onTadaClicked(item.id.toString());
      //                 },
      //                 textColor: Colors.white,
      //                 iconColor: Colors.white,
      //                 title: Text(
      //                   item.title,
      //                   style: TextStyle(fontSize: 18),
      //                 ),
      //                 subtitle: Text(
      //                   item.submittedDate,
      //                   style: TextStyle(color: Colors.grey),
      //                 ),
      //                 trailing: GestureDetector(
      //                   onTap: () {
      //                     if (item.status == "Accepted") {
      //                       showToast("Accepted TADA can't be edited");
      //                     } else {
      //                       model.onTadaEditClicked(item.id.toString());
      //                     }
      //                   },
      //                   child: Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: Icon(Icons.edit),
      //                   ),
      //                 ),
      //                 leading: Card(
      //                   color: item.status == "Pending"
      //                       ? Colors.orange
      //                       : item.status == "Rejected"
      //                           ? Colors.red
      //                           : Colors.green,
      //                   shape: CircleBorder(),
      //                   child: Padding(
      //                     padding: const EdgeInsets.all(15),
      //                     child: Text(
      //                       item.status == "Pending"
      //                           ? "P"
      //                           : item.status == "Rejected"
      //                               ? "R"
      //                               : "A",
      //                       style: TextStyle(
      //                           color: Colors.white,
      //                           fontWeight: FontWeight.bold,
      //                           fontSize: 18),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: Obx(
        () => Column(
          children: [
            ToggleSwitch(
              cornerRadius: 20,
              activeBgColor: const [AppColors.primaryColor],
              activeFgColor: Colors.white,
              inactiveFgColor: AppColors.primaryColor,
              inactiveBgColor: AppColors.greyWhite,
              minWidth: Get.width * 0.4,
              minHeight: 34,
              initialLabelIndex: model.indexSelected.value,
              totalSwitches: 4,
              onToggle: (index) {
                model.indexSelected.value = index!;
                model.selected.value = model.tadaListLabels[index];
                model.filterList();
              },
              animationDuration: 500,
              curve: Curves.linear,
              animate: true,
              customTextStyles: [
                Styles.style14500.copyWith(color: model.indexSelected.round() == 0 ? AppColors.white : AppColors.primaryColor),
                Styles.style14500.copyWith(color: model.indexSelected.round() == 1 ? AppColors.white : AppColors.primaryColor),
                Styles.style14500.copyWith(color: model.indexSelected.round() == 2 ? AppColors.white : AppColors.primaryColor),
                Styles.style14500.copyWith(color: model.indexSelected.round() == 3 ? AppColors.white : AppColors.primaryColor),
              ],
              labels: model.tadaListLabels,
            ),
            /*Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
              color: Colors.transparent,
              elevation: 0,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              model.selected.value = "All";
                              model.filterList();
                            },
                            child: Card(
                              elevation: 0,
                              color: model.selected.value == "All" ? Colors.white24 : Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                                child: Text(
                                  "All".tr,
                                  style: TextStyle(
                                      color: model.selected.value == "All" ? Color(0xff635F54) : Color(0xff979797),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              model.selected.value = "Pending";
                              model.filterList();
                            },
                            child: Card(
                              elevation: 0,
                              color: model.selected.value == "Pending" ? Colors.white24 : Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                                child: Text(
                                  "Pending".tr,
                                  style: TextStyle(
                                      color: model.selected.value == "Pending" ? Color(0xff635F54) : Color(0xff979797),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              model.selected.value = "Accepted";
                              model.filterList();
                            },
                            child: Card(
                              elevation: 0,
                              color: model.selected.value == "Accepted" ? Colors.white24 : Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                                child: Text(
                                  "Accepted".tr,
                                  style: TextStyle(
                                      color: model.selected.value == "Accepted" ? Color(0xff635F54) : Color(0xff979797),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              model.selected.value = "Rejected";
                              model.filterList();
                            },
                            child: Card(
                              elevation: 0,
                              color: model.selected.value == "Rejected" ? Colors.white24 : Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                                child: Text(
                                  "Rejected".tr,
                                  style: TextStyle(
                                      color: model.selected.value == "Rejected" ? Color(0xff635F54) : Color(0xff979797),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),*/
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: model.filteredList.length,
                itemBuilder: (context, index) {
                  final support = model.filteredList[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 4),
                    child: InkWell(
                      onTap: () {
                        model.onTadaClicked(support.id.toString());
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    support.title,
                                    style: Styles.style16700,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        support.status,
                                        style: Styles.style12400.copyWith(
                                          color: support.status == model.tadaListLabels[2]
                                              ? AppColors.green
                                              : support.status == model.tadaListLabels[3]
                                                  ? AppColors.red
                                                  : AppColors.hintOrange,
                                        ),
                                      ),
                                      5.ESW(),
                                      Text(
                                        support.submittedDate,
                                        style: Styles.style12400.copyWith(color: AppColors.subTextColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
