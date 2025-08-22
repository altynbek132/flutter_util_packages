import 'dart:async';

import 'package:octopus/octopus.dart';
import 'package:utils/utils_flutter/octopus/octopus_tab_route.dart';

class TabsGuard extends OctopusGuard {
  TabsGuard({required this.tabRoutes, required this.tabsRootRoute});

  final List<OctopusTabRoute> tabRoutes;
  final OctopusRoute tabsRootRoute;

  @override
  FutureOr<OctopusState> call(
    List<OctopusHistoryEntry> history,
    OctopusState$Mutable state,
    Map<String, Object?> context,
  ) {
    final tabsRootNode = state.findByName(tabsRootRoute.name);
    if (tabsRootNode == null) return state;

    // Remove all nested routes except of `GameRootScreenTabs`.
    tabsRootNode.removeWhere(
      (node) => !tabRoutes.map((e) => e.name).contains(node.name),
      recursive: false,
    );

    // Upsert each tab node if not exists.
    for (final tab in tabRoutes) {
      final tabNode = tabsRootNode.putIfAbsent(tab.name, () => OctopusNode.mutable(tab.name));
      if (!tabNode.hasChildren) {
        tabNode.add(OctopusNode.mutable(tab.toRoute().name));
      }
    }

    return state;
  }
}
