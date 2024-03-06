import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(
    MaterialApp(
      scrollBehavior: const MaterialScrollBehavior()
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      home: Demo(),
    ),
  );
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text('Demo'),
        ],
      ),
    );
  }
}
