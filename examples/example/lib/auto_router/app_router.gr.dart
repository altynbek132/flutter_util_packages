// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    DashboardPageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DashboardPage(),
      );
    },
    Page1OuterRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const Page1Outer(),
      );
    },
    Page1tabRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    Page2tabRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    Page1Route.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const Page1(),
        fullscreenDialog: true,
      );
    },
    Page1InnerRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const Page1Inner(),
        fullscreenDialog: true,
      );
    },
    Page2Route.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const Page2(),
      );
    },
    Page2InnerRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const Page2Inner(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          DashboardPageRoute.name,
          path: '/',
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: DashboardPageRoute.name,
              redirectTo: 'page1tab',
              fullMatch: true,
            ),
            RouteConfig(
              Page1tabRouter.name,
              path: 'page1tab',
              parent: DashboardPageRoute.name,
              children: [
                RouteConfig(
                  Page1Route.name,
                  path: '',
                  parent: Page1tabRouter.name,
                ),
                RouteConfig(
                  Page1InnerRoute.name,
                  path: 'Page1Inner',
                  parent: Page1tabRouter.name,
                ),
              ],
            ),
            RouteConfig(
              Page2tabRouter.name,
              path: 'page2tab',
              parent: DashboardPageRoute.name,
              children: [
                RouteConfig(
                  Page2Route.name,
                  path: '',
                  parent: Page2tabRouter.name,
                ),
                RouteConfig(
                  Page2InnerRoute.name,
                  path: 'Page2Inner',
                  parent: Page2tabRouter.name,
                ),
              ],
            ),
          ],
        ),
        RouteConfig(
          Page1OuterRoute.name,
          path: '/page1-outer',
        ),
      ];
}

/// generated route for
/// [DashboardPage]
class DashboardPageRoute extends PageRouteInfo<void> {
  const DashboardPageRoute({List<PageRouteInfo>? children})
      : super(
          DashboardPageRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'DashboardPageRoute';
}

/// generated route for
/// [Page1Outer]
class Page1OuterRoute extends PageRouteInfo<void> {
  const Page1OuterRoute()
      : super(
          Page1OuterRoute.name,
          path: '/page1-outer',
        );

  static const String name = 'Page1OuterRoute';
}

/// generated route for
/// [EmptyRouterPage]
class Page1tabRouter extends PageRouteInfo<void> {
  const Page1tabRouter({List<PageRouteInfo>? children})
      : super(
          Page1tabRouter.name,
          path: 'page1tab',
          initialChildren: children,
        );

  static const String name = 'Page1tabRouter';
}

/// generated route for
/// [EmptyRouterPage]
class Page2tabRouter extends PageRouteInfo<void> {
  const Page2tabRouter({List<PageRouteInfo>? children})
      : super(
          Page2tabRouter.name,
          path: 'page2tab',
          initialChildren: children,
        );

  static const String name = 'Page2tabRouter';
}

/// generated route for
/// [Page1]
class Page1Route extends PageRouteInfo<void> {
  const Page1Route()
      : super(
          Page1Route.name,
          path: '',
        );

  static const String name = 'Page1Route';
}

/// generated route for
/// [Page1Inner]
class Page1InnerRoute extends PageRouteInfo<void> {
  const Page1InnerRoute()
      : super(
          Page1InnerRoute.name,
          path: 'Page1Inner',
        );

  static const String name = 'Page1InnerRoute';
}

/// generated route for
/// [Page2]
class Page2Route extends PageRouteInfo<void> {
  const Page2Route()
      : super(
          Page2Route.name,
          path: '',
        );

  static const String name = 'Page2Route';
}

/// generated route for
/// [Page2Inner]
class Page2InnerRoute extends PageRouteInfo<void> {
  const Page2InnerRoute()
      : super(
          Page2InnerRoute.name,
          path: 'Page2Inner',
        );

  static const String name = 'Page2InnerRoute';
}
