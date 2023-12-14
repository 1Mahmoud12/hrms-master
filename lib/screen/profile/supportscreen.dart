import 'package:cnattendance/model/department.dart';
import 'package:cnattendance/provider/supportcontroller.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:dropdown_button3/dropdown_button3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(SupportController());
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('Support'),
          actions: [
            InkWell(
              onTap: () {
                model.showList();
              },
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Icon(Icons.list_alt),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: model.form,
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  elevation: 0,
                  shape: ButtonBorder(),
                  color: Colors.transparent,
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(Icons.support_agent_rounded,
                            color: Colors.white, size: 60,),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Help Desk',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Contact Us if any problem or complains\nneed to be addressed.',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: DropdownButtonHideUnderline(
                          child: Obx(
                            () => DropdownButton2(
                              isExpanded: true,
                              hint: const Text(
                                'Select Department Type',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: model.departments.map((Department e) {
                                return DropdownMenuItem(
                                  value: e.name,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,),
                                    child: Text(
                                      e.name,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,),
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: model.selected.value.name == ''
                                  ? null
                                  : model.selected.value.name,
                              onChanged: (value) {
                                print(value);

                                final result = model.departments
                                    .where((dep) => dep.name == value)
                                    .toList();
                                result.isNotEmpty
                                    ? model.selected.value = result[0]
                                    : model.selected.value;
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios_outlined,
                              ),
                              iconSize: 14,
                              iconEnabledColor: Colors.black,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),),
                                color: HexColor('#FFFFFF'),
                              ),
                              buttonElevation: 0,
                              itemHeight: 40,
                              itemPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              dropdownMaxHeight: 200,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),),
                                color: HexColor('#FFFFFF'),
                              ),
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: model.titleController,
                        textAlignVertical: TextAlignVertical.top,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field can't be empty";
                          }
                          return null;
                        },
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white24,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),),),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),),),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),),),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),),),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: model.descriptionController,
                        maxLength: 500,
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: 10,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Field can't be empty";
                          }
                          return null;
                        },
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          counterStyle: TextStyle(color: Colors.white),
                          hintText: 'Description',
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white24,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),),),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),),),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),),),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),),),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: HexColor('#036eb7'),
                              padding: EdgeInsets.zero,
                              shape: ButtonBorder(),
                            ),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              model.onSubmitClicked(1);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),),
                      ),
                    ],
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
