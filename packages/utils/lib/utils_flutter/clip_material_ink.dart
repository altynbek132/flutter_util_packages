import 'package:flutter/material.dart';

class ClipMaterialInk extends StatelessWidget {
  const ClipMaterialInk({
    super.key,
    this.borderRadius,
    required this.child,
    this.oval,
  });

  final BorderRadius? borderRadius;
  final Widget child;
  final bool? oval;

  @override
  Widget build(BuildContext context) {
    if (oval == true) {
      return ClipOval(
        child: Material(
          color: Colors.transparent,
          child: child,
        ),
      );
    }
    if (borderRadius == null) {
      return Material(
        color: Colors.transparent,
        child: child,
      );
    }
    return ClipRRect(
      borderRadius: borderRadius!,
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}
