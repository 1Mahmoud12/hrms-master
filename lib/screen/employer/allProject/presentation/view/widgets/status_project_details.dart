import 'package:cnattendance/core/component/cache_image.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/overViewProjectBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/overViewProjectBloc/state.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/widgets/one_status_row.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/view/widgets/status_project_method.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

class StatusDetailsProject extends StatelessWidget {
  const StatusDetailsProject({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Get.put(ProjectDetailController());

    return BlocProvider(
      create: (context) => OverViewProjectCubit(),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: Styles.style16700,
            ),
            OneStatusRow(
              button: true,
              onPress: () {
                final arguments = {
                  //  'progressRatio': 80,
                };
                Navigator.pushNamed(context, AppRoute.detailsContractProject, arguments: arguments);
              },
              assetsName: Assets.detailsContract,
              nameRow: 'Contract Details',
            ),
            InkWell(
              onTap: () {
                final arguments = {
                  'progressRatio': 80,
                };
                Navigator.pushNamed(context, AppRoute.progressScreen, arguments: arguments);
              },
              child: Container(
                height: context.screenHeight * .094,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(15.r)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(color: AppColors.cBackGroundIconButton, borderRadius: BorderRadius.circular(8.r)),
                      child: SvgPicture.asset(
                        Assets.progress,
                        width: context.screenWidth * .05,
                        colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                      ),
                    ),
                    20.ESW(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Progress',
                          style: Styles.style14400.copyWith(color: AppColors.textColorTextFormField),
                        ),
                        /*Text(
                          'Last Update: 5 mins ago',
                          style: Styles.style12400.copyWith(fontSize: 9.sp, color: AppColors.textColorTextFormField),
                        ),*/
                        /* SizedBox(
                          height: context.screenHeight * .002,
                          width: context.screenWidth * .4,
                          child: SliderTheme(
                            data: SliderThemeData(
                              trackShape: CustomTrackShape(),
                              //thumbColor: Colors.transparent,
                              thumbShape: SliderComponentShape.noThumb,
                              trackHeight: 2,
                            ),
                            child: Slider(
                              value: .8,
                              onChanged: (value) {},
                            ),
                          ),
                        ),*/
                      ],
                    ),
                    // if (anotherWidgetBool) const Spacer(),
                    //if (anotherWidgetBool) anotherWidget ?? Container(),
                    const Spacer(),
                    SvgPicture.asset(Assets.arrowIOS),
                  ],
                ),
              ),
            ),
            if (genderUser == RoleId.ten.name.tr || genderUser == RoleId.nine.name.tr)
              OneStatusRow(
                button: true,
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.tasksScreen,
                  );
                },
                assetsName: Assets.tasksSVG,
                nameRow: 'Tasks',
              ),
            if (genderUser == RoleId.twelve.name.tr || genderUser == RoleId.nine.name.tr || genderUser == RoleId.eight.name.tr)
              OneStatusRow(
                button: true,
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.proposalScreen,
                  );
                },
                assetsName: Assets.tasksSVG,
                nameRow: 'Proposal',
              ),
            if (genderUser == RoleId.eight.name.tr)
              OneStatusRow(
                button: true,
                onPress: () {
                  Navigator.pushNamed(
                    context,
                    AppRoute.payments,
                  );
                },
                assetsName: Assets.payment,
                nameRow: 'Payments',
              ),
            OneStatusRow(
              button: true,
              onPress: () {
                Navigator.pushNamed(context, AppRoute.teamProjectScreen);
              },
              assetsName: Assets.users,
              nameRow: 'Teams',
              anotherWidget: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ...List.generate(
                        model.project.value.members.length > 5 ? 5 : model.project.value.members.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(left: index * 12.0),
                          child: CacheImage(
                            imageUrl: model.project.value.members[index].image,
                            width: 20,
                            height: 20,
                            circle: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5 * 12.0),
                        child: Container(
                          //padding: const EdgeInsets.all(1),
                          decoration: const BoxDecoration(color: AppColors.cLightPlusNumber, shape: BoxShape.circle),
                          child: Text(
                            '+${model.project.value.members.length - 5}',
                            style: Styles.style12400.copyWith(color: AppColors.cPlusNumber),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            OneStatusRow(
              button: false,
              assetsName: Assets.oneUser,
              nameRow: 'Engineer',
              anotherWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (model.project.value.leaders.isNotEmpty)
                    Obx(
                      () => Container(
                        constraints: BoxConstraints(maxWidth: context.screenWidth * .3),
                        child: Text(model.project.value.leaders.first.name, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  5.ESW(),
                  if (model.project.value.leaders.isNotEmpty)
                    Obx(
                      () => CacheImage(
                        imageUrl: model.project.value.leaders.first.image,
                        circle: true,
                        width: 18,
                        height: 18,
                      ),
                    ),
                ],
              ),
            ),
            BlocBuilder<OverViewProjectCubit, OverViewState>(
              builder: (context, state) {
                final cubit = OverViewProjectCubit.of(context);
                return OneStatusRow(
                  button: false,
                  assetsName: Assets.status,
                  nameRow: 'Status',
                  anotherWidget: Row(
                    children: [
                      Text(
                        model.project.value.status,
                        style: Styles.style14500.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      if (genderUser == RoleId.nine.name.tr) 10.ESW(),
                      if (genderUser == RoleId.nine.name.tr)
                        InkWell(
                          onTap: () {
                            statusProject(context, cubit);
                          },
                          child: SvgPicture.asset(
                            Assets.edit,
                            width: context.screenWidth * .04,
                            colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
            BlocBuilder<OverViewProjectCubit, OverViewState>(
              builder: (context, state) => OneStatusRow(
                button: false,
                assetsName: Assets.calenderProject,
                nameRow: 'Due Date',
                anotherWidget: Row(
                  children: [
                    Text(
                      model.project.value.deadline, //DateFormat('MMM dd,yyyy').format(OverViewProjectCubit.of(context).dueDate),
                      style: Styles.style14400,
                    ),
                    if (genderUser == RoleId.nine.name.tr) 10.ESW(),
                    if (genderUser == RoleId.nine.name.tr)
                      InkWell(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2050),
                            builder: (context, child) => Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(primary: AppColors.primaryColor, onBackground: AppColors.white),
                                ),
                                child: child!),
                          ).then((value) {
                            OverViewProjectCubit.of(context).changeDate(newDate: value!);
                          });
                        },
                        child: SvgPicture.asset(
                          Assets.edit,
                          width: context.screenWidth * .04,
                          colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (genderUser == RoleId.nine.name.tr)
              BlocBuilder<OverViewProjectCubit, OverViewState>(
                builder: (context, state) => OneStatusRow(
                  button: false,
                  assetsName: Assets.FileSVG,
                  nameRow: 'Attachment',
                  anotherWidget: SizedBox(
                    width: context.screenWidth * .4,
                    height: context.screenHeight * .04,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...List.generate(
                          OverViewProjectCubit.of(context).filesPicker.length,
                          (index) => InkWell(
                            onTap: () async {
                              OpenFile.open(OverViewProjectCubit.of(context).filesPicker[index].path);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 3).w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r), border: Border.all(color: AppColors.primaryColor, width: .7)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    Assets.FileSVG,
                                    width: context.screenWidth * .04,
                                    colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                                  ),
                                  5.ESW(),
                                  Text(
                                    OverViewProjectCubit.of(context)
                                        .filesPicker[index]
                                        .path
                                        .replaceAll('/data/user/0/com.rakelevators.codgoo/cache/file_picker/', ''),
                                    style: Styles.style12400.copyWith(color: AppColors.primaryColor, fontSize: 10.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            OverViewProjectCubit.of(context).pickAndOpenPdf();
                          },
                          style: const ButtonStyle(
                              shape: MaterialStatePropertyAll(LinearBorder.none), padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                          child: Container(
                            padding: const EdgeInsets.all(5).w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: AppColors.primaryColor, width: 2),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  Assets.addMaintenance,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ].paddingDirectional(end: context.screenWidth * .01),
                    ),
                  ),
                ),
              ),
          ].paddingDirectional(start: 5.w, top: 5.h),
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
