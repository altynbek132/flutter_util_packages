import 'dart:async';

import 'package:octopus/octopus.dart';
import 'package:utils/utils_flutter/octopus/authentication_guard.dart';

/// Check routes always contain the home route at the first position.
/// Only exception for not authenticated users.
class HomeGuard extends OctopusGuard {
  HomeGuard(this.homeRoute);

  final OctopusRoute homeRoute;

  @override
  FutureOr<OctopusState> call(
    List<OctopusHistoryEntry> history,
    OctopusState$Mutable state,
    Map<String, Object?> context,
  ) {
    // If the user is not authenticated, do nothing.
    // The home route should not be in the state.
    if (context[AuthenticationGuard.isAuthenticatedKey] == false) return state;

    // Home route should be the first route in the state
    // and should be only one in whole state.
    if (state.isEmpty) return _fix(state);
    final count = state.findAllByName(homeRoute.name).length;
    if (count != 1) return _fix(state);
    if (state.children.first.name != homeRoute.name) return _fix(state);
    return state;
  }

  /// Change the state of the nested navigation.
  OctopusState _fix(OctopusState$Mutable state) => state
    ..clear()
    ..putIfAbsent(homeRoute.name, () => homeRoute.node());
}
