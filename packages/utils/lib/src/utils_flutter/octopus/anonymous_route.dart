// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';

class AnonymousRoute with OctopusRoute {
  // ignore: unused_element_parameter
  const AnonymousRoute(
    this.name, {
    this.title,
    required this.builder_,
  });

  @override
  final String name;

  @override
  final String? title;

  final Widget Function(BuildContext, OctopusState, OctopusNode) builder_;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) {
    return builder_(context, state, node);
  }
}
