import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/widgets/comments.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/widgets/status_project_details.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllProjectDetails extends StatelessWidget {
  const AllProjectDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    final String mainImage = arguments['mainImage'];
    final String titleProject = arguments['titleProject'];
    final String subTitleProject = arguments['subTitleProject'];

    const int newComments = 8;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleProject,
          style: Styles.styleHeader,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              mainImage,
            ),
            //20.ESH(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleProject,
                  style: Styles.style18700,
                ),
                //  10.ESH(),
                Text(
                  subTitleProject,
                  style: Styles.style14500.copyWith(color: AppColors.textColorTextFormField),
                ),
                Text(
                  subTitleProject,
                  style: Styles.style14500.copyWith(color: AppColors.textColorTextFormField),
                ),
                const StatusDetailsProject(),

                const Comments(
                  newComments: newComments,
                ),
              ].paddingDirectional(top: 10.h),
            ),
          ].paddingDirectional(start: 12.w, end: 12.w),
        ),
      ),
    );
  }
}
