import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_drop_down_menu.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/products_need_technical.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';

class MaintenanceReportTechnical extends StatelessWidget {
  const MaintenanceReportTechnical({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Maintenance Report',
          style: Styles.styleHeader,
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: CustomTextButton(
            onPress: () {},
            backgroundColor: AppColors.primaryColor,
            child: Text(
              'submit',
              style: Styles.style14500.copyWith(color: AppColors.white),
            ),
          ),
        )
      ],
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .02),
        children: [
          const CustomDropDownMenu(selectedItem: 'Choose Status', items: ['In progress', 'Pending', 'Finished']),
          CustomTextFormField(
            controller: TextEditingController(),
            hintText: 'Write your report',
            maxLines: 6,
            fillColor: AppColors.white,
          ),
          const ProductsNeedTechnical()
        ].paddingDirectional(bottom: context.screenHeight * .01),
      ),
    );
  }
}
