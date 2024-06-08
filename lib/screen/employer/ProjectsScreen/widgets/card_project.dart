import 'package:cnattendance/core/component/cache_image.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/model/project.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardProject extends StatelessWidget {
  final Project project;
  final int index;
  const CardProject({super.key, required this.project, required this.index});

  @override
  Widget build(BuildContext context) {
    double valueSliderWidget = project.progress.toDouble();
    return InkWell(
      onTap: () {
        final arguments = {
          'mainImage': Assets.temporaryProjects,
          'titleProject': project.name,
          'progress': valueSliderWidget,
          'id': project.id,
          'index':index,
        };
        Navigator.pushNamed(
          context,
          AppRoute.cardDetailsProject,
          arguments: arguments,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //10.ESH(),
              CacheImage(
                imageUrl: project.image,
                height: 150,
                width: double.infinity,
                boxFit: BoxFit.fill,
                profileImage: false,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: Styles.style18700,
                  ),
                  //  10.ESH(),
                  Html(
                    data: project.description,
                  ),
                  //20.ESH(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          ...List.generate(
                            project.members.length > 5
                                ? 5
                                : project.members.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(left: index * 12.0),
                              child: CacheImage(
                                imageUrl: project.members[index].image,
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
                              decoration: const BoxDecoration(
                                color: AppColors.cLightPlusNumber,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '+${project.members.length - 5}',
                                style: Styles.style12400
                                    .copyWith(color: AppColors.cPlusNumber),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        project.date,
                        style: Styles.style14400
                            .copyWith(color: AppColors.textColorTextFormField),
                      ),
                    ],
                  ),
                  //20.ESH(),
                  Row(
                    children: [
                      Expanded(
                        child: SliderTheme(
                          data: SliderThemeData(
                            thumbShape:
                                const RoundSliderOverlayShape(overlayRadius: 1),
                            activeTrackColor: AppColors.selectedCharData,
                            inactiveTrackColor: AppColors.cLightPlusNumber,
                            // trackHeight: context.screenHeight * .017,

                            trackShape: CustomTrackShape(),
                          ),
                          child: Slider(
                            max: 100,
                            value: valueSliderWidget,
                            thumbColor: Colors.transparent,
                            onChanged: (value) {
                              valueSliderWidget = value;
                            },
                          ),
                        ),
                      ),
                      Text(
                        '$valueSliderWidget %',
                        style: Styles.style14400
                            .copyWith(color: AppColors.textColorTextFormField),
                      ),
                    ],
                  ),
                  //20.ESH(),
                ].paddingDirectional(top: 10.h),
              ),
            ].paddingDirectional(start: 10.w, end: 10.w),
          ),
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
    return Rect.fromLTWH(
      trackLeft,
      trackTop,
      trackWidth * .95,
      trackHeight * 1.8,
    );
  }
}
