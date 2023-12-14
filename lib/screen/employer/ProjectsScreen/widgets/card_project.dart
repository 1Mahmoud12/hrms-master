import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardProject extends StatelessWidget {
  final double valueSlider;

  const CardProject({super.key, required this.valueSlider});

  @override
  Widget build(BuildContext context) {
    double valueSliderWidget = valueSlider;
    const String titleProject = 'King Hotel Maintenance';
    const String subTitleProject = 'Maintenance of 12 elevators at the King Hotel';
    return InkWell(
      onTap: () {
        final arguments = {
          'mainImage': Assets.temporaryProjects,
          'titleProject': titleProject,
          'subTitleProject': subTitleProject,
          'progress': valueSliderWidget,
        };
        Navigator.pushNamed(context, AppRoute.cardDetailsProject, arguments: arguments);
      },
      child: Container(
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //10.ESH(),
              Image.asset(
                Assets.temporaryProjects,
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
                  //20.ESH(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          ...List.generate(
                            5,
                            (index) => Padding(
                              padding: EdgeInsets.only(left: index * 18.0),
                              child: Image.asset(Assets.temporaryPerson),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5 * 18.0),
                            child: Container(
                              padding: EdgeInsets.all(context.screenWidth * .015),
                              decoration: const BoxDecoration(color: AppColors.cLightPlusNumber, shape: BoxShape.circle),
                              child: Text(
                                '+5',
                                style: Styles.style12400.copyWith(color: AppColors.cPlusNumber),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '8 Days Left',
                        style: Styles.style14400.copyWith(color: AppColors.textColorTextFormField),
                      ),
                    ],
                  ),
                  //20.ESH(),
                  Row(
                    children: [
                      Expanded(
                        child: SliderTheme(
                          data: SliderThemeData(
                            thumbShape: const RoundSliderOverlayShape(overlayRadius: 1),
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
                        style: Styles.style14400.copyWith(color: AppColors.textColorTextFormField),
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
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth * .95, trackHeight * 1.8);
  }
}
