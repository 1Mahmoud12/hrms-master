import 'package:cnattendance/core/component/listView/animate_list_view_widget.dart';
import 'package:flutter/animation.dart';

class FadeInConfiguration {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;

  FadeInConfiguration({
    this.duration = defaultAnimationDuration,
    this.delay = defaultAnimationDelay,
    this.curve = Curves.easeOutQuart,
  });
}
