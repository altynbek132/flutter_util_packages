import 'package:flutter/material.dart';

class InvisibilityKeepSize extends StatelessWidget {
  const InvisibilityKeepSize({
    super.key,
    required this.child,
    this.active = true,
  });

  final Widget child;
  final bool active;

  @override
  Widget build(BuildContext context) {
    if (!active) {
      return child;
    }
    return Visibility(
      visible: false,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: child,
    );
  }
}
