import 'package:cnattendance/Controller/translationController.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationScreen extends StatelessWidget {
  const TranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Control = Get.put(TranslationController());

    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              child: Image.asset('assets/icons/backicon.png'),
            ),
          ),
          title: Text(
            'translation'.tr,
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
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xff635f54),
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(29)),),
              ),
              onPressed: () {
                Control.updatetranslation();
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
        backgroundColor: Colors.transparent,
        body: GetBuilder(
            init: Control,
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
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: Get.height * 1,
                                  width: Get.width * 0.9,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: Control.radioItems.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        height: Get.height * 0.06,
                                        child: ListTile(
                                          title:
                                              Text(Control.radioItems[index]),
                                          trailing: Radio(
                                            activeColor: const Color(0xff635f54),
                                            value: Control.radioItems[index],
                                            groupValue: Control.selectedValue,
                                            onChanged: (value) {
                                              Control.updateonchangevalue(
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
      ),
    );
  }
}
