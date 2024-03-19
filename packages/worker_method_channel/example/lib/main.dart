import 'package:js_import/js_import.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'dart:js_interop' as js_interop;

import 'package:worker_method_channel/worker_method_channel.dart';

Future<void> main() async {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final WebWorkerMethodChannel channel;

  @override
  void initState() {
    super.initState();
    () async {
      channel = WebWorkerMethodChannel(name: './web/worker_js.dart.js');
      channel.setMethodCallHandler('echo', (body) {
        print("🚀~main.dart:29~_MainAppState~");
        return body;
      });
    }();
  }

  Future<void> test() async {
    final res = await channel.invokeMethod('echo', 'hi');
    print("🚀~main.dart:33~_MainAppState~Future<void>test~res: ${res}");
  }

  @override
  void dispose() {
    channel.disposeAsync();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Hello World!'),
              TextButton(
                onPressed: () {
                  test();
                },
                child: Text('test()'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
