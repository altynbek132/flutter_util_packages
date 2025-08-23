import 'dart:async';

import 'package:octopus/octopus.dart';
import 'package:utils/utils_dart.dart';
import 'package:utils/utils_flutter/octopus/octopus_tab_route.dart';

class TabsGuard extends OctopusGuard {
  TabsGuard({required this.tabRoutes, required this.tabsRootRoute, this.verbose = false});

  final List<OctopusTabRoute> tabRoutes;
  final OctopusRoute tabsRootRoute;

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
  ) {
    _log('TabsGuard: Starting guard execution');
    _log('TabsGuard: Looking for tabs root route: ${tabsRootRoute.name}');

    final tabsRootNode = state.findByName(tabsRootRoute.name);
    if (tabsRootNode == null) {
      _log('TabsGuard: Tabs root node not found, returning unchanged state');
      return state;
    }

    _log('TabsGuard: Found tabs root node with ${tabsRootNode.children.length} children');

    final tabNames = tabRoutes.map((e) => e.name).toList();
    _log('TabsGuard: Expected tab names: $tabNames');

    final childrenToRemove = tabsRootNode.children
        .where(
          (node) => !tabNames.contains(node.name),
        )
        .toList();

    if (childrenToRemove.isNotEmpty) {
      _log(
          'TabsGuard: Removing ${childrenToRemove.length} unexpected children: ${childrenToRemove.map((e) => e.name).toList()}');
    }

    tabsRootNode.removeWhere(
      (node) => !tabNames.contains(node.name),
      recursive: false,
    );

    _log('TabsGuard: Upserting tab nodes');
    for (final tab in tabRoutes) {
      _log('TabsGuard: Processing tab: ${tab.name}');
      final tabNode = tabsRootNode.putIfAbsent(tab.name, () {
        _log('TabsGuard: Creating new tab node: ${tab.name}');
        return OctopusNode.mutable(tab.name);
      });

      if (!tabNode.hasChildren) {
        final defaultRouteName = tab.toRoute().name;
        _log('TabsGuard: Adding default route to tab ${tab.name}: $defaultRouteName');
        tabNode.add(OctopusNode.mutable(defaultRouteName));
      } else {
        _log('TabsGuard: Tab ${tab.name} already has ${tabNode.children.length} children');
      }
    }

    _log('TabsGuard: Guard execution completed');
    return state;
  }
}
