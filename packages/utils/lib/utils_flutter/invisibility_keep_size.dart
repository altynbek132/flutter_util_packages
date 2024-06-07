import 'package:flutter/material.dart';

class InvisibilityKeepSize extends StatelessWidget {
  const InvisibilityKeepSize({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: child,
    );
  }
}
