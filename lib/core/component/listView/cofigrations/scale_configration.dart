import 'package:flutter/animation.dart';

import '../animate_list_view_widget.dart';

class ScaleConfiguration {
  final Duration? duration;
  final Duration? delay;
  final Curve curve;
  final double scale;

  ScaleConfiguration({
    this.duration = const Duration(milliseconds: 400),
    this.delay = defaultAnimationDelay,
    this.curve = Curves.ease,
    this.scale = 0.0,
  });
}
