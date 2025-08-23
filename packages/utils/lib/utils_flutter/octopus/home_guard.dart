import 'dart:async';

import 'package:octopus/octopus.dart';
import 'package:utils/utils_dart/ll.dart';

/// Check routes always contain the home route at the first position.
/// Only exception for not authenticated users.
class HomeGuard extends OctopusGuard {
  HomeGuard({required this.getIsAuthenticated, required this.homeRoute, this.verbose = false});

  final OctopusRoute homeRoute;
  final FutureOr<bool> Function() getIsAuthenticated;

  final bool verbose;

  void _log(Object message) {
    if (verbose) {
      ll.v6(message);
    }
  }

  @override
  FutureOr<OctopusState> call(
    List<OctopusHistoryEntry> history,
    OctopusState$Mutable state,
    Map<String, Object?> context,
  ) async {
    _log('HomeGuard called with ${state.children.length} routes');

    final isAuthenticated = await getIsAuthenticated();
    _log('Authentication status: $isAuthenticated');

    if (isAuthenticated == false) {
      _log('User not authenticated, returning state unchanged');
      return state;
    }

    if (state.isEmpty) {
      _log('State is empty, fixing by adding home route');
      return _fix(state);
    }

    final count = state.findAllByName(homeRoute.name).length;
    _log('Found ${count} instances of home route "${homeRoute.name}"');

    if (count != 1) {
      _log('Invalid home route count ($count), expected 1, fixing state');
      return _fix(state);
    }

    final firstRouteName = state.children.first.name;
    _log('First route is "$firstRouteName", expected "${homeRoute.name}"');

    if (firstRouteName != homeRoute.name) {
      _log('Home route not at first position, fixing state');
      return _fix(state);
    }

    _log('State is valid, returning unchanged');
    return state;
  }

  /// Change the state of the nested navigation.
  OctopusState _fix(OctopusState$Mutable state) {
    _log('Fixing state: clearing and adding home route "${homeRoute.name}"');

    return state
      ..clear()
      ..putIfAbsent(homeRoute.name, () => homeRoute.node());
  }
}
