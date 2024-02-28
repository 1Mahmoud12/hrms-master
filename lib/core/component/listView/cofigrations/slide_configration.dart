import 'package:cnattendance/core/component/listView/animate_list_view_widget.dart';
import 'package:flutter/material.dart';

class SlideConfiguration {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final double? verticalOffset;
  final double? horizontalOffset;

  SlideConfiguration({
    this.duration = defaultAnimationDuration,
    this.delay = defaultAnimationDelay,
    this.curve = Curves.easeOutQuart,
    this.verticalOffset = 100.0,
    this.horizontalOffset = 0.0,
  });
}
