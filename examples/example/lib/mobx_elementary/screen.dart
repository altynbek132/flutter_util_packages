import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:awesome_extensions/awesome_extensions.dart';

import 'screen_wm.dart';

class Screen extends ElementaryWidget<ScreenWm> {
  const Screen({
    super.key,
  }) : super(screenWmFactory);

  @override
  Widget build(wm, context) {
    return Observer(builder: (context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          children: [
            SizedBox.square(
              dimension: 50,
              child: Container(
                color: Colors.red,
              ),
            ),
            Text(wm.n.value.toString()),
            TextButton(
              onPressed: () {
                wm.inc();
              },
              child: Text('inc'),
            ),
            (context.mediaQueryViewInsets.bottom).heightBox,
          ],
        ),
      );
    });
  }
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screen(),
    );
  }
}

Future<void> main() async {
  runApp(App());
}
