import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:flutter/material.dart';

import 'main.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: '',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      path: '/',
      page: DashboardPage,
      children: [
        AutoRoute(
          initial: true,
          path: 'page1tab',
          name: 'Page1tabRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              initial: true,
              path: '',
              page: Page1,
              fullscreenDialog: true,
            ),
            AutoRoute(
              path: 'Page1Inner',
              page: Page1Inner,
              fullscreenDialog: true,
            ),
          ],
        ),
        AutoRoute(
          path: 'page2tab',
          name: 'Page2tabRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: Page2),
            AutoRoute(path: 'Page2Inner', page: Page2Inner),
          ],
        ),
      ],
    ),
    AutoRoute(
      page: Page1Outer,
    ),
  ],
)
class AppRouter extends _$AppRouter {}
