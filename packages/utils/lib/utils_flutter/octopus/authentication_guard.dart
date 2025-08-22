import 'dart:async';

import 'package:l/l.dart';
import 'package:octopus/octopus.dart';

/// A router guard that checks if the user is authenticated.
class AuthenticationGuard extends OctopusGuard {
  AuthenticationGuard({
    required FutureOr<bool> Function() checkAuth,
    required Set<String> authRoutes,
    required OctopusState signinNavigation,
    required OctopusState homeNavigation,
    OctopusState? lastNavigation,
    super.refresh,
  })  : _checkAuth = checkAuth,
        _authRoutes = authRoutes,
        _homeNavigation = homeNavigation,
        _signinNavigation = signinNavigation;

  /// Get the current user.
  final FutureOr<bool> Function() _checkAuth;

  /// Routes names that stand for the authentication routes.
  final Set<String> _authRoutes;

  /// The navigation to use when the user is not authenticated.
  final OctopusState _signinNavigation;

  /// The navigation to use when the user is authenticated.
  final OctopusState _homeNavigation;

  static const isAuthenticatedKey = 'isAuthenticated';

  @override
  FutureOr<OctopusState> call(
    List<OctopusHistoryEntry> history,
    OctopusState$Mutable state,
    Map<String, Object?> context,
  ) async {
    final isAuthenticated = await _checkAuth(); // Get the current user.
    context[isAuthenticatedKey] = isAuthenticated;
    final isAuthNav = state.children.any((child) => _authRoutes.contains(child.name));
    l.d('AuthenticationGuard: isAuthNav: $isAuthNav, isAuthenticated: $isAuthenticated');
    if (isAuthNav) {
      // New state is an authentication navigation.
      if (isAuthenticated) {
        // User authenticated.
        // Remove any navigation that is an authentication navigation.
        final removed = state.removeWhere((child) => _authRoutes.contains(child.name));
        l.d('AuthenticationGuard: removed ${removed.map((child) => child.name)} authentication routes');
        // Restore the last navigation when the user is authenticated
        // if the state contains only the authentication routes.
        return state.isEmpty ? _homeNavigation : state;
      } else {
        // User not authenticated.
        // Remove any navigation that is not an authentication navigation.
        final removed = state.removeWhere((child) => !_authRoutes.contains(child.name));
        l.d('AuthenticationGuard: removed ${removed.map((child) => child.name)} authentication routes');
        // Add the signin navigation if the state is empty.
        // Or return the state if it contains the signin navigation.
        return state.isEmpty ? _signinNavigation : state;
      }
    } else {
      // New state is not an authentication navigation.
      if (isAuthenticated) {
        // User authenticated.
        return super.call(history, state, context);
      } else {
        // User not authenticated.
        // Replace the current navigation with the signin navigation.
        return _signinNavigation;
      }
    }
  }
}
