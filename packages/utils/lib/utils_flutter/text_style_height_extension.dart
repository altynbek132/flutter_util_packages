import 'package:flutter/material.dart';

extension TextStyleHeightExtension on TextStyle {
  TextStyle withHeight(double height) => copyWith(height: height / fontSize!);
}
