import 'package:cnattendance/Controller/translationController.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationScreen extends StatelessWidget {
  const TranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final control = Get.put(TranslationController());

    return Scaffold(
      appBar: AppBar(

        title: Text(
          'translation'.tr,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(29)),),
            ),
            onPressed: () {
              control.updatetranslation();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Submit'.tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
      body: GetBuilder(
        init: control,
        builder: (context) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 0,
                    shape: ButtonBorder(),
                    color: Colors.transparent,
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: Get.height * 1,
                                width: Get.width * 0.9,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                itemCount: control.radioItems.length,
                                itemBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: Get.height * 0.06,
                                      child: ListTile(
                                        title: Text(control.radioItems[index]),
                                      trailing: Radio(
                                          activeColor: AppColors.primaryColor,
                                        value: control.radioItems[index],
                                        groupValue: control.selectedValue,
                                        onChanged: (value) {
                                          control.updateonchangevalue(
                                            value.toString(),);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Display the selected value.
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },),
    );
  }
}
