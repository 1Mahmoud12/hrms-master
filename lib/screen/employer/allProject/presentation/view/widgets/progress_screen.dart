import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/ProjectsScreen/widgets/card_project.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/progressBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/progressBloc/state.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    final int progressRatio = argument['progressRatio'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Progress',
          style: Styles.styleHeader.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.addProgressScreen);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<ProgressCubit, ProgressState>(
        builder: (context, state) => ListView(
          padding: EdgeInsets.all(context.screenWidth * .02),
          children: [
            ...List.generate(
              ProgressCubit.of(context).steps.length,
              (index) => Container(
                margin: EdgeInsets.all(context.screenWidth * .02),
                padding: EdgeInsets.all(context.screenWidth * .02),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), color: AppColors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: context.screenWidth * .4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: AppColors.cBackGroundIconButton, borderRadius: BorderRadius.circular(10.r)),
                      child: SvgPicture.asset(ProgressCubit.of(context).steps[index]['assets']),
                    ),
                    10.ESW(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ProgressCubit.of(context).steps[index]['nameStep'],
                          style: Styles.style14500.copyWith(fontSize: 15.sp, color: AppColors.textColorTextFormField),
                        ),
                        5.ESH(),
                        SizedBox(
                          width: context.screenWidth * .5,
                          child: Text(ProgressCubit.of(context).steps[index]['description']),
                        ),
                        SizedBox(
                          height: context.screenHeight * .002,
                          width: context.screenWidth * .5,
                          child: SliderTheme(
                            data: SliderThemeData(
                              trackShape: CustomTrackShape(),
                              //thumbColor: Colors.transparent,
                              thumbShape: SliderComponentShape.noThumb,
                              trackHeight: 2,
                            ),
                            child: Slider(
                              value: double.parse(ProgressCubit.of(context).steps[index]['value']) / 100,
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      double.parse(ProgressCubit.of(context).steps[index]['value']) == 1.0
                          ? 'Done'
                          : double.parse(ProgressCubit.of(context).steps[index]['value']) == 0.0
                              ? 'Pending'
                              : 'In Progress',
                      style: Styles.style14400.copyWith(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
