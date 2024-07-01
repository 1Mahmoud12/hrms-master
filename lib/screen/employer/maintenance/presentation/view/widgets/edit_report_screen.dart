import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/reportMalfunctionBloc/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/reportMalfunctionBloc/state.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditReportScreen extends StatelessWidget {
  const EditReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report Edit',
          style: Styles.styleHeader,
        ),
      ),
      body: BlocBuilder<ReportMalfunctionCubit, ReportState>(
        builder: (context, state) {
          final cubit = ReportMalfunctionCubit.of(context);
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            children: [
              Text(
                'Maintenance Engineer',
                style: Styles.style16700,
              ),
              TextField(
                controller: cubit.maintenanceEngineerController,
                cursorOpacityAnimates: true,
                decoration: const InputDecoration(
                  hintText: 'Maintenance Engineer',
                  fillColor: Colors.white,
                  filled: true,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor)),
                  hoverColor: AppColors.primaryColor,
                  enabledBorder: InputBorder.none,
                ),
              ),
              5.ESH(),
              Text(
                'Report Date',
                style: Styles.style16700,
              ),
              TextField(
                controller: cubit.reportDateController,
                cursorOpacityAnimates: true,
                decoration: const InputDecoration(
                  hintText: 'Report Date',
                  fillColor: Colors.white,
                  filled: true,
                  focusColor: AppColors.primaryColor,
                  hoverColor: AppColors.primaryColor,
                ),
              ),
              5.ESH(),
              Text(
                'Customer Name',
                style: Styles.style16700,
              ),
              TextField(
                controller: cubit.customerNameController,
                cursorOpacityAnimates: true,
                decoration: const InputDecoration(
                  hintText: 'Customer Name',
                  fillColor: Colors.white,
                  filled: true,
                  focusColor: AppColors.primaryColor,
                  hoverColor: AppColors.primaryColor,
                ),
              ),
              5.ESH(),
              Text(
                'phone',
                style: Styles.style16700,
              ),
              TextField(
                controller: cubit.phoneController,
                cursorOpacityAnimates: true,
                decoration: const InputDecoration(
                  hintText: 'phone',
                  fillColor: Colors.white,
                  filled: true,
                  focusColor: AppColors.primaryColor,
                  hoverColor: AppColors.primaryColor,
                ),
              ),
              5.ESH(),
              Text(
                'address',
                style: Styles.style16700,
              ),
              TextField(
                controller: cubit.addressController,
                cursorOpacityAnimates: true,
                decoration: const InputDecoration(
                  hintText: 'address',
                  fillColor: Colors.white,
                  filled: true,
                  focusColor: AppColors.primaryColor,
                  hoverColor: AppColors.primaryColor,
                ),
              ),
              5.ESH(),
              Text(
                'Details Report',
                style: Styles.style16700,
              ),
              TextField(
                controller: cubit.detailsReportController,
                cursorOpacityAnimates: true,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Details Report',
                  fillColor: Colors.white,
                  filled: true,
                  focusColor: AppColors.primaryColor,
                  hoverColor: AppColors.primaryColor,
                ),
              ),
              /*CustomTextFormField(
                controller: cubit.reportDateController,
                hintText: 'Report Date',
                fillColor: Colors.white,
                labelText: Text(
                  'Report Date',
                  style: Styles.style14500.copyWith(color: Colors.blue),
                ),
              ),*/
              /*CustomTextFormField(
                controller: cubit.customerNameController,
                hintText: 'Customer Name',
                fillColor: Colors.white,
                labelText: Text(
                  'Customer Name',
                  style: Styles.style14500.copyWith(color: Colors.blue),
                ),
              ),*/
              /*CustomTextFormField(
                controller: cubit.phoneController,
                hintText: 'phone',
                textInputType: TextInputType.number,
                fillColor: Colors.white,
                labelText: Text(
                  'phone',
                  style: Styles.style14500.copyWith(color: Colors.blue),
                ),
              ),*/
              /*CustomTextFormField(
                controller: cubit.addressController,
                hintText: 'address',
                fillColor: Colors.white,
                labelText: Text(
                  'address',
                  style: Styles.style14500.copyWith(color: Colors.blue),
                ),
              ),*/
              /*CustomTextFormField(
                controller: cubit.detailsReportController,
                hintText: 'Details Report',
                maxLines: 15,
                fillColor: Colors.white,
                labelText: Text(
                  'Details Report',
                  style: Styles.style14500.copyWith(color: Colors.blue),
                ),
              ),*/
              CustomTextButton(
                backgroundColor: AppColors.primaryColor,
                onPress: () {
                  ReportMalfunctionCubit.of(context).updateReportMechanics(
                    maintenanceEngineer:
                        cubit.maintenanceEngineerController.text,
                    reportDate: cubit.reportDateController.text,
                    customerName: cubit.customerNameController.text,
                    phone: cubit.phoneController.text,
                    address: cubit.addressController.text,
                    detailsReport: cubit.detailsReportController.text,
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  'submit',
                  style: Styles.style14400.copyWith(color: AppColors.white),
                ),
              ),
            ].paddingDirectional(bottom: 10),
          );
        },
      ),
    );
  }
}
