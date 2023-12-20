import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/services/googleMap/google_map_no_scaffold.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/mainBlocMaintenance/state.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/view/widgets/attachment.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsMaintenance extends StatefulWidget {
  const DetailsMaintenance({super.key});

  @override
  State<DetailsMaintenance> createState() => _DetailsMaintenanceState();
}

class _DetailsMaintenanceState extends State<DetailsMaintenance> {
  @override
  Widget build(BuildContext context) {
    final argument = context.getArguments;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final String nameStatus = argument['nameStatus'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          nameStatus,
          style: Styles.style18700,
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: context.screenWidth * .95,
          child: CustomTextButton(
            onPress: () {
              showToast('Your request has been sent successfully');
              Navigator.pushNamed(context, AppRoute.paymentMaintenanceValue);
              /* Navigator.pop(context);
              Navigator.pop(context);*/
            },
            backgroundColor: AppColors.primaryColor,
            child: Text(
              'submit',
              style: Styles.style16700.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ],
      body: ListView(
        children: [
          CustomTextFormField(
            controller: nameController,
            hintText: 'name',
            fillColor: AppColors.white,
          ),
          CustomTextFormField(
            controller: descriptionController,
            hintText: 'Description',
            maxLines: 5,
            fillColor: AppColors.white,
          ),
          BlocBuilder<MainBlocMaintenanceCubit, MainBlocMaintenanceState>(
            builder: (context, state) => Text(
              'location: $locationCache',
              style: Styles.style16700,
            ),
          ),
          GoogleMapWithoutScaffold(cubit: MainBlocMaintenanceCubit.of(context)),
          const AttachmentsReportCustomer()
        ].paddingDirectional(
          start: 10.w,
          end: 10.w,
          bottom: 10.h,
        ),
      ),
    );
  }
}
