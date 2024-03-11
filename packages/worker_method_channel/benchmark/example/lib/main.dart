import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'dart:js_interop' as js_interop;
import 'package:web/web.dart' as web;

import 'package:flutter/material.dart';
import 'package:worker_method_channel/worker_method_channel.dart';

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
          TextButton(
            onPressed: () {
              test();
            },
            child: Text('test()'),
          ),
          TextButton(
            onPressed: () {
              benchmark();
            },
            child: Text('benchmark()'),
          ),
        ],
      ),
    );
  }
}

void benchmark() {
  final message = Message(
    requestId: 0,
    method: 'method',
    body: {'key': Uint8List.fromList(List.generate(1000000, (index) => 0))},
  );

  {
    final sw = Stopwatch()..start();
    for (var i = 0; i < 100000; i++) {
      message.jsify().dartify();
    }
    print(
        "sw.elapsedMilliseconds jsify dartify object: ${sw.elapsedMilliseconds}");
  }
  {
    final map = message.toMap();
    final sw = Stopwatch()..start();
    for (var i = 0; i < 100000; i++) {
      map.jsify().dartify();
    }
    print(
        "sw.elapsedMilliseconds jsify dartify map: ${sw.elapsedMilliseconds}");
  }
  {
    final sw = Stopwatch()..start();
    for (var i = 0; i < 100000; i++) {
      message.toJSBox.toDart;
    }
    print(
        "sw.elapsedMilliseconds toJSBox.toDart object: ${sw.elapsedMilliseconds}");
  }
  {
    final sw = Stopwatch()..start();
    final map = message.toMap();
    for (var i = 0; i < 100000; i++) {
      map.toJSBox.toDart;
    }
    print(
        "sw.elapsedMilliseconds toJSBox.toDart map: ${sw.elapsedMilliseconds}");
  }
}

Future<void> test() async {
  final messages = [
    // Message(requestId: 0, method: 'method', body: 'body'),
    // Message(requestId: 0, method: 'method', body: {'key': 'value'}),
    Message(
        requestId: 0,
        method: 'method',
        body: {'key': Uint8List.fromList(List.generate(3, (index) => index))}),
  ];

  for (final message in messages) {
    {
      final jsify = message.jsify();
      web.console.log('jsify'.toJS);
      web.console.log(jsify);
      final dartify = jsify.dartify() as Message;
      print("dartified: ${dartify}");
    }
    {
      final toJSBox = message.toJSBox;
      web.console.log('toJSBox'.toJS);
      web.console.log(toJSBox);
      final toDart = toJSBox.toDart as Message;
      print("toDart: ${toDart}");
    }
    {
      final toJSBox = message.toMap().toJSBox;
      web.console.log('toMap().toJSBox'.toJS);
      web.console.log(toJSBox);
      final toDart = toJSBox.toDart as Map<String, dynamic>;
      print("toDart: ${toDart}");
    }
  }
}

extension MessageMapExtension on Message {
  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'method': method,
      'body': body,
      'exception': exception,
    };
  }
}
