import 'package:flutter/material.dart';

class SafeAreaOnly extends StatelessWidget {
  const SafeAreaOnly({
    super.key,
    this.left = false,
    this.top = false,
    this.right = false,
    this.bottom = false,
  });
  const SafeAreaOnly.top({
    super.key,
    this.left = false,
    this.top = true,
    this.right = false,
    this.bottom = false,
  });
  const SafeAreaOnly.bottom({
    super.key,
    this.left = false,
    this.top = false,
    this.right = false,
    this.bottom = true,
  });
  const SafeAreaOnly.left({
    super.key,
    this.left = true,
    this.top = false,
    this.right = false,
    this.bottom = false,
  });
  const SafeAreaOnly.right({
    super.key,
    this.left = false,
    this.top = false,
    this.right = true,
    this.bottom = false,
  });

  final bool left;
  final bool top;
  final bool right;
  final bool bottom;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: const SizedBox.shrink(),
    );
  }
}
