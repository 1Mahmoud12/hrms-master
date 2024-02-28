import 'package:cnattendance/core/component/listView/animate_list_view_widget.dart';
import 'package:flutter/material.dart';

class FlipConfiguration {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final FlipAxisClass flipAxis;

  FlipConfiguration({
    this.duration = defaultAnimationDuration,
    this.delay = defaultAnimationDelay,
    this.curve = Curves.easeOutQuart,
    this.flipAxis = FlipAxisClass.x,
  });
}
