import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'app_router.dart';

Future<void> main() async {
  runApp(App());
}

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

final _appRouter = AppRouter();

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _appRouter.addListener(() {
      print('_appRouter.pageCount: ${_appRouter.pageCount}');
    });
  }

  @override
  Widget build(BuildContext context) {
    _appRouter.currentUrl;
    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        ),
      ],
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        // return const SizedBox.shrink();
        return AutoTabsRouter(
          // list of your tab routes
          // routes used here must be declaraed as children
          // routes of /dashboard
          routes: const [
            Page1tabRouter(),
            Page2tabRouter(),
          ],
          builder: (context, child, animation) {
            // obtain the scoped TabsRouter controller using context
            final tabsRouter = AutoTabsRouter.of(context);
            // Here we're building our Scaffold inside of AutoTabsRouter
            // to access the tabsRouter controller provided in this context
            //
            //alterntivly you could use a global key
            return Scaffold(
                body: FadeTransition(
                  opacity: animation,
                  // the passed child is techinaclly our animated selected-tab page
                  child: child,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                  items: [
                    BottomNavigationBarItem(
                        label: 'Page1', icon: Icon(Icons.abc)),
                    BottomNavigationBarItem(
                        label: 'Page2', icon: Icon(Icons.abc)),
                  ],
                ));
          },
        );
      }),
    );
  }
}

class Page1Outer extends StatelessWidget {
  const Page1Outer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Page1Outer'),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Page1'),
            TextButton(
              onPressed: () {
                _appRouter.push(Page1InnerRoute());
                // context.router.push(Page1InnerRoute());
              },
              child: Text('context.router.push(Page1InnerRoute());'),
            ),
            TextButton(
              onPressed: () {
                _appRouter.push(Page1OuterRoute());
                // context.router.push(Page1OuterRoute());
              },
              child: Text('context.router.push(Page1OuterRoute());'),
            ),
            TextButton(
              onPressed: () async {
                await _appRouter.navigate(Page2tabRouter());
                _appRouter.push(Page2InnerRoute());
              },
              child: Text('context.router.push(Page2Route());'),
            ),
          ],
        ),
      ),
    );
  }
}

class Page1Inner extends StatelessWidget {
  const Page1Inner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Page1Inner'),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Page2'),
      ),
    );
  }
}

class Page2Inner extends StatelessWidget {
  const Page2Inner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Page2Inner'),
          ],
        ),
      ),
    );
  }
}
