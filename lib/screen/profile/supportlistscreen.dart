import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/supportlistcontroller.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SupportListScreen extends StatelessWidget {
  const SupportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(SupportListController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyComplains'.tr,
          style: Styles.styleHeader,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                    //provider.holidayListFilter();
                    model.selected.value = model.filterLabel[index];
                    model.filterList();
                  },
                  customTextStyles: [
                    Styles.style14500.copyWith(
                      color: model.indexSelected.value == 0 ? AppColors.white : AppColors.primaryColor,
                    ),
                    Styles.style14500.copyWith(
                      color: model.indexSelected.value == 1 ? AppColors.white : AppColors.primaryColor,
                    ),
                    Styles.style14500.copyWith(
                      color: model.indexSelected.value == 2 ? AppColors.white : AppColors.primaryColor,
                    ),
                    Styles.style14500.copyWith(
                      color: model.indexSelected.value == 3 ? AppColors.white : AppColors.primaryColor,
                    ),
                  ],
                  labels: model.filterLabel,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.filteredList.length,
                    itemBuilder: (context, index) {
                      final support = model.filteredList[index];
                      return InkWell(
                        onTap: () {
                          model.onSupportClicked(support);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 3),
                          child: Container(
                            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
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
                                            style: Styles.style12400
                                                .copyWith(color: support.status == 'Solved' ? AppColors.green : AppColors.hintOrange),
                                          ),
                                          5.ESW(),
                                          Text(
                                            support.query_date,
                                            style: Styles.style12400.copyWith(color: AppColors.subTextColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Icon(Icons.arrow_forward_ios_sharp),
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
        ),
      ),
    );
  }
}
