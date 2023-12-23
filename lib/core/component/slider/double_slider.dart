import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DoubleCustomSlider extends StatefulWidget {
  final double value1;
  final double value2;

  final Color color1;
  final Color color2;

  const DoubleCustomSlider({
    super.key,
    required this.value1,
    required this.value2,
    required this.color1,
    required this.color2,
  });

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<DoubleCustomSlider> {
  double _currentValue1 = 0.0;
  double _currentValue2 = 0.0;

  @override
  void initState() {
    _currentValue1 = widget.value1;
    _currentValue2 = widget.value2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * .2,
      child: SfRadialGauge(
        animationDuration: 10000,
        enableLoadingAnimation: false,
        axes: <RadialAxis>[
          RadialAxis(
            endAngle: 490,
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: 0,
                endValue: widget.value1,
                color: widget.color1,
              ),
              GaugeRange(
                startValue: _currentValue1,
                endValue: _currentValue1 + _currentValue2,
                color: widget.color2,
              ),
            ],
            pointers: <GaugePointer>[
              MarkerPointer(
                value: _currentValue1 / 2,
                // Set the value where you want the text pointer
                markerType: MarkerType.text,
                markerOffset: -20,
                markerHeight: 30,
                markerWidth: 30,
                text: 'Finished',

                // Set the text value
                borderColor: Colors.black,
              ),
              MarkerPointer(
                value: _currentValue1 + (_currentValue2 / 2),
                // Set the value where you want the text pointer
                markerType: MarkerType.text,
                markerOffset: -20,
                markerHeight: 30,
                markerWidth: 30,
                text: 'Pending', // Set the text value
              ),
            ],
            // labelFormat: '',
            showLabels: false,
            showLastLabel: true,

            annotations: [
              GaugeAnnotation(
                widget: Text(
                  '${widget.value1} %',
                  style: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.w700, color: AppColors.textColorTextFormField),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
