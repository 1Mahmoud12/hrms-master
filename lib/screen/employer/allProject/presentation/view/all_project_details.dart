import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/widgets/comments.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/widgets/status_project_details.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllProjectDetails extends StatelessWidget {
  const AllProjectDetails({super.key});

  @override
  Widget build(BuildContext context) {
    //  final arguments = ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    final String mainImage = Assets.temporaryProjects; //arguments['mainImage'] ?? '';
    final String titleProject = 'titleProject'; // arguments['titleProject'] ?? '';
    final String subTitleProject = 'subTitleProject'; //arguments['subTitleProject'] ?? '';

    const int newComments = 8;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleProject,
          style: Styles.styleHeader,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .02),
        child: Column(
            children: [
          Container(
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(15.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  mainImage,
                ),
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
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StatusDetailsProject(),
              const Comments(
                newComments: newComments,
              ),
            ].paddingDirectional(top: 10.h),
          ),
        ].paddingDirectional(bottom: context.screenHeight * .01)),
      ),
    );
  }
}
