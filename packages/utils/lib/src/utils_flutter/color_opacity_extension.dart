// ignore: unused_import

import 'package:flutter/material.dart';

extension ColorOpacityExtension on Color {
  Color withOpacity_(double opacity) => withAlpha((255 * opacity).round());
}
