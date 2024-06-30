import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_drop_down_menu.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/reportMalfunctionBloc/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/reportMalfunctionBloc/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/products_need_technical.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MaintenanceReportTechnicalMalfunction extends StatefulWidget {
  const MaintenanceReportTechnicalMalfunction({super.key});

  @override
  State<MaintenanceReportTechnicalMalfunction> createState() =>
      _MaintenanceReportTechnicalEmergincieState();
}

class _MaintenanceReportTechnicalEmergincieState
    extends State<MaintenanceReportTechnicalMalfunction> {
  TextEditingController reportDescription = TextEditingController();
  String selectedItem = 'Choose Status'.tr;
  String selectedProduct = '';
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;

    return BlocListener<ReportMalfunctionCubit, ReportState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Maintenance Report'.tr,
            style: Styles.styleHeader,
          ),
        ),
        persistentFooterButtons: [
          Center(
            child: CustomTextButton(
              onPress: () {
                // technical
                print('Eregncie ID======>${arguments['emrgencie_id']}');

                BlocProvider.of<ReportMalfunctionCubit>(context).addReport(
                  malfunctionId: userCache!.id.toString(),
                  description: reportDescription.text,
                  price: '2000',
                  status: selectedItem,
                  product: selectedProduct,
                );
                Navigator.pop(context);
              },
              backgroundColor: AppColors.primaryColor,
              child: Text(
                'submit'.tr,
                style: Styles.style14500.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .02),
          children: [
            CustomDropDownMenu(
              onItemSelected: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
              selectedItem: selectedItem,
              items: ['In progress'.tr, 'Pending'.tr, 'Finished'.tr],
            ),
            CustomTextFormField(
              controller: reportDescription,
              hintText: 'Write your report'.tr,
              maxLines: 6,
              fillColor: AppColors.white,
            ),
            ProductsNeedTechnical(
              onItemSelected: (value) {
                setState(() {
                  selectedProduct = value;
                });
              },
            ),
          ].paddingDirectional(bottom: context.screenHeight * .01),
        ),
      ),
    );
  }
}
