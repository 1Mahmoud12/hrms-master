import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/createtadacontroller.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateTadaScreen extends StatelessWidget {
  const CreateTadaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(CreateTadaController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'create_tada'.tr,
          style: Styles.styleHeader,
        ),
        elevation: 0,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(29))),
            ),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              model.checkForm();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: model.key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(controller: model.titleController, hintText: 'Title'),
                10.ESH(),
                CustomTextFormField(controller: model.descriptionController, hintText: 'Description', maxLines: 5),
                10.ESH(),
                CustomTextFormField(
                  controller: model.expensesController,
                  hintText: 'TotalExpenses',
                  textInputType: TextInputType.number,
                ),
                10.ESH(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'AddAttachment'.tr,
                    style: Styles.style16700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                10.ESH(),
                GestureDetector(
                  onTap: () {
                    model.onFileClicked();
                  },
                  child: const Card(
                    shape: CircleBorder(),
                    color: AppColors.primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: model.fileList.length,
                    itemBuilder: (context, index) {
                      final file = model.fileList[index];
                      return ListTile(
                        title: Text(
                          file.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            model.removeItem(index);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
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
