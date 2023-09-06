import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:awesome_extensions/awesome_extensions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:provider/provider.dart';

class Asdf extends StatelessWidget {
  const Asdf({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Provider.value(
        value: Screen2Data('asfd'),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ListView(
            children: [
              TextButton(
                onPressed: () {
                  context.pushNamed('screen2');
                },
                child: Text('push 2'),
              ),
              context.mediaQueryViewInsets.bottom.heightBox,
            ],
          ),
        ),
      );
    });
  }
}

class Screen2Data {
  final String text;

  Screen2Data(this.text);
}

class Screen2 extends StatelessWidget {
  final String text;
  const Screen2({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    ModalRoute.of(context)!.settings.arguments;
    return Observer(builder: (context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          children: [
            Text(text),
            context.mediaQueryViewInsets.bottom.heightBox,
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
      home: Asdf(),
      routes: {'screen2': (context) => Screen2(text: context.read<Screen2Data>().text)},
    );
  }
}

Future<void> main() async {
  runApp(App());
}
