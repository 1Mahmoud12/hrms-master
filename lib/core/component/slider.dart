import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SliderCustom extends StatefulWidget {
  final double valueSlider;

  const SliderCustom({super.key, required this.valueSlider});

  @override
  State<SliderCustom> createState() => _SliderCustomState();
}

class _SliderCustomState extends State<SliderCustom> {
  @override
  Widget build(BuildContext context) {
    final double valueSlider = widget.valueSlider;

    return Row(
      children: [
        Expanded(
          child: CircularPercentIndicator(
            radius: 60,
            lineWidth: 8.0,
            animation: true,
            percent: valueSlider / 100,
            center: Text(
              '$valueSlider%',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp, color: AppColors.primaryColor),
            ),
            /*footer: const Text(
              'Sales this week',
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),*/
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}

/*
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
              value: valueSlider,
              thumbColor: Colors.transparent,
              onChanged: (value) {
                valueSlider = value;
              },
            ),
          ),
        ),
        Text(
          '$valueSlider %',
          style: Styles.style14400.copyWith(color: AppColors.textColorTextFormField),
        ),
*/

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
