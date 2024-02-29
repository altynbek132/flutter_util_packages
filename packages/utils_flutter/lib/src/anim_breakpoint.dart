import 'package:flutter/animation.dart';

extension AnimationControllerExtension on AnimationController {
  void runOnBreakpointValue(double value, VoidCallback cb) {
    var breakpointHit = false;
    listener() {
      if (breakpointHit || this.value < value) return;
      breakpointHit = true;
      cb();
      removeListener(listener);
    }

    addListener(listener);
  }

  void runOnBreakpointTime(Duration time, VoidCallback cb) {
    var breakpointHit = false;
    listener() {
      if (breakpointHit || timeFromStart < time) return;
      breakpointHit = true;
      cb();
    }

    addListener(listener);
  }

  Duration get timeFromStart {
    return duration! * value;
  }
}
