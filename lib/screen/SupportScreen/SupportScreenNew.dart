import 'dart:io';

import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/supportcontroller.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:dropdown_button3/dropdown_button3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SupportScreenNew extends StatefulWidget {
  const SupportScreenNew({super.key});

  @override
  State<SupportScreenNew> createState() => _SupportScreenNewState();
}

class _SupportScreenNewState extends State<SupportScreenNew> {
  final model = Get.put(SupportController());

  int? selectedValue;
  int check1 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Platform.isAndroid
              ? const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
        ),
        actions: [
          InkWell(
            onTap: () {
              model.showList();
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
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
                    <path d="M3.20258 8.70024H20.7974M2.88539 15.1513C2.37154 13.0819 2.37154 10.9181 2.88539 8.84875C3.55805 6.13983 5.70602 4.04534 8.43056 3.44162L8.88443 3.34105C10.9366 2.88632 13.0634 2.88632 15.1156 3.34105L15.5694 3.44162C18.294 4.04534 20.442 6.13984 21.1146 8.84875C21.6285 10.9182 21.6285 13.0819 21.1146 15.1512C20.442 17.8602 18.294 19.9547 15.5694 20.5584L15.1156 20.659C13.0634 21.1137 10.9366 21.1137 8.88443 20.659L8.43056 20.5584C5.70601 19.9547 3.55805 17.8602 2.88539 15.1513Z" stroke="#635F54" stroke-width="1.5"/>
                    <path d="M7 12L11 12" stroke="#635F54" stroke-width="1.5" stroke-linecap="round"/>
                  </svg>
                  ''',
                    width: 25,
                    height: 25,
                    colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
        ],
        title: Text(
          'Support'.tr,
          style: Styles.styleHeader,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Form(
          key: model.form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 0,
                shape: ButtonBorder(),
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Help_desk'.tr,
                            style: Styles.style16700,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Get.width * 0.8,
                            child: Text(
                              // "Contact Us if any problem or complains\nneed to be addressed.",
                              'contact_us_if_any_problem_or_complains_need_to_be_addressed'.tr,
                              style: Styles.style14500.copyWith(color: AppColors.subTextColor),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              width: double.infinity,
                              child: DropdownButtonHideUnderline(
                                child: Obx(
                                  () => DropdownButton2(
                                    isExpanded: true,
                                    hint: Text(
                                      'Department'.tr,
                                      style: Styles.style14500.copyWith(color: AppColors.textColorTextFormField),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    items: model.getAllDepartment.map((e) {
                                      check1++;

                                      return DropdownMenuItem(
                                        value: e['id'],
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(
                                            e['dept_name'],
                                            style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      selectedValue = value! as int;
                                      if (selectedValue != null) {
                                        setState(() {});
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: AppColors.textColorTextFormField,
                                    ),
                                    //iconSize: 20.w,
                                    iconEnabledColor: Colors.black,
                                    iconDisabledColor: Colors.grey,
                                    buttonHeight: 50,
                                    buttonWidth: 160,
                                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                                    buttonDecoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      color: AppColors.fillColorTextFormField,
                                    ),
                                    buttonElevation: 0,
                                    itemHeight: 40,
                                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                                    dropdownMaxHeight: 200,
                                    dropdownDecoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      color: Colors.white,
                                    ),
                                    scrollbarRadius: const Radius.circular(40),
                                    scrollbarThickness: 6,
                                    scrollbarAlwaysShow: true,
                                    offset: const Offset(0, 0),
                                  ),
                                ),
                              ),
                            ),
                            CustomTextFormField(controller: model.titleController, hintText: 'Title'),
                            10.ESH(),
                            CustomTextFormField(controller: model.descriptionController, hintText: 'Description'),
                            10.ESH(),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Add Attachment'.tr,
                                style: Styles.style16700,
                              ),
                            ),
                            10.ESH(),
                            Container(
                              child: Row(
                                children: [
                                  SvgPicture.asset(Assets.pdfSVG),
                                  10.ESW(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PDF',
                                        style: Styles.style14400.copyWith(color: AppColors.subTextColor),
                                      ),
                                      Text(
                                        '${'Uploaded on'.tr} ${DateTime.now().toString().substring(0, 10)}',
                                        style: Styles.style14500.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10.w),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(29))),
          ),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            model.onSubmitClicked(selectedValue);
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Submit'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
